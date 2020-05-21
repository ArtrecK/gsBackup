--------------------------------------------------------
--  DDL for Function FNGETPENDXSURTIR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNGETPENDXSURTIR" (
   PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
   PA_OPCION    IN NUMBER)
   RETURN SCSISGES.TYTBGESTREGION
   PIPELINED
IS
   CSL_0   CONSTANT INTEGER := 0;
   CSL_1   CONSTANT INTEGER := 1;
   CSL_2   CONSTANT INTEGER := 2;
   CSL_4   CONSTANT INTEGER := 4;
   OUT_REC          SCSISGES.TYOBGESTREGION
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

   CURSOR CUR_EMPLEADOS
   IS
      SELECT FNEMPLEADO, FIPENSURGES AS FIIDSUCURSAL FROM TABLE (PA_DATOSIN);
BEGIN
   --consultar gestiones acumuladas de pedidos pendientes
   IF PA_OPCION = 1
   THEN
      FOR EACHROW IN CUR_EMPLEADOS
      LOOP
         BEGIN
            OUT_REC.FIIDSUCURSAL := EACHROW.FIIDSUCURSAL;
            OUT_REC.FNEMPLEADO := EACHROW.FNEMPLEADO;

            SELECT COUNT (1)
              INTO OUT_REC.FIPENSURGES
              FROM (  SELECT TAGES.FIPAISCU,
                             TAGES.FICANALCU,
                             TAGES.FISUCURSALCU,
                             TAGES.FIFOLIOCU
                        FROM    SCSISGES.TAGESTION TAGES
                             JOIN
                                SCSISGES.TCTIPOGESTION TCGES
                             ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
                       WHERE     TCGES.FITIPOGESTIONID = CSL_2
                             AND TAGES.FCEMPNUM = EACHROW.FNEMPLEADO
                             AND TAGES.FISUCURSALEMP = EACHROW.FIIDSUCURSAL
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

            PIPE ROW (OUT_REC);
         EXCEPTION
            WHEN OTHERS
            THEN
               OUT_REC.FIPENSURGES := NULL;
         END;
      END LOOP;
   ELSIF PA_OPCION = 2
   THEN
      FOR EACHROW IN CUR_EMPLEADOS
      LOOP
         BEGIN
            OUT_REC.FIIDSUCURSAL := EACHROW.FIIDSUCURSAL;
            OUT_REC.FNEMPLEADO := EACHROW.FNEMPLEADO;

            SELECT COUNT (1)
              INTO OUT_REC.FIPENSURTIR
              FROM (  SELECT TCEN.FIPAIS,
                             TCEN.FICANAL,
                             TCEN.FISUCURSAL,
                             TCEN.FIFOLIO
                        FROM    SCVENTASTIENDA.TACENCTETIENDA TCEN
                             JOIN
                                SCVENTASTIENDA.TAPEDIDOS TAPED
                             ON     TCEN.FINGCIOID = TAPED.FINGCIOID
                                AND TCEN.FINOTIENDA = TAPED.FINOTIENDA
                                AND TCEN.FICTEID = TAPED.FICTEID
                                AND TCEN.FIDIGITOVER = TAPED.FIDIGITOVER
                                AND TRIM (TAPED.FCEMPNOVENTA) =
                                       EACHROW.FNEMPLEADO
                                AND TAPED.FISUCURSAL = EACHROW.FIIDSUCURSAL
                                AND TAPED.FIPEDSTAT = CSL_0
                                AND TAPED.FITIPOVENTA IN (CSL_1, CSL_2, CSL_4)
                                AND TCEN.FIPAISCU > CSL_0
                                AND TCEN.FICANALCU > CSL_0
                                AND TCEN.FISUCURSALCU > CSL_0
                                AND TCEN.FIFOLIO > CSL_0
                                AND TCEN.FINGCIOID > CSL_0
                                AND TCEN.FINOTIENDA > CSL_0
                                AND TCEN.FICTEID > CSL_0
                                AND TCEN.FIDIGITOVER > CSL_0
                    GROUP BY TCEN.FIPAIS,
                             TCEN.FICANAL,
                             TCEN.FISUCURSAL,
                             TCEN.FIFOLIO);

            PIPE ROW (OUT_REC);
         EXCEPTION
            WHEN OTHERS
            THEN
               OUT_REC.FIPENSURGES := NULL;
         END;
      END LOOP;
   END IF;

   RETURN;
END FNGETPENDXSURTIR;
/

  GRANT EXECUTE ON "SCSISGES"."FNGETPENDXSURTIR" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNGETPENDXSURTIR" TO "USRSISGES";
  ALTER PACKAGE "SCSISGES"."PAGESTACUMULADO" COMPILE;
  ALTER PACKAGE "SCSISGES"."PAGESTIONSUCURSAL" COMPILE;
