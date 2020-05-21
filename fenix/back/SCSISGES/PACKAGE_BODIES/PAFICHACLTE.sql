--------------------------------------------------------
--  DDL for Package Body PAFICHACLTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAFICHACLTE" 
IS
   CSL_0     CONSTANT PLS_INTEGER := 0;
   CSL_100   CONSTANT PLS_INTEGER := 100;
   CSL_1     CONSTANT PLS_INTEGER := 1;
   CSL_3     CONSTANT PLS_INTEGER := 3;

   PROCEDURE SPPROMOCIONES (PA_FIPAIS          IN     INTEGER,
                            PA_FICANAL         IN     INTEGER,
                            PA_FISUCURSALCTE   IN     INTEGER,
                            PA_FIFOLIO         IN     INTEGER,
                            PA_CURDATOS           OUT SYS_REFCURSOR,
                            PA_MENSAJE            OUT VARCHAR2,
                            PA_CODERROR           OUT INTEGER,
                            PA_DESERROR           OUT VARCHAR2)
   IS
   BEGIN
      OPEN PA_CURDATOS FOR
           SELECT FIESTATUSINTERES, FIPRIORIDAD, FCDESCPROD
             FROM SCSISGES.TAPROMOCIONES
            WHERE     FIPAIS = PA_FIPAIS
                  AND FICANAL = PA_FICANAL
                  AND FISUCURSAL = PA_FISUCURSALCTE
                  AND FIFOLIO = PA_FIFOLIO
                  AND FIESTATUSINTERES = CSL_0 /*INDICA QUE EL ESTATUS DE INTERES DEL CLIENTE HAC�A EL PRODUCTO ES DESCONOCIDO*/
                  AND FIPRIORIDAD <= CSL_3
         ORDER BY FIPRIORIDAD;
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, CSL_0, CSL_100);
         PA_MENSAJE := 'OCURRIO UN ERROR AL CONSULTAR PROMOCIONES';
   END SPPROMOCIONES;

   PROCEDURE SPACTSTATUSINTERES (PA_FIPAIS          IN     INTEGER,
                                 PA_FICANAL         IN     INTEGER,
                                 PA_FISUCURSALCTE   IN     INTEGER,
                                 PA_FIFOLIO         IN     INTEGER,
                                 PA_FIPRIORIDAD     IN     INTEGER,
                                 PA_FCEMPNO         IN     VARCHAR2,
                                 PA_MENSAJE            OUT VARCHAR2,
                                 PA_CODERROR           OUT INTEGER,
                                 PA_DESERROR           OUT VARCHAR2)
   IS
   BEGIN
      UPDATE SCSISGES.TAPROMOCIONES TAPROMO
         SET TAPROMO.FIESTATUSINTERES = CSL_1,
             TAPROMO.FCEMPNO = PA_FCEMPNO,
             FDFECHAMOD = SYSDATE
       WHERE     TAPROMO.FIPAIS = PA_FIPAIS
             AND TAPROMO.FICANAL = PA_FICANAL
             AND TAPROMO.FISUCURSAL = PA_FISUCURSALCTE
             AND TAPROMO.FIFOLIO = PA_FIFOLIO
             AND FIPRIORIDAD = PA_FIPRIORIDAD;

      COMMIT;
      pa_codError := CSL_0;
      pa_MENSAJE := 'OK';
      pa_desError := '';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, CSL_0, CSL_100);
         PA_MENSAJE :=
            'OCURRIO UN ERROR AL ACTUALIZAR EL STATUS DE INTERES DEL PRODUCTO EN LA NEXT BEST OFFER';
   END SPACTSTATUSINTERES;

   PROCEDURE SPGESTIONINFOPROMO (PA_MENSAJE    OUT VARCHAR2,
                                 PA_CODERROR   OUT INTEGER,
                                 PA_DESERROR   OUT VARCHAR2)
   IS
      CSL_COUNTRECORDS   NUMBER;
   BEGIN
      SELECT COUNT (1) INTO CSL_COUNTRECORDS FROM SCSISGES.TAPROMOCIONPASO;

      IF CSL_COUNTRECORDS > CSL_0
      THEN
         EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAPROMOHIST';

         FOR CSL_POS IN CSL_1 .. CSL_3
         LOOP
            INSERT INTO SCSISGES.TAPROMOHIST (FIPAIS,
                                              FICANAL,
                                              FISUCURSAL,
                                              FIFOLIO,
                                              FIPRIORIDAD,
                                              FCDESCPROD,
                                              FIESTATUSINTERES,
                                              FCEMPNO,
                                              FDFECHAMOD,
                                              FIIDSUBLINEA,
                                              FDMODIFICO,
                                              FCUSRMODIFICO)
               SELECT FIPAIS,
                      FICANAL,
                      FISUCURSAL,
                      FIFOLIO,
                      FIPRIORIDAD,
                      FCDESCPROD,
                      FIESTATUSINTERES,
                      FCEMPNO,
                      FDFECHAMOD,
                      FIIDSUBLINEA,
                      FDMODIFICO,
                      FCUSRMODIFICO
                 FROM SCSISGES.TAPROMOCIONES
                WHERE     FIPAIS = CSL_1
                      AND FICANAL > CSL_0
                      AND FISUCURSAL > CSL_0
                      AND FIFOLIO > CSL_0
                      AND FIPRIORIDAD = CSL_POS
                      AND FCDESCPROD IS NOT NULL;
         END LOOP;

         EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAPROMOCIONES';

         INSERT INTO SCSISGES.TAPROMOCIONES (FIPAIS,
                                             FICANAL,
                                             FISUCURSAL,
                                             FIFOLIO,
                                             FCDESCPROD,
                                             FIPRIORIDAD,
                                             FIIDSUBLINEA)
            SELECT FIPAIS,
                   FICANAL,
                   FISUCURSAL,
                   FIFOLIO,
                   FCDESCPROD,
                   FIPRIORIDAD,
                   FIIDSUBLINEA
              FROM SCSISGES.TAPROMOCIONPASO
             WHERE     FIPAIS > CSL_0
                   AND FICANAL > CSL_0
                   AND FISUCURSAL > CSL_0
                   AND FIFOLIO > CSL_0
                   AND FIIDSUBLINEA > CSL_0
                   AND LENGTH (FCDESCPROD) > CSL_0;

         EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAPROMOCIONPASO';

         COMMIT;
         pa_codError := CSL_0;
         pa_MENSAJE :=
            'Se realiz� el traspaso de la informaci�n correctamente';
         pa_desError := '';
      ELSE
         pa_codError := CSL_0;
         pa_MENSAJE :=
            'No se encontro informaci�n en la tabla SCSISGES.TAPROMOCIONESPASO';
         pa_desError := '';
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, CSL_0, CSL_100);
         PA_MENSAJE :=
            'OCURRIO UN ERROR AL REALIZAR LA DEPURACI�N Y RESPALDO DE LA INFORMACI�N EN NEXT BEST OFFER';
   END SPGESTIONINFOPROMO;
END PAFICHACLTE;

/

  GRANT EXECUTE ON "SCSISGES"."PAFICHACLTE" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAFICHACLTE" TO "USRVENTAST";
