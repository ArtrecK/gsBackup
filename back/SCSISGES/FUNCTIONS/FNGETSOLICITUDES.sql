--------------------------------------------------------
--  DDL for Function FNGETSOLICITUDES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNGETSOLICITUDES" (
   PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
   PA_OPCION    IN NUMBER)
   RETURN SCSISGES.TYTBGESTREGION
   PIPELINED
IS
   CSL_3   CONSTANT INTEGER := 3;
   CSL_7   CONSTANT INTEGER := 7;
   CSL_9   CONSTANT INTEGER := 9;
   out_rec          SCSISGES.TYOBGESTREGION
                       := SCSISGES.TYOBGESTREGION (NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL,
                                                   NULL);

   CURSOR cur_Empleados
   IS
      SELECT CAST (FNEMPLEADO AS VARCHAR2 (8)) FNEMPLEADO,
             FIPENSURGES AS FIIDSUCURSAL
        FROM TABLE (PA_DATOSIN);
BEGIN
   --consultar gestiones acumuladas de solicitudes
   IF PA_OPCION = 1
   THEN
      FOR eachRow IN cur_Empleados
      LOOP
         BEGIN
            out_rec.FIIDSUCURSAL := eachRow.FIIDSUCURSAL;
            out_rec.FNEMPLEADO := eachRow.FNEMPLEADO;

            SELECT COUNT (1)
              INTO out_rec.FISOLGESTIO
              FROM (  SELECT TAGES.FIPAISCU,
                             TAGES.FICANALCU,
                             TAGES.FISUCURSALCU,
                             TAGES.FIFOLIOCU
                        FROM    SCSISGES.TAGESTION TAGES
                             JOIN
                                SCSISGES.TCTIPOGESTION TAGESID
                             ON TAGES.FITIPOGESTIONID = TAGESID.FITIPOGESTIONID
                       WHERE     TAGESID.FITIPOGESTIONID = CSL_3
                             AND TAGES.FCEMPNUM = eachRow.FNEMPLEADO
                             AND TAGES.FISUCURSALEMP = eachRow.FIIDSUCURSAL
                             AND TRUNC (TAGES.FDCREACION) BETWEEN (SELECT MIN (
                                                                             CALEKT.
                                                                              FDFECHA)
                                                                     FROM SCSISGES.
                                                                           TCCALENDARIOEKT CALEKT
                                                                    WHERE CALEKT.
                                                                           FISEMANA =
                                                                             (SELECT CAL.
                                                                                      FISEMANA
                                                                                FROM SCSISGES.
                                                                                      TCCALENDARIOEKT CAL
                                                                               WHERE CAL.
                                                                                      FDFECHA =
                                                                                        TRUNC (
                                                                                           SYSDATE))
                                                                          AND CALEKT.
                                                                               FIANIO =
                                                                                 (SELECT CAL.
                                                                                          FIANIO
                                                                                    FROM SCSISGES.
                                                                                          TCCALENDARIOEKT CAL
                                                                                   WHERE CAL.
                                                                                          FDFECHA =
                                                                                            TRUNC (
                                                                                               SYSDATE)))
                                                              AND (SELECT MAX (
                                                                             CALEKT.
                                                                              FDFECHA)
                                                                     FROM SCSISGES.
                                                                           TCCALENDARIOEKT CALEKT
                                                                    WHERE CALEKT.
                                                                           FISEMANA =
                                                                             (SELECT CAL.
                                                                                      FISEMANA
                                                                                FROM SCSISGES.
                                                                                      TCCALENDARIOEKT CAL
                                                                               WHERE CAL.
                                                                                      FDFECHA =
                                                                                        TRUNC (
                                                                                           SYSDATE))
                                                                          AND CALEKT.
                                                                               FIANIO =
                                                                                 (SELECT CAL.
                                                                                          FIANIO
                                                                                    FROM SCSISGES.
                                                                                          TCCALENDARIOEKT CAL
                                                                                   WHERE CAL.
                                                                                          FDFECHA =
                                                                                            TRUNC (
                                                                                               SYSDATE)))
                    GROUP BY TAGES.FIPAISCU,
                             TAGES.FICANALCU,
                             TAGES.FISUCURSALCU,
                             TAGES.FIFOLIOCU);

            PIPE ROW (out_rec);
         EXCEPTION
            WHEN OTHERS
            THEN
               out_rec.FISOLGESTIO := NULL;
         END;
      END LOOP;
   --consultar total de solicitudes
   ELSIF PA_OPCION = 2
   THEN
      FOR eachRow IN cur_Empleados
      LOOP
         BEGIN
            out_rec.FIIDSUCURSAL := eachRow.FIIDSUCURSAL;
            out_rec.FNEMPLEADO := eachRow.FNEMPLEADO;

            SELECT COUNT (1)
              INTO out_rec.FISOLICITUD
              FROM (SELECT T.FIIDNEGOCIO,
                           T.FIIDTIENDA,
                           T.FIIDCLIENTE,
                           T.FIPAIS,
                           T.FICANAL,
                           T.FISUCURSAL,
                           T.FISOLICITUDID,
                           TC.FINGCIOID,
                           TC.FINOTIENDA,
                           TC.FICTEID,
                           TC.FIDIGITOVER,
                           TC.FISUCURSAL AS FIIDSUCURSAL
                      FROM SCVENTASTIENDA.TASOLICITUDES T,
                           SCVENTASTIENDA.TACREDCTECTES TC
                     WHERE     T.FIIDNEGOCIO = TC.FIIDNEGOCIO
                           AND T.FIIDTIENDA = TC.FIIDTIENDA
                           AND T.FIIDCLIENTE = TC.FIIDCLIENTE
                           AND T.FCEMPNO = eachRow.FNEMPLEADO
                           AND TC.FISUCURSAL = eachRow.FIIDSUCURSAL) TS
                   INNER JOIN SCVENTASTIENDA.TACLIENTES TACL
                      ON (    TACL.FIPAIS = TS.FIPAIS
                          AND TACL.FICANAL = TS.FICANAL
                          AND TACL.FISUCURSAL = TS.FISUCURSAL
                          AND TS.FINGCIOID = TACL.FINGCIOID
                          AND TS.FINOTIENDA = TACL.FINOTIENDA
                          AND TS.FICTEID = TACL.FICTEID
                          AND TS.FIDIGITOVER = TACL.FIDIGITOVER)
                   INNER JOIN SCVENTASTIENDA.TACREDSOLICITUD TACR
                      ON (TACR.FISOLICITUDID = TS.FISOLICITUDID
                          AND TS.FIIDSUCURSAL = TACR.FISUCURSAL)
                   INNER JOIN SCVENTASTIENDA.TAESTSOLICITUD TAES
                      ON (TAES.FIESTATUS = TACR.FISTAT)
                   LEFT JOIN SCVENTASTIENDA.TAPEDIDOS PED
                      ON     TS.FINGCIOID = PED.FINGCIOID
                         AND TS.FINOTIENDA = PED.FINOTIENDA
                         AND TS.FICTEID = PED.FICTEID
                         AND TS.FIDIGITOVER = PED.FIDIGITOVER
             WHERE PED.FINOPEDIDO IS NULL
                   AND ( (TACR.FISTAT = CSL_9
                          AND TACR.FDFECSTAT > SYSDATE - CSL_7)
                        OR TACR.FISTAT <> CSL_9);

            PIPE ROW (out_rec);
         EXCEPTION
            WHEN OTHERS
            THEN
               out_rec.FISOLICITUD := NULL;
         END;
      END LOOP;
   END IF;

   RETURN;
END FNGETSOLICITUDES;

/

  GRANT EXECUTE ON "SCSISGES"."FNGETSOLICITUDES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNGETSOLICITUDES" TO "USRSISGES";
