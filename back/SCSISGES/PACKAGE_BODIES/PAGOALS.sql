--------------------------------------------------------
--  DDL for Package Body PAGOALS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAGOALS" 
AS
    csl_contado   CONSTANT VARCHAR2 (10) := '4000000100';
    csl_credito   CONSTANT VARCHAR2 (10) := '4000000101';
    csl_funcion            INTEGER := 8067;
    csl_negocio   CONSTANT VARCHAR2 (3) := 'EKT';

    PROCEDURE spgoalsweekly (
        pa_fidsucursal   IN     scsisges.taobjetivos.fnccosto%TYPE,
        pa_ffecha        IN     scsisges.taobjetivos.fdfecha%TYPE,
        cur_goals           OUT SYS_REFCURSOR,
        pa_code             OUT INTEGER,
        pa_message          OUT VARCHAR2)
    AS
    BEGIN
        OPEN cur_goals FOR
              SELECT ABS (tf.fnproducto)
                         AS iddepartamento,
                     (SELECT fcprdlindesc
                        FROM scsisges.tclinea
                       WHERE fnlinea = ABS (fnproducto))
                         AS departamento,
                     TRUNC (
                           MAX (NVL (credito, csl_0))
                         / (SELECT CASE
                                       WHEN FNPLANTILLA = 0 THEN 1
                                       ELSE FNPLANTILLA
                                   END
                                       AS FNPLANTILLA
                              FROM SCSISGES.TAEMPLEADOSEM
                             WHERE FNCC =
                                      csl_52
                                   || SUBSTR (
                                          '0000' || TO_CHAR (pa_fidsucursal),
                                          csl_n4,
                                          csl_4)),
                         csl_2)
                         AS credito,
                     TRUNC (
                           MAX (NVL (contado, csl_0))
                         / (SELECT CASE
                                       WHEN FNPLANTILLA = 0 THEN 1
                                       ELSE FNPLANTILLA
                                   END
                                       AS FNPLANTILLA
                              FROM SCSISGES.TAEMPLEADOSEM
                             WHERE FNCC =
                                      csl_52
                                   || SUBSTR (
                                          '0000' || TO_CHAR (pa_fidsucursal),
                                          csl_n4,
                                          csl_4)),
                         csl_2)
                         AS contado
                FROM (SELECT tq.fnproducto,
                             DECODE (tq.fcidconcepto, csl_contado, tq.total)
                                 AS contado,
                             DECODE (tq.fcidconcepto, csl_credito, tq.total)
                                 AS credito
                        FROM (  SELECT ABS (t.fnproducto)
                                           AS fnproducto,
                                       t.fcidconcepto,
                                       SUM (
                                           NVL (NVL (fnmontopesos, csl_0), csl_0))
                                           AS total
                                  FROM scsisges.taobjetivos t
                                 WHERE     TO_CHAR (
                                               TO_DATE (fdfecha, 'yyyyMMdd'),
                                               'WW') =
                                           TO_CHAR (
                                               TO_DATE (pa_ffecha, 'yyyyMMdd'),
                                               'WW')
                                       AND fnccosto =
                                              csl_52
                                           || SUBSTR (
                                                     '0000'
                                                  || TO_CHAR (pa_fidsucursal),
                                                  csl_n4,
                                                  csl_4)
                                       AND t.fcidconcepto IN
                                               (csl_contado, csl_credito)
                              GROUP BY ABS (t.fnproducto), t.fcidconcepto
                              ORDER BY ABS (t.fnproducto)) tq) tf
            GROUP BY ABS (tf.fnproducto)
            ORDER BY ABS (fnproducto);

        pa_code := csl_200;
        pa_message := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END spgoalsweekly;

    PROCEDURE spgoalsdaily (
        pa_fidsucursal   IN     scsisges.taobjetivos.fnccosto%TYPE,
        pa_ffecha        IN     scsisges.taobjetivos.fdfecha%TYPE,
        cur_goals           OUT SYS_REFCURSOR,
        pa_code             OUT INTEGER,
        pa_message          OUT VARCHAR2)
    AS
    BEGIN
        OPEN cur_goals FOR
              SELECT ABS (tf.fnproducto)
                         AS iddepartamento,
                     (SELECT fcprdlindesc
                        FROM scsisges.tclinea
                       WHERE fnlinea = ABS (fnproducto))
                         AS departamento,
                     TRUNC (
                           MAX (NVL (credito, csl_0))
                         / (SELECT COUNT (csl_1)
                              FROM SCSISGES.TAEMPLEADO
                             WHERE     FNCC =
                                          csl_52
                                       || SUBSTR (
                                                 '0000'
                                              || TO_CHAR (pa_fidsucursal),
                                              csl_n4,
                                              csl_4)
                                   AND FNFUNCION = csl_fun
                                   AND FCNEGOCIO = csl_negocio
                                   AND FNLABORA = csl_1),
                         csl_2)
                         AS credito,
                     TRUNC (
                           MAX (NVL (contado, csl_0))
                         / (SELECT COUNT (csl_1)
                              FROM SCSISGES.TAEMPLEADO
                             WHERE     FNCC =
                                          csl_52
                                       || SUBSTR (
                                                 '0000'
                                              || TO_CHAR (pa_fidsucursal),
                                              csl_n4,
                                              csl_4)
                                   AND FNFUNCION = csl_fun
                                   AND FCNEGOCIO = csl_negocio
                                   AND FNLABORA = csl_1),
                         csl_2)
                         AS contado
                FROM (SELECT tq.fnproducto,
                             DECODE (tq.fcidconcepto, csl_contado, tq.total)
                                 AS contado,
                             DECODE (tq.fcidconcepto, csl_credito, tq.total)
                                 AS credito
                        FROM (  SELECT ABS (t.fnproducto)
                                           AS fnproducto,
                                       t.fcidconcepto,
                                       SUM (
                                           NVL (NVL (fnmontopesos, csl_0), csl_0))
                                           AS total
                                  FROM scsisges.taobjetivos t
                                 WHERE     TO_DATE (fdfecha, 'yyyyMMdd') =
                                           TO_DATE (pa_ffecha, 'yyyyMMdd')
                                       AND fnccosto =
                                              csl_52
                                           || SUBSTR (
                                                     '0000'
                                                  || TO_CHAR (pa_fidsucursal),
                                                  csl_n4,
                                                  csl_4)
                                       AND t.fcidconcepto IN
                                               (csl_contado, csl_credito)
                              GROUP BY ABS (t.fnproducto), t.fcidconcepto
                              ORDER BY ABS (t.fnproducto)) tq) tf
            GROUP BY ABS (tf.fnproducto)
            ORDER BY ABS (fnproducto);

        pa_code := csl_200;
        pa_message := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END spgoalsdaily;

    PROCEDURE spgoalsCC (
        pa_fidsucursal   IN     scsisges.taobjetivos.fnccosto%TYPE,
        paCC                OUT SYS_REFCURSOR,
        pa_code             OUT INTEGER,
        pa_message          OUT VARCHAR2)
    AS
    BEGIN
        OPEN paCC FOR
            SELECT FNCOSTOID AS CC
              FROM SCSISGES.TCIDCOSTO
             WHERE FNCTROCTOCVE =
                      csl_52
                   || SUBSTR ('0000' || TO_CHAR (pa_fidsucursal),
                              csl_n4,
                              csl_4);

        pa_code := csl_200;
        pa_message := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END spgoalsCC;

    PROCEDURE spGoalsEmp (pa_code OUT INTEGER, pa_message OUT VARCHAR2)
    AS
    BEGIN
        DELETE SCSISGES.TAEMPLEADOSEM
         WHERE fncc > csl_0;

        INSERT INTO SCSISGES.TAEMPLEADOSEM (FNCC, FNPLANTILLA)
              SELECT a.fidsucursal, COUNT (csl_1)
                FROM SCSISGES.tcsucursal a
                     LEFT JOIN SCSISGES.taempleado b
                         ON     a.fidsucursal = b.fncc
                            AND b.fnfuncion = csl_funcion
            GROUP BY fidsucursal;

        pa_code := csl_200;
        pa_message := 'OK';
        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END spGoalsEmp;


    PROCEDURE SP_DTL_TAVENTASACUM (PA_CODE      OUT INTEGER,
                                   PA_MESSAGE   OUT VARCHAR2)
    AS
    BEGIN
        DELETE FROM SCSISGES.TAVENTASACUM
              WHERE FDCREACION >= SYSDATE - csl_7;

        COMMIT;

        PA_CODE := CSL_0;
        PA_MESSAGE := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END SP_DTL_TAVENTASACUM;
END pagoals;

/**************************************************************************/

/

  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRVENTAST";
