--------------------------------------------------------
--  DDL for Package Body PQFXVERIFICACIONTEL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQFXVERIFICACIONTEL" 
IS
   csl_1   CONSTANT INTEGER := 1;
   csl_2   CONSTANT INTEGER := 2;
   csl_0   CONSTANT INTEGER := 0;
   csl_4   CONSTANT INTEGER := 4;
   csl_3   CONSTANT INTEGER := 3;
   vl_user          VARCHAR2 (30) := USER;

   PROCEDURE sputelmail (pa_pais                IN     NUMBER,
                         pa_canal               IN     NUMBER,
                         pa_sucursal            IN     NUMBER,
                         pa_folio               IN     NUMBER,
                         pa_telefono            IN     NUMBER,
                         pa_tipo_telefono       IN     NUMBER,
                         pa_email               IN     VARCHAR2,
                         pa_codigo_validacion      OUT NUMBER,
                         pa_codigo                 OUT NUMBER,
                         pa_mensaje                OUT VARCHAR2)
   AS
      vl_numero_asignaciones   NUMBER;
      vl_tiene_telefono        NUMBER;
      vl_fiidtelefono          NUMBER;
   BEGIN
      IF pa_email IS NOT NULL
      THEN
         INSERT INTO scsisges.tadatosmail (fipais,
                                           ficanal,
                                           fisucursal,
                                           fifolio,
                                           fcmail)
              VALUES (pa_pais,
                      pa_canal,
                      pa_sucursal,
                      pa_folio,
                      pa_email);

         pa_codigo := csl_2; 
      END IF;

      IF pa_telefono IS NOT NULL AND pa_tipo_telefono IS NOT NULL
      THEN
         SELECT COUNT (1)
           INTO vl_numero_asignaciones
           FROM scsisges.tatelefonos t
          WHERE t.fntelefono = pa_telefono;

         IF vl_numero_asignaciones >= csl_3
         THEN
            pa_codigo := csl_3; 
         ELSE
            MERGE INTO scsisges.tatelefonos destino
                 USING (SELECT pa_pais fipais,
                               pa_canal ficanal,
                               pa_sucursal fisucursal,
                               pa_folio fifolio,
                               pa_telefono fntelefono,
                               pa_tipo_telefono fiidtipo
                          FROM DUAL) origen
                    ON (    destino.fipais = origen.fipais
                        AND destino.ficanal = origen.ficanal
                        AND destino.fisucursal = origen.fisucursal
                        AND destino.fifolio = origen.fifolio
                        AND destino.fntelefono = origen.fntelefono)
            WHEN MATCHED
            THEN
               UPDATE SET destino.fistatus = csl_0,            
                          destino.fiidtipo = origen.fiidtipo,
                          destino.fdmodificacion = SYSDATE,
                          destino.fcusrmodifico = vl_user
            WHEN NOT MATCHED
            THEN
               INSERT     (fiidtelefono,
                           fipais,
                           ficanal,
                           fisucursal,
                           fifolio,
                           fntelefono,
                           fistatus,
                           fiidtipo,
                           fcusrmodifico,
                           fdmodificacion)
                   VALUES (scsisges.seqtidelefono.NEXTVAL,
                           origen.fipais,
                           origen.ficanal,
                           origen.fisucursal,
                           origen.fifolio,
                           origen.fntelefono,
                           csl_0,
                           origen.fiidtipo,
                           vl_user,
                           SYSDATE);

            pa_codigo := csl_2; 

            IF pa_tipo_telefono = csl_2
            THEN
               SELECT fiidtelefono
                 INTO vl_fiidtelefono
                 FROM scsisges.tatelefonos
                WHERE     fipais = pa_pais
                      AND ficanal = pa_canal
                      AND fisucursal = pa_sucursal
                      AND fifolio = pa_folio
                      AND fntelefono = pa_telefono;

               pa_codigo_validacion :=
                  scsisges.pqfxverificaciontel.fngenerafolio (pa_telefono);

               MERGE INTO scsisges.tafoliotelefono destino
                    USING (SELECT vl_fiidtelefono fiidtelefono,
                                  pa_codigo_validacion fiidfolio
                             FROM DUAL) origen
                       ON (destino.fiidtelefono = origen.fiidtelefono)
               WHEN MATCHED
               THEN
                  UPDATE SET destino.fistatus = csl_0,         
                             destino.fdstatus = SYSDATE,
                             destino.fdmodificacion = SYSDATE,
                             destino.fcusrmodifico = vl_user
               WHEN NOT MATCHED
               THEN
                  INSERT     (fiidfolio,
                              fiidtelefono,
                              fdstatus,
                              fistatus,
                              fcusrmodifico,
                              fdmodificacion)
                      VALUES (origen.fiidfolio,
                              origen.fiidtelefono,
                              SYSDATE,
                              csl_0,
                              vl_user,
                              SYSDATE);

               SELECT t.fiidfolio
                 INTO pa_codigo_validacion
                 FROM scsisges.tafoliotelefono t
                WHERE t.fiidtelefono = vl_fiidtelefono;

               pa_codigo := csl_1; 
            END IF;
         END IF;
      END IF;

      pa_mensaje := 'OK';
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codigo_validacion := NULL;
         pa_codigo := csl_4;
         pa_mensaje :=
            SUBSTR (SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                    0,
                    600);

         scsisges.sperrores (SYSDATE,
                             pa_codigo,
                             pa_mensaje,
                             'SCSISGES.pqfxverificaciontel.sputelmail');
   END;

   PROCEDURE spagregatelefono (pa_pais            IN     NUMBER,
                               pa_canal           IN     NUMBER,
                               pa_sucursal        IN     NUMBER,
                               pa_folio           IN     NUMBER,
                               pa_tipotelefono    IN     NUMBER,
                               pa_telefono        IN     NUMBER,
                               pa_foliogenerado      OUT NUMBER,
                               pa_status             OUT NUMBER,
                               pa_codigo             OUT INTEGER,
                               pa_mensaje            OUT VARCHAR2)
   IS
      vl_contadorid    NUMBER := 0;
      vl_existetel     NUMBER := 0;
      vl_idfolio       NUMBER (6) := 0;
      vl_noasignable   NUMBER := 0;
      vl_idtelefono    NUMBER := 0;
   BEGIN
      SELECT COUNT (1)
        INTO vl_existetel
        FROM scsisges.tatelefonos t
       WHERE     t.fntelefono = pa_telefono
             AND t.fipais = pa_pais
             AND t.ficanal = pa_canal
             AND t.fisucursal = pa_sucursal
             AND t.fifolio = pa_folio;

      IF vl_existetel = csl_0
      THEN
         IF pa_tipotelefono = csl_2
         THEN
            /*validar si el telefono fue asignado n veces*/
            SELECT COUNT (1)
              INTO vl_noasignable
              FROM scsisges.tatelefonos t
             WHERE t.fntelefono = pa_telefono;

            IF vl_noasignable <= csl_2
            THEN
               vl_contadorid := scsisges.seqtidelefono.NEXTVAL ();

               INSERT INTO scsisges.tatelefonos (fiidtelefono,
                                                 fipais,
                                                 ficanal,
                                                 fisucursal,
                                                 fifolio,
                                                 fntelefono,
                                                 fistatus,
                                                 fiidtipo,
                                                 fcusrmodifico,
                                                 fdmodificacion)
                    VALUES (vl_contadorid,
                            pa_pais,
                            pa_canal,
                            pa_sucursal,
                            pa_folio,
                            pa_telefono,
                            csl_0,
                            pa_tipotelefono,
                            vl_user,
                            SYSDATE);



               vl_idfolio :=
                  scsisges.pqfxverificaciontel.fngenerafolio (pa_telefono);


               INSERT INTO scsisges.tafoliotelefono (fiidfolio,
                                                     fiidtelefono,
                                                     fdstatus,
                                                     fistatus,
                                                     fcusrmodifico,
                                                     fdmodificacion)
                    VALUES (vl_idfolio,
                            vl_contadorid,
                            SYSDATE,
                            csl_0,
                            vl_user,
                            SYSDATE);

               COMMIT;
               pa_status := 1;                       
            ELSE
               pa_status := 2;         
            END IF;
         /*flujo para telefonos fijos*/

         ELSIF pa_tipotelefono = csl_1
         THEN
            vl_contadorid := scsisges.seqtidelefono.NEXTVAL ();

            INSERT INTO scsisges.tatelefonos (fiidtelefono,
                                              fipais,
                                              ficanal,
                                              fisucursal,
                                              fifolio,
                                              fntelefono,
                                              fistatus,
                                              fiidtipo,
                                              fcusrmodifico,
                                              fdmodificacion)
                 VALUES (vl_contadorid,
                         pa_pais,
                         pa_canal,
                         pa_sucursal,
                         pa_folio,
                         pa_telefono,
                         csl_0,
                         pa_tipotelefono,
                         vl_user,
                         SYSDATE);

            COMMIT;
            pa_status := 1;                          
         END IF;


      ELSE
         IF pa_tipotelefono = csl_2
         THEN
            SELECT t.fiidtelefono
              INTO vl_idtelefono
              FROM scsisges.tatelefonos t
             WHERE     t.fipais = pa_pais
                   AND t.ficanal = pa_canal
                   AND t.fisucursal = pa_sucursal
                   AND t.fifolio = pa_folio
                   AND t.fntelefono = pa_telefono;



            UPDATE scsisges.tatelefonos t
               SET t.fistatus = csl_0                          
                                     ,
                   t.fiidtipo = pa_tipotelefono,
                   t.fdmodificacion = SYSDATE,
                   t.fcusrmodifico = vl_user
             WHERE t.fiidtelefono = vl_idtelefono;

            BEGIN

               SELECT t.fiidfolio
                 INTO vl_idfolio
                 FROM scsisges.tafoliotelefono t
                WHERE t.fiidtelefono = vl_idtelefono;

               UPDATE scsisges.tafoliotelefono t
                  SET t.fistatus = csl_0,                      
                      t.fdstatus = SYSDATE,
                      t.fdmodificacion = SYSDATE,
                      t.fcusrmodifico = vl_user
                WHERE t.fiidfolio = vl_idfolio
                      AND t.fiidtelefono = vl_idtelefono;

               COMMIT;
            EXCEPTION
               WHEN OTHERS
               THEN
                  vl_idfolio :=
                     scsisges.pqfxverificaciontel.fngenerafolio (pa_telefono);


                  INSERT INTO scsisges.tafoliotelefono (fiidfolio,
                                                        fiidtelefono,
                                                        fdstatus,
                                                        fistatus,
                                                        fcusrmodifico,
                                                        fdmodificacion)
                       VALUES (vl_idfolio,
                               vl_idtelefono,
                               SYSDATE,
                               csl_0,
                               vl_user,
                               SYSDATE);

                  COMMIT;
            END;

            pa_status := 1;                          
         END IF;
      END IF;

      pa_foliogenerado := vl_idfolio;
      pa_codigo := 200;
      pa_mensaje := 'OK';
   EXCEPTION

      WHEN OTHERS
      THEN

         ROLLBACK;
         pa_status := 0;                
         pa_codigo := SQLCODE;          
         pa_mensaje := SUBSTR (SQLERRM, 0, 200); 

         scsisges.
          sperrores (
            SYSDATE,
            pa_codigo,
            pa_mensaje || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PACONTACT.SPADDTELEFONO');
   END spagregatelefono;

   FUNCTION fngenerafolio (pa_telefono IN NUMBER)
      RETURN NUMBER
   IS
      vl_idfolio    NUMBER := 0;
      vl_verifica   NUMBER := 1;
   BEGIN

      WHILE vl_verifica <> csl_0
      LOOP
         vl_idfolio := DBMS_RANDOM.VALUE (100001, 999999);

         SELECT COUNT (1)
           INTO vl_verifica
           FROM scsisges.tafoliotelefono t
          WHERE t.fiidfolio = vl_idfolio
                AND EXISTS
                       (SELECT NULL
                          FROM scsisges.tatelefonos ta
                         WHERE ta.fntelefono = pa_telefono
                               AND t.fiidtelefono = t.fiidtelefono);
      END LOOP;

      RETURN vl_idfolio;
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.
          put_line (SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace ());
         RETURN 0;
   END fngenerafolio;

   PROCEDURE spverificatel (pa_pais            IN     NUMBER,
                            pa_canal           IN     NUMBER,
                            pa_sucursal        IN     NUMBER,
                            pa_folio           IN     NUMBER,
                            pa_telefono        IN     NUMBER,
                            pa_foliogenerado   IN     NUMBER,
                            pa_status             OUT NUMBER,
                            pa_codigo             OUT INTEGER,
                            pa_mensaje            OUT VARCHAR2)
   IS
      vl_fiidtelefono   NUMBER := 0;
   BEGIN
      BEGIN
         SELECT t.fiidtelefono
           INTO vl_fiidtelefono
           FROM scsisges.tatelefonos t, scsisges.tafoliotelefono tf
          WHERE     t.fiidtelefono = tf.fiidtelefono
                AND t.fipais = pa_pais
                AND t.ficanal = pa_canal
                AND t.fisucursal = pa_sucursal
                AND t.fifolio = pa_folio
                AND t.fntelefono = pa_telefono
                AND tf.fiidfolio = pa_foliogenerado
                AND tf.fistatus IN (csl_0, csl_2);
      EXCEPTION
         WHEN OTHERS
         THEN
            vl_fiidtelefono := csl_0;
      END;

      IF vl_fiidtelefono <> csl_0
      THEN
         UPDATE scsisges.tafoliotelefono t
            SET t.fistatus = csl_1,
                t.fdstatus = SYSDATE,
                t.fdmodificacion = SYSDATE,
                t.fcusrmodifico = USER
          WHERE t.fiidfolio = pa_foliogenerado
                AND t.fiidtelefono = vl_fiidtelefono;

         UPDATE scsisges.tatelefonos t
            SET t.fistatus = csl_1
          WHERE t.fiidtelefono = vl_fiidtelefono;

         COMMIT;


         FOR vlcur
            IN (SELECT t.fiidtelefono
                  FROM scsisges.tatelefonos t, scsisges.tafoliotelefono tf
                 WHERE     t.fiidtelefono = tf.fiidtelefono
                       AND t.fipais <> pa_pais
                       AND t.ficanal <> pa_canal
                       AND t.fisucursal <> pa_sucursal
                       AND t.fifolio <> pa_folio
                       AND t.fntelefono = pa_telefono
                       AND tf.fistatus = csl_1)
         LOOP
            /*marcamos los telefonos encontrados como no verificados*/
            UPDATE scsisges.tafoliotelefono t
               SET t.fistatus = csl_2,
                   t.fdstatus = SYSDATE,
                   t.fdmodificacion = SYSDATE,
                   t.fcusrmodifico = USER
             WHERE t.fiidtelefono = vlcur.fiidtelefono;

            UPDATE scsisges.tatelefonos t
               SET t.fistatus = csl_2
             WHERE t.fiidtelefono = vlcur.fiidtelefono;

            COMMIT;
         END LOOP;

         pa_status := 1;              
      ELSE
         pa_status := 0; 
      END IF;
   EXCEPTION

      WHEN OTHERS
      THEN

         ROLLBACK;
         pa_status := -1;                     
         pa_codigo := SQLCODE;          
         pa_mensaje := SQLERRM;         

         scsisges.
          sperrores (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PACONTACT.SPADDTELEFONO');
   END spverificatel;

   PROCEDURE spconsultatel (pa_pais          IN     NUMBER,
                            pa_canal         IN     NUMBER,
                            pa_sucursal      IN     NUMBER,
                            pa_folio         IN     NUMBER,
                            pa_curtelefono      OUT SYS_REFCURSOR,
                            pa_codigo           OUT INTEGER,
                            pa_mensaje          OUT VARCHAR2)
   IS
   BEGIN
      OPEN pa_curtelefono FOR
           SELECT ta.fntelefono, ta.fiidtipo, ta.fistatus
             FROM scsisges.tatelefonos ta, scsisges.tafoliotelefono tf
            WHERE     ta.fiidtelefono = tf.fiidtelefono(+)
                  AND ta.fipais = pa_pais
                  AND ta.ficanal = pa_canal
                  AND ta.fisucursal = pa_sucursal
                  AND ta.fifolio = pa_folio
         ORDER BY ta.fdmodificacion DESC
         FETCH FIRST 1 ROW ONLY;

      pa_codigo := 200;
      pa_mensaje := 'OK';
      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_codigo := SQLCODE;          
         pa_mensaje := SUBSTR (SQLERRM, 0, 200); 

         scsisges.
          sperrores (
            SYSDATE,
            pa_codigo,
            pa_mensaje || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PACONTACT.SPADDTELEFONO');
   END spconsultatel;
END pqfxverificaciontel;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXVERIFICACIONTEL" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXVERIFICACIONTEL" TO "USRSISGES";
