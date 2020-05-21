--------------------------------------------------------
--  DDL for Package Body PQSBGESTION0002
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQSBGESTION0002" AS

    cg_0   CONSTANT INTEGER := 0;
    cg_1   CONSTANT INTEGER := 1;
    cg_2   CONSTANT INTEGER := 2;
    cg_3   CONSTANT INTEGER := 3;
    cg_4   CONSTANT INTEGER := 4;
    cg_5   CONSTANT INTEGER := 5;
    cg_6   CONSTANT INTEGER := 6;

    PROCEDURE spieventgest (
        pa_figestionid   IN scsisges.taeventgest.figestionid%TYPE,
        pa_fiusuarioid   IN scsisges.taeventgest.fiusuarioid%TYPE,
        pa_fieventoid    IN scsisges.taeventgest.fieventoid%TYPE,
        pa_ficliente     IN scsisges.taeventgest.ficliente%TYPE
    ) AS
        PRAGMA autonomous_transaction;
    BEGIN
        IF
            pa_figestionid IS NOT NULL
        THEN
            INSERT INTO scsisges.taeventgest (
                figestionid,
                fiusuarioid,
                fieventoid,
                ficliente
            ) VALUES (
                pa_figestionid,
                pa_fiusuarioid,
                pa_fieventoid,
                pa_ficliente
            );

            COMMIT;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            scsisges.sperrores(SYSDATE,sqlcode,sqlerrm
                                                 || '-'
                                                 || dbms_utility.format_error_backtrace(),'SCSISGES.PQSBGESTION0002.SPIEVENTGEST');

    END;

    PROCEDURE spcactividaddiaria (
        pa_fcempnum   IN scsisges.tagestion.fcempnum%TYPE,
        pa_datos      OUT scsisges.patypes.rcgcursor,
        pa_codigo     OUT INTEGER,
        pa_mensaje    OUT VARCHAR2
    )
        AS
    BEGIN
        OPEN pa_datos FOR SELECT
            fctipogestiondesc actividad,
            (
                SELECT
                    COUNT(cg_1)
                FROM
                    scsisges.tagestion in_
                WHERE
                    in_.fitipogestionid = out_.fitipogestionid
                    AND in_.fcempnum = pa_fcempnum
                    AND trunc(in_.fdcreacion) = trunc(SYSDATE)
            ) gestion
                          FROM
            scsisges.tctipogestion out_
                          WHERE
            out_.fitipogestionid IN (
                cg_2,
                cg_3,
                cg_4,
                cg_5,
                cg_6
            )
        ORDER BY
            out_.fitipogestionid;

        pa_codigo := cg_0;
        pa_mensaje := 'OK';
    EXCEPTION
        WHEN OTHERS THEN
            OPEN pa_datos FOR SELECT
                NULL actividad,
                NULL gestion
                              FROM
                dual;

            pa_codigo := cg_1;
            pa_mensaje := 'Error al consultar datos de actividad diaria';
            scsisges.sperrores(SYSDATE,sqlcode,sqlerrm
                                                 || '-'
                                                 || dbms_utility.format_error_backtrace(),'SCSISGES.PQSBGESTION0002.SPCACTIVIDADDIARIA');

    END;

    PROCEDURE SPACTIVIDADSEMANAL (
   PA_FCEMPNUM    IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
   PA_CURACTDIA      OUT SCSISGES.PATYPES.RCGCURSOR,
   PA_CURACTSEM      OUT SCSISGES.PATYPES.RCGCURSOR,
   PA_CODIGO         OUT INTEGER,
   PA_MENSAJE        OUT VARCHAR2)
AS
BEGIN
   OPEN PA_CURACTDIA FOR
        SELECT TIG.FCTIPOGESTIONDESC TGDIA, NVL (TG.CONTEO, 0) AS GESTION
          FROM (  SELECT FITIPOGESTIONID, COUNT (1) AS CONTEO
                    FROM (  SELECT TGS.FIPAISCU,
                                   TGS.FICANALCU,
                                   TGS.FISUCURSALCU,
                                   TGS.FIFOLIOCU,
                                   TGS.FITIPOGESTIONID,
                                   COUNT (1)
                              FROM SCSISGES.TAGESTION TGS
                             WHERE TGS.FCEMPNUM = PA_FCEMPNUM
                                   AND TRUNC (TGS.FDCREACION) = TRUNC (SYSDATE)
                          GROUP BY TGS.FIPAISCU,
                                   TGS.FICANALCU,
                                   TGS.FISUCURSALCU,
                                   TGS.FIFOLIOCU,
                                   TGS.FITIPOGESTIONID)
                GROUP BY FITIPOGESTIONID
                ORDER BY FITIPOGESTIONID) TG,
               SCSISGES.TCTIPOGESTION TIG
         WHERE TIG.FITIPOGESTIONID = TG.FITIPOGESTIONID(+)
               AND TIG.FITIPOGESTIONID IN (CG_2, CG_3, CG_4, CG_5, CG_6)
      ORDER BY TIG.FITIPOGESTIONID;

   OPEN PA_CURACTSEM FOR
        SELECT TIG.FCTIPOGESTIONDESC TGSEM, NVL (TG.CONTEO, 0) AS GESTION
          FROM (  SELECT FITIPOGESTIONID, COUNT (1) AS CONTEO
                    FROM (  SELECT TGS.FIPAISCU,
                                   TGS.FICANALCU,
                                   TGS.FISUCURSALCU,
                                   TGS.FIFOLIOCU,
                                   TGS.FITIPOGESTIONID,
                                   COUNT (1)
                              FROM SCSISGES.TAGESTION TGS
                             WHERE TGS.FCEMPNUM = PA_FCEMPNUM
                                   AND TRUNC (TGS.FDCREACION) BETWEEN (SELECT MIN (
                                                                                 CALEKT.FDFECHA)
                                                                         FROM SCSISGES.TCCALENDARIOEKT CALEKT
                                                                        WHERE CALEKT.FISEMANA =
                                                                                 (SELECT TC.FISEMANA
                                                                                    FROM SCSISGES.TCCALENDARIOEKT TC
                                                                                   WHERE TC.FDFECHA =
                                                                                            TRUNC (
                                                                                               SYSDATE))
                                                                              AND CALEKT.FIANIO =
                                                                                     (SELECT TC.FIANIO
                                                                                        FROM SCSISGES.TCCALENDARIOEKT TC
                                                                                       WHERE TC.FDFECHA =
                                                                                                TRUNC (
                                                                                                   SYSDATE)))
                                                                  AND (SELECT MAX (
                                                                                 CALEKT.FDFECHA)
                                                                         FROM SCSISGES.TCCALENDARIOEKT CALEKT
                                                                        WHERE CALEKT.FISEMANA =
                                                                                 (SELECT TC.FISEMANA
                                                                                    FROM SCSISGES.TCCALENDARIOEKT TC
                                                                                   WHERE TC.FDFECHA =
                                                                                            TRUNC (
                                                                                               SYSDATE))
                                                                              AND CALEKT.FIANIO =
                                                                                     (SELECT TC.FIANIO
                                                                                        FROM SCSISGES.TCCALENDARIOEKT TC
                                                                                       WHERE TC.FDFECHA =
                                                                                                TRUNC (
                                                                                                   SYSDATE)))
                          GROUP BY TGS.FIPAISCU,
                                   TGS.FICANALCU,
                                   TGS.FISUCURSALCU,
                                   TGS.FIFOLIOCU,
                                   TGS.FITIPOGESTIONID)
                GROUP BY FITIPOGESTIONID
                ORDER BY FITIPOGESTIONID) TG,
               SCSISGES.TCTIPOGESTION TIG
         WHERE TIG.FITIPOGESTIONID = TG.FITIPOGESTIONID(+)
               AND TIG.FITIPOGESTIONID IN (CG_2, CG_3, CG_4)
UNION
SELECT TIG.FCTIPOGESTIONDESC TGSEM, NVL (TG.CONTEO, 0) AS GESTION
          FROM (  SELECT FITIPOGESTIONID, COUNT (1) AS CONTEO
                    FROM (  SELECT TGS.FIPAISCU,
                                   TGS.FICANALCU,
                                   TGS.FISUCURSALCU,
                                   TGS.FIFOLIOCU,
                                   TGS.FITIPOGESTIONID,
                                   COUNT (1)
                              FROM SCSISGES.TAGESTION TGS
                             WHERE TGS.FCEMPNUM = PA_FCEMPNUM
                                   AND TRUNC (TGS.FDCREACION) BETWEEN (SELECT MIN (
                                       CALEKT.FDFECHA) + CG_2
                               FROM SCSISGES.TCCALENDARIOEKT CALEKT
                              WHERE CALEKT.FISEMANA =
                                       (SELECT CAL.FISEMANA
                                          FROM SCSISGES.TCCALENDARIOEKT CAL
                                         WHERE CAL.FDFECHA = TRUNC (SYSDATE) - CG_2)
                                    AND CALEKT.FIANIO =
                                           (SELECT CAL.FIANIO
                                              FROM SCSISGES.TCCALENDARIOEKT CAL
                                             WHERE CAL.FDFECHA = TRUNC (SYSDATE)))
                        AND (SELECT MAX (
                                       CALEKT.FDFECHA) + CG_2
                               FROM SCSISGES.TCCALENDARIOEKT CALEKT
                              WHERE CALEKT.FISEMANA =
                                       (SELECT CAL.FISEMANA
                                          FROM SCSISGES.TCCALENDARIOEKT CAL
                                         WHERE CAL.FDFECHA = TRUNC (SYSDATE) - CG_2)
                                    AND CALEKT.FIANIO =
                                           (SELECT CAL.FIANIO
                                              FROM SCSISGES.TCCALENDARIOEKT CAL
                                             WHERE CAL.FDFECHA = TRUNC (SYSDATE)))
                          GROUP BY TGS.FIPAISCU,
                                   TGS.FICANALCU,
                                   TGS.FISUCURSALCU,
                                   TGS.FIFOLIOCU,
                                   TGS.FITIPOGESTIONID)
                GROUP BY FITIPOGESTIONID
                ORDER BY FITIPOGESTIONID) TG,
               SCSISGES.TCTIPOGESTION TIG
         WHERE TIG.FITIPOGESTIONID = TG.FITIPOGESTIONID(+)
               AND TIG.FITIPOGESTIONID IN (CG_5, CG_6);

   PA_CODIGO := CG_0;
   PA_MENSAJE := 'OK';
EXCEPTION
   WHEN OTHERS
   THEN
      OPEN PA_CURACTSEM FOR SELECT NULL TGD, NULL GESTION FROM DUAL;

      PA_CODIGO := CG_1;
      PA_MENSAJE := 'ERROR AL CONSULTAR DATOS DE ACTIVIDAD DIARIA';
      SCSISGES.SPERRORES (
         SYSDATE,
         SQLCODE,
         SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
         'SCSISGES.PQSBGESTION0002.SPCACTIVIDADDIARIA');
END SPACTIVIDADSEMANAL;

END pqsbgestion0002;

/

  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0002" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0002" TO "USRVENTAST";
