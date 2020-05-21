--------------------------------------------------------
--  DDL for Function FNGETPROMOCIONES
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION SCSISGES.FNGETPROMOCIONES (
   PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
   PA_OPCION    IN NUMBER)
   RETURN SCSISGES.TYTBGESTREGION
   PIPELINED
IS
   CSL_0    CONSTANT INTEGER := 0;
   CSL_1    CONSTANT INTEGER := 1;
   CSL_2    CONSTANT INTEGER := 2;
   CSL_5    CONSTANT INTEGER := 5;
   CSL_78   CONSTANT INTEGER := 78;
   OUT_REC           SCSISGES.TYOBGESTREGION
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
   --consultar gestiones acumuladas de solicitudes
   IF PA_OPCION = 1
   THEN
      FOR EACHROW IN CUR_EMPLEADOS
      LOOP
         BEGIN
            OUT_REC.FIIDSUCURSAL := EACHROW.FIIDSUCURSAL;
            OUT_REC.FNEMPLEADO := EACHROW.FNEMPLEADO;

            SELECT COUNT (1)
              INTO OUT_REC.FIPROGESTIO
              FROM (  SELECT TAGES.FIPAISCU,
                             TAGES.FICANALCU,
                             TAGES.FISUCURSALCU,
                             TAGES.FIFOLIOCU,
                             COUNT (1)
                        FROM    SCSISGES.TAGESTION TAGES
                             JOIN
                                SCSISGES.TCTIPOGESTION TCGES
                             ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
                       WHERE     TCGES.FITIPOGESTIONID = CSL_5
                             AND TAGES.FCEMPNUM = EACHROW.FNEMPLEADO
                             AND TAGES.FISUCURSALEMP = EACHROW.FIIDSUCURSAL
                             AND TRUNC (TAGES.FDCREACION) BETWEEN (SELECT MIN (
                                                                             CALEKT.
                                                                              FDFECHA)
                                                                          + CSL_2
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
                                                                                           SYSDATE)
                                                                                        - CSL_2)
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
                                                                          + CSL_2
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
                                                                                           SYSDATE)
                                                                                        - CSL_2)
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
               OUT_REC.FISOLGESTIO := NULL;
         END;
      END LOOP;
   --consultar total de solicitudes
   ELSIF PA_OPCION = 2
   THEN
      FOR EACHROW IN CUR_EMPLEADOS
      LOOP
         BEGIN
            OUT_REC.FIIDSUCURSAL := EACHROW.FIIDSUCURSAL;
            OUT_REC.FNEMPLEADO := EACHROW.FNEMPLEADO;

            SELECT COUNT (1)
              INTO OUT_REC.FIPROMOCION
              FROM (  SELECT B.FIPAIS,
                             B.FICANAL,
                             B.FISUCURSAL,
                             B.FIFOLIO
                        FROM    SCSISGES.TACAMPANACTE A
                             INNER JOIN
                                SCSISGES.TAFXCARTERAPF B
                             ON     A.FIPAIS = B.FIPAIS
                                AND A.FICANAL = B.FICANAL
                                AND A.FISUCURSAL = B.FISUCURSAL
                                AND A.FIFOLIO = B.FIFOLIO
                       WHERE     B.FIIDEMPLEADO = EACHROW.FNEMPLEADO
                             AND B.FIIDSUCURSAL = EACHROW.FIIDSUCURSAL
                             AND B.FNSTATUSCTE = CSL_1
                             AND A.FIIDCAMPANA = A.FIIDCAMPANA + CSL_0
                             AND A.FIIDCAMPANA > CSL_0
                    GROUP BY B.FIPAIS,
                             B.FICANAL,
                             B.FISUCURSAL,
                             B.FIFOLIO);

            PIPE ROW (OUT_REC);
         EXCEPTION
            WHEN OTHERS
            THEN
               OUT_REC.FISOLICITUD := NULL;
         END;
      END LOOP;
   END IF;

   RETURN;
END FNGETPROMOCIONES;

/

  GRANT EXECUTE ON SCSISGES.FNGETPROMOCIONES TO USRINFFENIX;
  GRANT EXECUTE ON SCSISGES.FNGETPROMOCIONES TO USRSISGES;
  ALTER PACKAGE SCSISGES.PAGESTACUMULADO COMPILE;
  ALTER PACKAGE SCSISGES.PAGESTIONSUCURSAL COMPILE;
