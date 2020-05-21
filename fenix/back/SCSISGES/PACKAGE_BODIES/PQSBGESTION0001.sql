--------------------------------------------------------
--  DDL for Package Body PQSBGESTION0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQSBGESTION0001" 
AS
    csl_m1   CONSTANT INTEGER := -1;
    csl_0    CONSTANT INTEGER := 0;
    csl_1    CONSTANT INTEGER := 1;
    csl_2    CONSTANT INTEGER := 2;
    csl_3    CONSTANT INTEGER := 3;
    csl_4    CONSTANT INTEGER := 4;

    PROCEDURE spinscambaceo (
        pa_fcdescarchivo         scsisges.tccatcambaceo.fcdescarchivo%TYPE,
        pa_fcnombrearchivo       scsisges.tccatcambaceo.fcnombrearchivo%TYPE,
        pa_fclobiarchivo         scsisges.tccatcambaceo.fclobiarchivo%TYPE,
        pa_mimetype              scsisges.tccatcambaceo.fcmimetype%TYPE,
        pa_fcusrmodifico         scsisges.tccatcambaceo.fcusrmodifico%TYPE,
        pa_codigo            OUT INTEGER,
        pa_mensaje           OUT VARCHAR2)
    AS
        vl_fiidimagen   scsisges.tccatcambaceo.ficambaceoid%TYPE;
        csl_1           PLS_INTEGER := 1;
    BEGIN
        vl_fiidimagen := scsisges.sqcambaceo.NEXTVAL;

        INSERT INTO scsisges.tccatcambaceo (ficambaceoid,
                                            fcnombrearchivo,
                                            fcdescarchivo,
                                            fcmimetype,
                                            fclobiarchivo,
                                            fistatus,
                                            fcusrmodifico,
                                            fdmodificacion)
             VALUES (vl_fiidimagen,
                     pa_fcnombrearchivo,
                     pa_fcdescarchivo,
                     pa_mimetype,
                     pa_fclobiarchivo,
                     csl_1,
                     pa_fcusrmodifico,
                     SYSDATE);

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje :=
                'FALLO AL REALIZAR EL GUARDADO DE LA CARTA DE CAMBACEO';
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PQSBGESTION0001.SPINSCAMBACEO');
    END;

    PROCEDURE spigestion (
        pa_fipais              IN     scsisges.tagestion.fipaiscu%TYPE,
        pa_ficanal             IN     scsisges.tagestion.ficanalcu%TYPE,
        pa_fisucursal          IN     scsisges.tagestion.fisucursalcu%TYPE,
        pa_fifolio             IN     scsisges.tagestion.fifoliocu%TYPE,
        pa_fcempnum            IN     scsisges.tagestion.fcempnum%TYPE,
        pa_fimediogestionid    IN     scsisges.tagestion.fimediogestionid%TYPE,
        pa_firesultgestionid   IN     scsisges.tagestion.firesultgestionid%TYPE,
        pa_fitipogestionid     IN     scsisges.tagestion.fitipogestionid%TYPE,
        pa_FiDescGestion       IN     scsisges.tagestion.FiDescGestion%TYPE,
        pa_fcnotas             IN     scsisges.tagestion.fcnotas%TYPE,
        pa_fipaisemp           IN     scsisges.tagestion.fipaisemp%TYPE,
        pa_ficanalemp          IN     scsisges.tagestion.ficanalemp%TYPE,
        pa_fisucursalemp       IN     scsisges.tagestion.fisucursalemp%TYPE,
        pa_ficampanaid         IN     scsisges.tagestion.ficampanaid%TYPE,
        pa_fcdesccampana       IN     scsisges.tagestion.FCDESCCAMPANA%TYPE,
        pa_figestionid            OUT scsisges.tagestion.figestionid%TYPE,
        pa_codigo                 OUT INTEGER,
        pa_mensaje                OUT VARCHAR2)
    AS
    BEGIN
        pa_figestionid := scsisges.seqgestion.NEXTVAL;

        INSERT INTO scsisges.tagestion (figestionid,
                                        fipaiscu,
                                        ficanalcu,
                                        fisucursalcu,
                                        fifoliocu,
                                        fcempnum,
                                        fimediogestionid,
                                        firesultgestionid,
                                        fitipogestionid,
                                        fcnotas,
                                        fdcreacion,
                                        fistatus,
                                        fdmodificacion,
                                        usrmodifico,
                                        fipaisemp,
                                        ficanalemp,
                                        fisucursalemp,
                                        ficampanaid,
                                        FCDESCCAMPANA,
                                        FiDescGestion)
             VALUES (pa_figestionid,
                     pa_fipais,
                     pa_ficanal,
                     pa_fisucursal,
                     pa_fifolio,
                     pa_fcempnum,
                     pa_fimediogestionid,
                     pa_firesultgestionid,
                     pa_fitipogestionid,
                     pa_fcnotas,
                     SYSDATE,
                     csl_1,
                     SYSDATE,
                     USER,
                     pa_fipaisemp,
                     pa_ficanalemp,
                     pa_fisucursalemp,
                     pa_ficampanaid,
                     pa_fcdesccampana,
                     pa_FiDescGestion);

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_figestionid := NULL;
            pa_codigo := 1;
            pa_mensaje := 'FALLO AL REALIZAR EL GUARDADO DE LA GESTION';
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PQSBGESTION0001.SPIGESTION');
    END;

    PROCEDURE spugestion (
        pa_figestionid         IN     scsisges.tagestion.figestionid%TYPE,
        pa_fipais              IN     scsisges.tagestion.fipaiscu%TYPE,
        pa_ficanal             IN     scsisges.tagestion.ficanalcu%TYPE,
        pa_fisucursal          IN     scsisges.tagestion.fisucursalcu%TYPE,
        pa_fifolio             IN     scsisges.tagestion.fifoliocu%TYPE,
        pa_fcempnum            IN     scsisges.tagestion.fcempnum%TYPE,
        pa_fimediogestionid    IN     scsisges.tagestion.fimediogestionid%TYPE,
        pa_firesultgestionid   IN     scsisges.tagestion.firesultgestionid%TYPE,
        pa_fitipogestionid     IN     scsisges.tagestion.fitipogestionid%TYPE,
        pa_fcnotas             IN     scsisges.tagestion.fcnotas%TYPE,
        pa_codigo                 OUT INTEGER,
        pa_mensaje                OUT VARCHAR2)
    AS
    BEGIN
        UPDATE scsisges.tagestion
           SET fipaiscu = pa_fipais,
               ficanalcu = pa_ficanal,
               fisucursalcu = pa_fisucursal,
               fifoliocu = pa_fifolio,
               fcempnum = pa_fcempnum,
               fimediogestionid = pa_fimediogestionid,
               firesultgestionid = pa_firesultgestionid,
               fitipogestionid = pa_fitipogestionid,
               fcnotas = pa_fcnotas,
               fdmodificacion = SYSDATE,
               usrmodifico = USER
         WHERE figestionid = pa_figestionid;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'FALLO AL REALIZAR LA ACTUALIZACION DE LA GESTION';
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PQSBGESTION0001.SPUGESTION');
    END;

    PROCEDURE spdgestion (
        pa_figestionid   IN     scsisges.tagestion.figestionid%TYPE,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2)
    AS
    BEGIN
        UPDATE scsisges.tagestion
           SET fistatus = csl_0, fdmodificacion = SYSDATE, usrmodifico = USER
         WHERE figestionid = pa_figestionid;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'FALLO AL REALIZAR EL BORRADO DE LA GESTION';
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PQSBGESTION0001.SPDGESTION');
    END;

    PROCEDURE spcgestionxcu (
        pa_fipais       IN     scsisges.tagestion.fipaiscu%TYPE,
        pa_ficanal      IN     scsisges.tagestion.ficanalcu%TYPE,
        pa_fisucursal   IN     scsisges.tagestion.fisucursalcu%TYPE,
        pa_fifolio      IN     scsisges.tagestion.fifoliocu%TYPE,
        pa_datos           OUT scsisges.patypes.rcgcursor,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_datos FOR
  SELECT gestion.fdcreacion
                         fechagestion,
                     tipo.fctipogestiondesc
                         tipogestion,
                     medio.fcmediosgestiondesc
                         mediocontacto,
                     resultado.fcresultgestiondesc
                         resultado,
                     gestion.fcnotas
                         notas,
                     DECODE (evento.fievento, 1, 'llamada', 2, 'visita', NULL)
                         evento,
                     TO_CHAR (evento.fdhorainicio,
                              'DD Month - HH:MI AM',
                              'NLS_DATE_LANGUAGE=spanish')
                         fechaevento,
                     GESTION.FCDESCCAMPANA
                         desccampana,
                         descgest.FCDESCGESTION,
                         gestion.Fcempnum
                FROM scsisges.tagestion gestion
                     INNER JOIN scsisges.tcmediogestion medio
                         ON medio.fimediogestionid = gestion.fimediogestionid
                     INNER JOIN scsisges.tcresultgestion resultado
                         ON resultado.firesultgestionid =
                            gestion.firesultgestionid
                     INNER JOIN scsisges.tctipogestion tipo
                         ON tipo.fitipogestionid = gestion.fitipogestionid
                     LEFT JOIN scsisges.taeventgest eventgest
                         ON gestion.figestionid = eventgest.figestionid

                         LEFT JOIN scsisges.tcdescgestion descgest
                         ON gestion.fitipogestionid = descgest.FITIPOGESTION AND
                            gestion.fimediogestionid = descgest.FIMEDIOGESTION AND
                            gestion.firesultgestionid = descgest.FIRESULGESTION AND 
                            gestion.fidescgestion = descgest.FIDESCGESTION

                     LEFT JOIN scsisges.taevento evento
                         ON     evento.fiusuarioid = eventgest.fiusuarioid
                            AND evento.fiidevento = eventgest.fieventoid
                            AND evento.ficliente = eventgest.ficliente
               WHERE     gestion.fipaiscu = pa_fipais
                     AND gestion.ficanalcu = pa_ficanal
                     AND gestion.fisucursalcu = pa_fisucursal
                     AND gestion.fifoliocu = pa_fifolio
            ORDER BY gestion.fdcreacion DESC;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_datos FOR SELECT NULL fechagestion,
                                     NULL tipogestion,
                                     NULL mediocontacto,
                                     NULL resultado,
                                     NULL notas,
                                     NULL evento,
                                     NULL fechaevento
                                FROM DUAL;

            pa_codigo := 1;
            pa_mensaje := 'FALLO AL REALIZAR LA CONSULTA DE GESTIONES';
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PQSBGESTION0001.SPCGESTIONXCU');
    END;

    PROCEDURE spccatalogos (
        pa_fiopcion              NUMBER,
        pa_fitipogestionid       scsisges.tacgesopciones.fitipogestionid%TYPE DEFAULT NULL,
        pa_filineaid             scsisges.tacgesopciones.filineaid%TYPE DEFAULT NULL,
        pa_fiperiodoid           scsisges.tacgesopciones.fiperiodoid%TYPE DEFAULT NULL,
        pa_fipromocionid         scsisges.tacgesopciones.fipromocionid%TYPE DEFAULT NULL,
        pa_fipaisid              scsisges.tacgesopciones.fipaisid%TYPE DEFAULT NULL,
        pa_fiterritorioid        scsisges.tacgesopciones.fiterritorioid%TYPE DEFAULT NULL,
        pa_fizonaid              scsisges.tacgesopciones.fizonaid%TYPE DEFAULT NULL,
        pa_datos             OUT scsisges.patypes.rcgcursor,
        pa_codigo            OUT INTEGER,
        pa_mensaje           OUT VARCHAR2,
        pa_mensajeerror      OUT VARCHAR2)
    AS
        vl_contador   INTEGER;
        vl_opcionid   INTEGER;
    BEGIN
        SELECT COUNT (csl_1)
          INTO vl_contador
          FROM (SELECT figesopcionid,
                       fipaisid,
                       fiterritorioid,
                       fizonaid,
                       fistatus
                  FROM (SELECT figesopcionid,
                               fipromocionid,
                               fipaisid,
                               fiterritorioid,
                               fizonaid,
                               fistatus
                          FROM (SELECT figesopcionid,
                                       fiperiodoid,
                                       fipromocionid,
                                       fipaisid,
                                       fiterritorioid,
                                       fizonaid,
                                       fistatus
                                  FROM (SELECT figesopcionid,
                                               filineaid,
                                               fiperiodoid,
                                               fipromocionid,
                                               fipaisid,
                                               fiterritorioid,
                                               fizonaid,
                                               fistatus
                                          FROM (SELECT figesopcionid,
                                                       fitipogestionid,
                                                       filineaid,
                                                       fiperiodoid,
                                                       fipromocionid,
                                                       fipaisid,
                                                       fiterritorioid,
                                                       fizonaid,
                                                       fistatus
                                                  FROM scsisges.tacgesopciones
                                                       opt1
                                                 WHERE        opt1.fitipogestionid
                                                                  IS NULL
                                                          AND pa_fitipogestionid
                                                                  IS NULL
                                                       OR opt1.fitipogestionid =
                                                          pa_fitipogestionid
                                                       OR opt1.fitipogestionid =
                                                          csl_m1) opt2
                                         WHERE        opt2.filineaid IS NULL
                                                  AND pa_filineaid IS NULL
                                               OR opt2.filineaid =
                                                  pa_filineaid
                                               OR opt2.filineaid = csl_m1)
                                       opt3
                                 WHERE        opt3.fiperiodoid IS NULL
                                          AND pa_fiperiodoid IS NULL
                                       OR opt3.fiperiodoid = pa_fiperiodoid
                                       OR opt3.fiperiodoid = csl_m1) opt4
                         WHERE        opt4.fipromocionid IS NULL
                                  AND pa_fipromocionid IS NULL
                               OR opt4.fipromocionid = pa_fipromocionid
                               OR opt4.fipromocionid = csl_m1) opt5
                 WHERE     (   opt5.fipaisid = pa_fipaisid
                            OR opt5.fipaisid = csl_m1
                            OR opt5.fipaisid IS NULL AND pa_fipaisid IS NULL)
                       AND (   opt5.fiterritorioid = pa_fiterritorioid
                            OR opt5.fiterritorioid = csl_m1
                            OR     opt5.fiterritorioid IS NULL
                               AND pa_fiterritorioid IS NULL)
                       AND (   opt5.fizonaid = pa_fizonaid
                            OR opt5.fizonaid = csl_m1
                            OR opt5.fizonaid IS NULL AND pa_fizonaid IS NULL))
               opt6
         WHERE opt6.fistatus = csl_1;

        IF vl_contador > csl_0
        THEN
            SELECT MIN (figesopcionid)
              INTO vl_opcionid
              FROM (SELECT figesopcionid,
                           fipaisid,
                           fiterritorioid,
                           fizonaid,
                           fistatus
                      FROM (SELECT figesopcionid,
                                   fipromocionid,
                                   fipaisid,
                                   fiterritorioid,
                                   fizonaid,
                                   fistatus
                              FROM (SELECT figesopcionid,
                                           fiperiodoid,
                                           fipromocionid,
                                           fipaisid,
                                           fiterritorioid,
                                           fizonaid,
                                           fistatus
                                      FROM (SELECT figesopcionid,
                                                   filineaid,
                                                   fiperiodoid,
                                                   fipromocionid,
                                                   fipaisid,
                                                   fiterritorioid,
                                                   fizonaid,
                                                   fistatus
                                              FROM (SELECT figesopcionid,
                                                           fitipogestionid,
                                                           filineaid,
                                                           fiperiodoid,
                                                           fipromocionid,
                                                           fipaisid,
                                                           fiterritorioid,
                                                           fizonaid,
                                                           fistatus
                                                      FROM scsisges.tacgesopciones
                                                           opt1
                                                     WHERE        opt1.fitipogestionid
                                                                      IS NULL
                                                              AND pa_fitipogestionid
                                                                      IS NULL
                                                           OR opt1.fitipogestionid =
                                                              pa_fitipogestionid
                                                           OR opt1.fitipogestionid =
                                                              csl_m1) opt2
                                             WHERE        opt2.filineaid
                                                              IS NULL
                                                      AND pa_filineaid
                                                              IS NULL
                                                   OR opt2.filineaid =
                                                      pa_filineaid
                                                   OR opt2.filineaid = csl_m1)
                                           opt3
                                     WHERE        opt3.fiperiodoid IS NULL
                                              AND pa_fiperiodoid IS NULL
                                           OR opt3.fiperiodoid =
                                              pa_fiperiodoid
                                           OR opt3.fiperiodoid = csl_m1) opt4
                             WHERE        opt4.fipromocionid IS NULL
                                      AND pa_fipromocionid IS NULL
                                   OR opt4.fipromocionid = pa_fipromocionid
                                   OR opt4.fipromocionid = csl_m1) opt5
                     WHERE     (   opt5.fipaisid = pa_fipaisid
                                OR opt5.fipaisid = csl_m1
                                OR     opt5.fipaisid IS NULL
                                   AND pa_fipaisid IS NULL)
                           AND (   opt5.fiterritorioid = pa_fiterritorioid
                                OR opt5.fiterritorioid = csl_m1
                                OR     opt5.fiterritorioid IS NULL
                                   AND pa_fiterritorioid IS NULL)
                           AND (   opt5.fizonaid = pa_fizonaid
                                OR opt5.fizonaid = csl_m1
                                OR     opt5.fizonaid IS NULL
                                   AND pa_fizonaid IS NULL)) opt6
             WHERE opt6.fistatus = csl_1;
        ELSE
            vl_opcionid := csl_1;
        END IF;

        CASE
            WHEN pa_fiopcion = csl_1
            THEN           ---Consulta el catalogo para las cartas de cambaceo
                SELECT COUNT (csl_1)
                  INTO vl_contador
                  FROM scsisges.tccatcambaceo cambaceo
                 WHERE cambaceo.ficambaceoid =
                       (SELECT MIN (ficambaceoid)
                          FROM scsisges.tacgesoptcamba optcam
                         WHERE     optcam.figesopcionid = vl_opcionid
                               AND optcam.fistatus = csl_1);

                OPEN pa_datos FOR
                    SELECT cambaceo.fcmimetype, cambaceo.fclobiarchivo
                      FROM scsisges.tccatcambaceo cambaceo
                     WHERE cambaceo.ficambaceoid =
                           (SELECT MIN (ficambaceoid)
                              FROM scsisges.tacgesoptcamba optcam
                             WHERE     optcam.figesopcionid =
                                       CASE
                                           WHEN vl_contador = csl_0
                                           THEN
                                               csl_1
                                           ELSE
                                               vl_opcionid
                                       END
                                   AND optcam.fistatus = csl_1);
            WHEN pa_fiopcion = csl_2
            THEN                         ---Consulta el catalogo de los SCRIPT
                SELECT COUNT (csl_1)
                  INTO vl_contador
                  FROM scsisges.tcscript script
                 WHERE script.fiscriptid =
                       (SELECT MIN (fiscriptid)
                          FROM scsisges.tacgesoptscript optscript
                         WHERE     optscript.figesopcionid = vl_opcionid
                               AND optscript.fistatus = csl_1);

                OPEN pa_datos FOR
                    SELECT script.fccontenido
                      FROM scsisges.tcscript script
                     WHERE script.fiscriptid =
                           (SELECT MIN (fiscriptid)
                              FROM scsisges.tacgesoptscript optscript
                             WHERE     optscript.figesopcionid =
                                       CASE
                                           WHEN vl_contador = csl_0
                                           THEN
                                               csl_1
                                           ELSE
                                               vl_opcionid
                                       END
                                   AND optscript.fistatus = csl_1);
            WHEN pa_fiopcion = csl_3
            THEN              ---Consulta el catalogo de los Medios de gestion
                SELECT COUNT (csl_1)
                  INTO vl_contador
                  FROM scsisges.tacgesoptresult resultados
                 WHERE     resultados.figesopcionid = vl_opcionid
                       AND resultados.fistatus = csl_1;

                OPEN pa_datos FOR
                      SELECT fimediogestionid,
                             (SELECT fcmediosgestiondesc
                                FROM scsisges.tcmediogestion
                               WHERE fimediogestionid =
                                     resultados.fimediogestionid)
                                 fcmediosgestiondesc,
                             firesultgestionid,
                             (SELECT fcresultgestiondesc
                                FROM scsisges.tcresultgestion
                               WHERE firesultgestionid =
                                     resultados.firesultgestionid)
                                 fcresultgestiondesc
                        FROM scsisges.tacgesoptresult resultados
                       WHERE     resultados.figesopcionid =
                                 CASE
                                     WHEN vl_contador = csl_0 THEN csl_1
                                     ELSE vl_opcionid
                                 END
                             AND resultados.fistatus = csl_1
                    ORDER BY fimediogestionid, firesultgestionid;
        END CASE;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_codigo := 1;
            pa_mensaje := 'FALLO AL EJECUTAR LA CONSULTA DE CATALOGO';
            pa_mensajeerror :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.format_error_backtrace ()
                || ' - SCSISGES.PQSBGESTION0001.SPCCATALOGOS';
    END;

    PROCEDURE spgetlastgestion (
        pa_fipais        IN     SCSISGES.TAGESTION.FIPAISCU%TYPE,
        pa_ficanal       IN     SCSISGES.TAGESTION.FICANALCU%TYPE,
        pa_fisucursal    IN     SCSISGES.TAGESTION.FISUCURSALCU%TYPE,
        pa_fifolio       IN     SCSISGES.TAGESTION.FIFOLIOCU%TYPE,
        pa_gestionado       OUT INTEGER,
        pa_idresult         OUT INTEGER,
        pa_desresult        OUT SCSISGES.TCRESULTGESTION.FCRESULTGESTIONDESC%TYPE,
        pa_dategestion      OUT SCSISGES.TAGESTION.FDCREACION%TYPE,
        pa_codmsg           OUT INTEGER,
        pa_msg              OUT VARCHAR2,
        pa_msgerror         OUT VARCHAR2)
    AS
    BEGIN
        SELECT MAX (ges.FDCREACION)
          INTO pa_dategestion
          FROM SCSISGES.TAGESTION ges
         WHERE     ges.FIPAISCU = pa_fipais
               AND ges.FICANALCU = pa_ficanal
               AND ges.FISUCURSALCU = pa_fisucursal
               AND ges.FIFOLIOCU = pa_fifolio;

        SELECT ges.FIRESULTGESTIONID
          INTO pa_idresult
          FROM SCSISGES.TAGESTION ges
         WHERE     ges.FIPAISCU = pa_fipais
               AND ges.FICANALCU = pa_ficanal
               AND ges.FISUCURSALCU = pa_fisucursal
               AND ges.FIFOLIOCU = pa_fifolio
               AND ges.FDCREACION = pa_dategestion
               AND ROWNUM = csl_1;

        SELECT rges.FCRESULTGESTIONDESC
          INTO pa_desresult
          FROM SCSISGES.TCRESULTGESTION rges
         WHERE rges.FIRESULTGESTIONID = pa_idresult;

        pa_gestionado := 1;
        pa_codmsg := 0;
        pa_msg := 'OK';
        pa_msgerror := '';
    EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            pa_gestionado := 0;
            pa_codmsg := 0;
            pa_msg := 'El cliente NO tienes registros de gestion';
            pa_msgerror := '';
        WHEN OTHERS
        THEN
            pa_codmsg := 1;
            pa_msg := 'Error al consultar ultima gestion';
            pa_msgerror := SQLCODE || '  ' || SQLERRM;
            pa_gestionado := 0;
    END spgetlastgestion;


   PROCEDURE sp3combo (
         pa_gestion      OUT scsisges.patypes.rcgcursor)
AS
BEGIN

OPEN pa_gestion FOR
SELECT FITIPOGESTION, FIMEDIOGESTION, FIRESULGESTION, FIDESCGESTION, FCDESCGESTION FROM TCDESCGESTION;


    END sp3combo;


END pqsbgestion0001;

/

  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0001" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0001" TO "USRVENTAST";
