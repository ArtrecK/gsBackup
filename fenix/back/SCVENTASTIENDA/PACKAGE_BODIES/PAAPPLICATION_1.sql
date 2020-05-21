--------------------------------------------------------
--  DDL for Package Body PAAPPLICATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."PAAPPLICATION" 
AS
    PROCEDURE spqaplication (
        pa_sucursal         IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado         IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_curapplication      OUT SYS_REFCURSOR,
        pa_code                OUT INTEGER,
        pa_message             OUT VARCHAR2)
    AS
        vl_Autorizacion   CONSTANT VARCHAR2 (15) := 'Autorizado';
        csl_0             CONSTANT PLS_INTEGER := 0;
        csl_1             CONSTANT PLS_INTEGER := 1;
        csl_6             CONSTANT PLS_INTEGER := 6;
        csl_7             CONSTANT PLS_INTEGER := 7;
        csl_9             CONSTANT PLS_INTEGER := 9;
    BEGIN
        OPEN pa_curapplication FOR
            SELECT SOLICITUDES.FIPAIS,
                   SOLICITUDES.FICANAL,
                   SOLICITUDES.FISUCURSAL,
                   SOLICITUDES.fingcioid,
                   SOLICITUDES.FISOLICITUDID,
                   SOLICITUDES.customerid,
                   SOLICITUDES.fcctenombre,
                   SOLICITUDES.fccteapaterno,
                   SOLICITUDES.fccteamaterno,
                   SOLICITUDES.fcctemail,
                   SOLICITUDES.fcctetel,
                   SOLICITUDES.fcctedircalle,
                   SOLICITUDES.totalpayment,
                   SOLICITUDES.paymentcapacity,
                   SOLICITUDES.credline,
                   SOLICITUDES.cenline,
                   SOLICITUDES.photo,
                   SOLICITUDES.gender,
                   SOLICITUDES.fnmonto,
                   SOLICITUDES.fiidcliente,
                   SOLICITUDES.fisolcompleta,
                   SOLICITUDES.fiine,
                   SOLICITUDES.ficompdomicilio,
                   SOLICITUDES.ficompingresos,
                   SOLICITUDES.fifirmacontrato,
                   SOLICITUDES.fivisitajvc,
                   SOLICITUDES.fiautorizada,
                   SOLICITUDES.estatud,
                   SOLICITUDES.fcobservaciones
              FROM (  SELECT TCEN.FIPAISCU
                                 AS fipais,
                             TCEN.FICANALCU
                                 AS ficanal,
                             TCEN.FISUCURSALCU
                                 AS fisucursal,
                             TCEN.FIFOLIO
                                 AS fingcioid,
                             TQ.FISOLICITUDID,
                                TQ.FIPAIS
                             || TQ.FICANAL
                             || TQ.FISUCURSAL
                             || TCEN.FIFOLIO
                                 AS customerid,
                             TQ.fcctenombre,
                             TQ.fccteapaterno,
                             TQ.fccteamaterno,
                             TQ.fcctemail,
                             TQ.fcctetel,
                             TQ.fcctedircalle,
                             TQ.totalpayment,
                             TQ.paymentcapacity,
                             TQ.credline,
                             TQ.cenline,
                             TQ.photo,
                             TQ.gender,
                             TQ.fnmonto,
                             TQ.fiidcliente,
                             TQ.fisolcompleta,
                             TQ.fiine,
                             TQ.ficompdomicilio,
                             TQ.ficompingresos,
                             TQ.fifirmacontrato,
                             TQ.fivisitajvc,
                             TQ.fiautorizada,
                             TQ.fcdescripcion
                                 AS estatud,
                             TQ.fcobservaciones
                        FROM SCVENTASTIENDA.TACENCTETIENDA TCEN,
                             (SELECT ts.FIIDNEGOCIO,
                                     ts.FIIDTIENDA,
                                     ts.FIIDCLIENTE,
                                     TACL.FIPAIS,
                                     TACL.FICANAL,
                                     TACL.FISUCURSAL,
                                     ts.FISOLICITUDID,
                                     ts.fnmonto,
                                     ts.fisolcompleta,
                                     ts.fiine,
                                     ts.ficompdomicilio,
                                     ts.ficompingresos,
                                     ts.fifirmacontrato,
                                     ts.fivisitajvc,
                                     ts.fiautorizada,
                                     ts.fcobservaciones,
                                     ts.FINGCIOID,
                                     ts.FINOTIENDA,
                                     ts.FICTEID,
                                     ts.FIDIGITOVER,
                                     ts.FIIDSUCURSAL,
                                     ts.totalpayment,
                                     ts.paymentcapacity,
                                     ts.credline,
                                     ts.cenline,
                                     ts.photo,
                                     ts.gender,
                                     ts.fcctemail,
                                     TACL.fcctenombre,
                                     TACL.fccteapaterno,
                                     TACL.fccteamaterno,
                                     TACL.fcctetel,
                                     TACL.fcctedircalle,
                                     TAES.fcdescripcion,
                                     TAES.FIESTATUS,
                                     TACR.FDFECSTAT
                                FROM (SELECT T.FIIDNEGOCIO,
                                             T.FIIDTIENDA,
                                             T.FIIDCLIENTE,
                                             T.FIPAIS,
                                             T.FICANAL,
                                             T.FISUCURSAL,
                                             T.FISOLICITUDID,
                                             T.fnmonto,
                                             T.fisolcompleta,
                                             T.fiine,
                                             T.ficompdomicilio,
                                             T.ficompingresos,
                                             T.fifirmacontrato,
                                             T.fivisitajvc,
                                             T.fiautorizada,
                                             T.fcobservaciones,
                                             TC.FINGCIOID,
                                             TC.FINOTIENDA,
                                             TC.FICTEID,
                                             TC.FIDIGITOVER,
                                             TC.FISUCURSAL AS FIIDSUCURSAL,
                                             '0'         AS totalpayment,
                                             '0'         AS paymentcapacity,
                                             '9'         AS credline,
                                             '2'         AS cenline,
                                             'photo'     AS photo,
                                             'gender'    AS gender,
                                             'EMAIL'     AS fcctemail
                                        FROM SCVENTASTIENDA.TASOLICITUDES T,
                                             SCVENTASTIENDA.TACREDCTECTES TC
                                       WHERE     T.FIIDNEGOCIO = TC.FIIDNEGOCIO
                                             AND T.FIIDTIENDA = TC.FIIDTIENDA
                                             AND T.FIIDCLIENTE = TC.FIIDCLIENTE
                                             AND T.FCEMPNO = pa_empleado
                                             AND TC.FISUCURSAL = pa_sucursal)
                                     TS
                                     INNER JOIN SCVENTASTIENDA.TACLIENTES TACL
                                         ON (    TACL.FIPAIS = TS.FIPAIS
                                             AND TACL.FICANAL = TS.FICANAL
                                             AND TACL.FISUCURSAL =
                                                 TS.FISUCURSAL
                                             AND TS.FINGCIOID = TACL.FINGCIOID
                                             AND TS.FINOTIENDA =
                                                 TACL.FINOTIENDA
                                             AND TS.FICTEID = TACL.FICTEID
                                             AND TS.FIDIGITOVER =
                                                 TACL.FIDIGITOVER)
                                     INNER JOIN
                                     SCVENTASTIENDA.TACREDSOLICITUD TACR
                                         ON (    TACR.FISOLICITUDID =
                                                 TS.FISOLICITUDID
                                             AND TS.FIIDSUCURSAL =
                                                 TACR.FISUCURSAL)
                                     INNER JOIN
                                     SCVENTASTIENDA.TAESTSOLICITUD TAES
                                         ON (    TAES.FIESTATUS >= csl_0
                                             AND TAES.FIESTATUS = TACR.FISTAT)
                                     LEFT JOIN SCVENTASTIENDA.TAPEDIDOS PED
                                         ON (    TS.FINGCIOID = PED.FINGCIOID
                                             AND TS.FINOTIENDA = PED.FINOTIENDA
                                             AND TS.FICTEID = PED.FICTEID
                                             AND TS.FIDIGITOVER =
                                                 PED.FIDIGITOVER)
                               WHERE     PED.FINOPEDIDO IS NULL
                                     AND (   (    TACR.FISTAT = csl_9
                                              AND TACR.FDFECSTAT >
                                                  SYSDATE - csl_7)
                                          OR TACR.FISTAT <> csl_9)) TQ
                       WHERE     TCEN.fingcioid >= csl_0
                             AND TCEN.finotienda >= csl_0
                             AND TCEN.ficteid >= csl_0
                             AND TCEN.fidigitover >= csl_0
                             AND TCEN.fingcioid = TQ.fingcioid
                             AND TCEN.finotienda = TQ.finotienda
                             AND TCEN.ficteid = TQ.ficteid
                             AND TCEN.fidigitover = TQ.fidigitover
                    ORDER BY INSTR (TQ.FCDESCRIPCION, vl_Autorizacion) DESC,
                             INSTR (TQ.FIESTATUS, csl_6) DESC,
                             TQ.FDFECSTAT DESC) SOLICITUDES
                   LEFT JOIN scsisges.taclientefinado finado
                       ON     SOLICITUDES.fipais = finado.fipais
                          AND SOLICITUDES.ficanal = finado.ficanal
                          AND SOLICITUDES.fisucursal = finado.fisucursal
                          AND SOLICITUDES.fingcioid = finado.fifolio
                          AND finado.fnstatus IN (csl_0, csl_1)
             WHERE     finado.fipais IS NULL
                   AND finado.ficanal IS NULL
                   AND finado.fisucursal IS NULL
                   AND finado.fifolio IS NULL;

        pa_code := 200;
        pa_message := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END spqaplication;

    PROCEDURE spdetsols (
        pa_sucursal      IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado      IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_currequests      OUT SYS_REFCURSOR,
        pa_conteo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_coderror         OUT INTEGER,
        pa_deserror         OUT VARCHAR2)
    AS
        csl_0     CONSTANT PLS_INTEGER := 0;
        csl_1     CONSTANT PLS_INTEGER := 1;
        csl_7     CONSTANT PLS_INTEGER := 7;
        csl_9     CONSTANT PLS_INTEGER := 9;
        csl_6     CONSTANT PLS_INTEGER := 6;
        csl_100   CONSTANT PLS_INTEGER := 100;
    BEGIN
          SELECT COUNT (COUNT (1))
            INTO pa_conteo
            FROM (SELECT c.fipais,
                         c.ficanal,
                         c.fisucursal,
                         c.fifolio
                    FROM scventastienda.tasolicitudes a
                         INNER JOIN scventastienda.tacredctectes b
                             ON     a.fiidnegocio = b.fiidnegocio
                                AND a.fiidtienda = b.fiidtienda
                                AND a.fiidcliente = b.fiidcliente
                         INNER JOIN scventastienda.tacenctetienda c
                             ON     b.fingcioid = c.fingcioid
                                AND b.finotienda = c.finotienda
                                AND b.ficteid = c.ficteid
                                AND b.fidigitover = c.fidigitover
                         INNER JOIN scventastienda.taclientes tacl
                             ON (    tacl.fipais = a.fipais
                                 AND tacl.ficanal = a.ficanal
                                 AND tacl.fisucursal = a.fisucursal
                                 AND c.fingcioid = tacl.fingcioid
                                 AND c.finotienda = tacl.finotienda
                                 AND c.ficteid = tacl.ficteid
                                 AND c.fidigitover = tacl.fidigitover)
                         INNER JOIN scventastienda.tacredsolicitud tacr
                             ON (    tacr.fisolicitudid = a.fisolicitudid
                                 AND b.fisucursal = tacr.fisucursal)
                         INNER JOIN scventastienda.taestsolicitud taes
                             ON (taes.fiestatus = tacr.fistat)
                         LEFT JOIN scventastienda.tapedidos ped
                             ON     c.fingcioid = ped.fingcioid
                                AND c.finotienda = ped.finotienda
                                AND c.ficteid = ped.ficteid
                                AND c.fidigitover = ped.fidigitover
                   WHERE     b.fisucursal = pa_sucursal
                         AND a.fcempno = CAST (pa_empleado AS VARCHAR2 (8))
                         AND ped.finopedido IS NULL
                         AND (   (    tacr.fistat = csl_9
                                  AND tacr.fdfecstat > SYSDATE - csl_7)
                              OR tacr.fistat <> csl_9)) solicitudes
                 LEFT JOIN scsisges.taclientefinado finado
                     ON     solicitudes.fipais = finado.fipais
                        AND solicitudes.ficanal = finado.ficanal
                        AND solicitudes.fisucursal = finado.fisucursal
                        AND solicitudes.fifolio = finado.fifolio
                        AND finado.fnstatus IN (csl_0, csl_1)
           WHERE     finado.fipais IS NULL
                 AND finado.ficanal IS NULL
                 AND finado.fisucursal IS NULL
                 AND finado.fifolio IS NULL
        GROUP BY solicitudes.fipais,
                 solicitudes.ficanal,
                 solicitudes.fisucursal,
                 solicitudes.fifolio;

        OPEN pa_currequests FOR
              SELECT COUNT (1)
                         AS conteo,
                     CASE solicitudes.fiestatus
                         WHEN csl_6 THEN 'Autorizadas'
                         WHEN csl_9 THEN 'Rechazadas'
                         ELSE 'Pendientes'
                     END
                         AS estatus
                FROM (SELECT c.fipais,
                             c.ficanal,
                             c.fisucursal,
                             c.fifolio,
                             taes.fiestatus
                        FROM scventastienda.tasolicitudes a
                             INNER JOIN scventastienda.tacredctectes b
                                 ON     a.fiidnegocio = b.fiidnegocio
                                    AND a.fiidtienda = b.fiidtienda
                                    AND a.fiidcliente = b.fiidcliente
                             INNER JOIN scventastienda.tacenctetienda c
                                 ON     b.fingcioid = c.fingcioid
                                    AND b.finotienda = c.finotienda
                                    AND b.ficteid = c.ficteid
                                    AND b.fidigitover = c.fidigitover
                             INNER JOIN scventastienda.taclientes tacl
                                 ON (    tacl.fipais = a.fipais
                                     AND tacl.ficanal = a.ficanal
                                     AND tacl.fisucursal = a.fisucursal
                                     AND c.fingcioid = tacl.fingcioid
                                     AND c.finotienda = tacl.finotienda
                                     AND c.ficteid = tacl.ficteid
                                     AND c.fidigitover = tacl.fidigitover)
                             INNER JOIN scventastienda.tacredsolicitud tacr
                                 ON (    tacr.fisolicitudid = a.fisolicitudid
                                     AND b.fisucursal = tacr.fisucursal)
                             INNER JOIN scventastienda.taestsolicitud taes
                                 ON (taes.fiestatus = tacr.fistat)
                             LEFT JOIN scventastienda.tapedidos ped
                                 ON     c.fingcioid = ped.fingcioid
                                    AND c.finotienda = ped.finotienda
                                    AND c.ficteid = ped.ficteid
                                    AND c.fidigitover = ped.fidigitover
                       WHERE     b.fisucursal = pa_sucursal
                             AND a.fcempno = CAST (pa_empleado AS VARCHAR2 (8))
                             AND ped.finopedido IS NULL
                             AND (   (    tacr.fistat = csl_9
                                      AND tacr.fdfecstat > SYSDATE - csl_7)
                                  OR tacr.fistat <> csl_9)) solicitudes
                     LEFT JOIN scsisges.taclientefinado finado
                         ON     solicitudes.fipais = finado.fipais
                            AND solicitudes.ficanal = finado.ficanal
                            AND solicitudes.fisucursal = finado.fisucursal
                            AND solicitudes.fifolio = finado.fifolio
                            AND finado.fnstatus IN (csl_0, csl_1)
               WHERE     finado.fipais IS NULL
                     AND finado.ficanal IS NULL
                     AND finado.fisucursal IS NULL
                     AND finado.fifolio IS NULL
            GROUP BY CASE solicitudes.fiestatus
                         WHEN csl_6 THEN 'Autorizadas'
                         WHEN csl_9 THEN 'Rechazadas'
                         ELSE 'Pendientes'
                     END;

        pa_mensaje := 'SE CONSULTARON SOLICITUDES CORRECTAMENTE';
        pa_coderror := csl_1;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_coderror := SQLCODE;
            pa_deserror := SUBSTR (SQLERRM, csl_0, csl_100);
            pa_mensaje :=
                'OCURRIO UN ERROR AL CONSULTAR NUMERO DE SOLICITUDES PENDIENTES POR SURTIR';
    END;


    PROCEDURE spcountsolssuperv (
        pa_sucursal   IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado   IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_conteo        OUT NUMBER,
        pa_mensaje       OUT VARCHAR2,
        pa_coderror      OUT INTEGER,
        pa_deserror      OUT VARCHAR2)
    AS
        csl_0     CONSTANT PLS_INTEGER := 0;
        csl_1     CONSTANT PLS_INTEGER := 1;
        csl_7     CONSTANT PLS_INTEGER := 7;
        csl_9     CONSTANT PLS_INTEGER := 9;
        csl_6     CONSTANT PLS_INTEGER := 6;
        csl_100   CONSTANT PLS_INTEGER := 100;
    BEGIN
        SELECT COUNT (1)
          INTO pa_conteo
          FROM scventastienda.tasolicitudes  a
               INNER JOIN scventastienda.tacredctectes b
                   ON     a.fiidnegocio = b.fiidnegocio
                      AND a.fiidtienda = b.fiidtienda
                      AND a.fiidcliente = b.fiidcliente
               INNER JOIN scventastienda.tacenctetienda c
                   ON     b.fingcioid = c.fingcioid
                      AND b.finotienda = c.finotienda
                      AND b.ficteid = c.ficteid
                      AND b.fidigitover = c.fidigitover
               INNER JOIN scventastienda.taclientes tacl
                   ON (    tacl.fipais = a.fipais
                       AND tacl.ficanal = a.ficanal
                       AND tacl.fisucursal = a.fisucursal
                       AND c.fingcioid = tacl.fingcioid
                       AND c.finotienda = tacl.finotienda
                       AND c.ficteid = tacl.ficteid
                       AND c.fidigitover = tacl.fidigitover)
               INNER JOIN scventastienda.tacredsolicitud tacr
                   ON (    tacr.fisolicitudid = a.fisolicitudid
                       AND b.fisucursal = tacr.fisucursal)
               INNER JOIN scventastienda.taestsolicitud taes
                   ON (taes.fiestatus = tacr.fistat)
               LEFT JOIN scventastienda.tapedidos ped
                   ON     c.fingcioid = ped.fingcioid
                      AND c.finotienda = ped.finotienda
                      AND c.ficteid = ped.ficteid
                      AND c.fidigitover = ped.fidigitover
         WHERE     b.fisucursal = pa_sucursal
               AND a.fcempno = CAST (pa_empleado AS VARCHAR2 (8))
               AND ped.finopedido IS NULL
               AND (   (    tacr.fistat = csl_9
                        AND tacr.fdfecstat > SYSDATE - csl_7)
                    OR tacr.fistat <> csl_9);

        pa_mensaje := 'SE CONSULTARON SOLICITUDES CORRECTAMENTE';
        pa_coderror := csl_1;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_coderror := SQLCODE;
            pa_deserror := SUBSTR (SQLERRM, csl_0, csl_100);
            pa_mensaje :=
                'OCURRIO UN ERROR AL CONSULTAR NUMERO DE SOLICITUDES PENDIENTES POR SURTIR';
    END spcountsolssuperv;

    PROCEDURE spqaplicationv2 (
        pa_sucursal         IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado         IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_curapplication      OUT SYS_REFCURSOR,
        pa_code                OUT INTEGER,
        pa_message             OUT VARCHAR2)
    AS
        vl_Autorizacion   CONSTANT VARCHAR2 (15) := 'Autorizado';
        VL_Days_Authorized         INTEGER := 0;
        VL_Days_Liberated          INTEGER := 0;
        csl_0             CONSTANT PLS_INTEGER := 0;
        csl_1             CONSTANT PLS_INTEGER := 1;
        csl_6             CONSTANT PLS_INTEGER := 6;
        csl_7             CONSTANT PLS_INTEGER := 7;
        csl_9             CONSTANT PLS_INTEGER := 9;
        csl_253           CONSTANT PLS_INTEGER := 253;
        csl_254           CONSTANT PLS_INTEGER := 254;
    BEGIN
        SELECT FCVALOR
          INTO VL_Days_Authorized
          FROM SCSISGES.TAPARAMETROS
         WHERE FCDESCRIPCION = 'DAYS_BLOCK_AUTHORIZED';

        SELECT FCVALOR
          INTO VL_Days_Liberated
          FROM SCSISGES.TAPARAMETROS
         WHERE FCDESCRIPCION = 'DAYS_BLOCK_LIBERATED';

        OPEN pa_curapplication FOR
            SELECT DISTINCT
                   SOLICITUDES.FIPAIS                   AS FIPAISSOL,
                   SOLICITUDES.FICANAL                  AS FICANALSOL,
                   SOLICITUDES.FISUCURSAL               AS FISUCURSALSOL,
                   SOLICITUDES.FISOLICITUDID,
                   SOLICITUDES.FIPAISCU,
                   SOLICITUDES.FICANALCU,
                   SOLICITUDES.FISUCURSALCU,
                   SOLICITUDES.FIFOLIO                  AS FIFOLIOCU,
                   SOLICITUDES.fcctenombre,
                   SOLICITUDES.fccteapaterno,
                   SOLICITUDES.fccteamaterno,
                   SOLICITUDES.fiidcliente,
                   SOLICITUDES.fivisitajvc,
                   SOLICITUDES.fiautorizada,
                   NVL (SOLICITUDES.diasbloqueo, csl_0) AS diasbloqueo
              FROM (SELECT DISTINCT
                           t.fipais,
                           t.ficanal,
                           t.fisucursal,
                           t.fisolicitudid,
                           tcen.fipaiscu,
                           tcen.ficanalcu,
                           tcen.fisucursalcu,
                           tcen.fifolio,
                           tacl.fcctenombre,
                           tacl.fccteapaterno,
                           tacl.fccteamaterno,
                           t.fiidcliente,
                           t.fivisitajvc,
                           t.fiautorizada,
                           tacr.fistat
                               AS estatus,
                           CASE
                               WHEN (    (SELECT COUNT (csl_1)
                                            FROM scventastienda.tacredinves x
                                           WHERE     x.fipais = t.fipais
                                                 AND x.ficanal = t.ficanal
                                                 AND x.fisucursal =
                                                     t.fisucursal
                                                 AND x.fisolicitudid =
                                                     t.fisolicitudid
                                                 AND x.fiinveststat = csl_6) >
                                         csl_0
                                     AND (SELECT COUNT (csl_1)
                                            FROM scventastienda.tacredinves x
                                           WHERE     x.fipais = t.fipais
                                                 AND x.ficanal = t.ficanal
                                                 AND x.fisucursal =
                                                     t.fisucursal
                                                 AND x.fisolicitudid =
                                                     t.fisolicitudid
                                                 AND x.fiinveststat IN
                                                         (csl_253, csl_254)) =
                                         csl_0)
                               THEN
                                   NVL (
                                         VL_Days_Authorized
                                       - ((  TRUNC (SYSDATE)
                                           - (SELECT TRUNC (
                                                         MAX (x.fdinvestfec))
                                                FROM scventastienda.tacredinves
                                                     x
                                               WHERE     x.fipais = t.fipais
                                                     AND x.ficanal =
                                                         t.ficanal
                                                     AND x.fisucursal =
                                                         t.fisucursal
                                                     AND x.fisolicitudid =
                                                         t.fisolicitudid
                                                     AND x.fiinveststat =
                                                         csl_6))),
                                       csl_0)
                               WHEN (    (SELECT COUNT (csl_1)
                                            FROM scventastienda.tacredinves x
                                           WHERE     x.fipais = t.fipais
                                                 AND x.ficanal = t.ficanal
                                                 AND x.fisucursal =
                                                     t.fisucursal
                                                 AND x.fisolicitudid =
                                                     t.fisolicitudid
                                                 AND x.fiinveststat = csl_6) >
                                         csl_0
                                     AND (SELECT COUNT (csl_1)
                                            FROM scventastienda.tacredinves x
                                           WHERE     x.fipais = t.fipais
                                                 AND x.ficanal = t.ficanal
                                                 AND x.fisucursal =
                                                     t.fisucursal
                                                 AND x.fisolicitudid =
                                                     t.fisolicitudid
                                                 AND x.fiinveststat IN
                                                         (csl_253, csl_254)) >
                                         csl_0)
                               THEN
                                   NVL (
                                         VL_Days_Liberated
                                       - ((  TRUNC (SYSDATE)
                                           - (SELECT TRUNC (
                                                         MAX (x.fdinvestfec))
                                                FROM scventastienda.tacredinves
                                                     x
                                               WHERE     x.fipais = t.fipais
                                                     AND x.ficanal =
                                                         t.ficanal
                                                     AND x.fisucursal =
                                                         t.fisucursal
                                                     AND x.fisolicitudid =
                                                         t.fisolicitudid
                                                     AND x.fiinveststat IN
                                                             (csl_253,
                                                              csl_254)))),
                                       csl_0)
                           END
                               diasbloqueo
                      FROM scventastienda.tasolicitudes  t
                           JOIN scventastienda.tacredctectes tc
                               ON     t.fiidnegocio = tc.fiidnegocio
                                  AND t.fiidtienda = tc.fiidtienda
                                  AND t.fiidcliente = tc.fiidcliente
                           JOIN scventastienda.taclientes tacl
                               ON     tacl.fipais = tc.fipais
                                  AND tacl.ficanal = tc.ficanal
                                  AND tacl.fisucursal = tc.fisucursal
                                  AND tacl.fingcioid = tc.fingcioid
                                  AND tacl.finotienda = tc.finotienda
                                  AND tacl.ficteid = tc.ficteid
                                  AND tacl.fidigitover = tc.fidigitover
                           JOIN scventastienda.tacredsolicitud tacr
                               ON     tacr.fipais = t.fipais
                                  AND tacr.ficanal = t.ficanal
                                  AND tacr.fisucursal = t.fisucursal
                                  AND tacr.fisolicitudid = t.fisolicitudid
                                  AND tacr.fiidnegocio = t.fiidnegocio
                                  AND tacr.fiidtienda = t.fiidtienda
                                  AND tacr.fiidcliente = t.fiidcliente
                           JOIN scventastienda.tacenctetienda tcen
                               ON     tcen.fingcioid = tc.fingcioid
                                  AND tcen.finotienda = tc.finotienda
                                  AND tcen.ficteid = tc.ficteid
                                  AND tcen.fidigitover = tc.fidigitover
                           LEFT JOIN scventastienda.tapedidos ped
                               ON     ped.fingcioid = tc.fingcioid
                                  AND ped.finotienda = tc.finotienda
                                  AND ped.ficteid = tc.ficteid
                                  AND ped.fidigitover = tc.fidigitover
                     WHERE     tc.fisucursal = pa_sucursal
                           AND t.fcempno = pa_empleado
                           AND ped.finopedido IS NULL
                           AND (   (    tacr.fistat = csl_9
                                    AND tacr.fdfecstat > SYSDATE - csl_7)
                                OR tacr.fistat <> csl_9)) solicitudes
                   LEFT JOIN scsisges.taclientefinado finado
                       ON     solicitudes.fipaiscu = finado.fipais
                          AND solicitudes.ficanalcu = finado.ficanal
                          AND solicitudes.fisucursalcu = finado.fisucursal
                          AND solicitudes.fifolio = finado.fifolio
                          AND finado.fnstatus IN (csl_0, csl_1)
             WHERE     finado.fipais IS NULL
                   AND finado.ficanal IS NULL
                   AND finado.fisucursal IS NULL
                   AND finado.fifolio IS NULL;

        pa_code := 200;
        pa_message := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_curapplication FOR SELECT NULL FIPAISSOL,
                                              NULL FICANALSOL,
                                              NULL FISUCURSALSOL,
                                              NULL FISOLICITUDID,
                                              NULL FIPAISCU,
                                              NULL FICANALCU,
                                              NULL FISUCURSALCU,
                                              NULL FIFOLIOCU,
                                              NULL fcctenombre,
                                              NULL fccteapaterno,
                                              NULL fccteamaterno,
                                              NULL fiidcliente,
                                              NULL fivisitajvc,
                                              NULL fiautorizada,
                                              NULL diasbloqueo
                                         FROM DUAL;

            pa_code := SQLCODE;
            pa_message := SQLERRM;
    END spqaplicationv2;
END paapplication;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "SCSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRINFSISGES";
