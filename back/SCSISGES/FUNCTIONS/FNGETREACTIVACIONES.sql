--------------------------------------------------------
--  DDL for Function FNGETREACTIVACIONES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNGETREACTIVACIONES" (
    PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
    PA_OPCION    IN NUMBER)
    RETURN SCSISGES.TYTBGESTREGION
    PIPELINED
IS
    CSL_1    CONSTANT INTEGER := 1;
    CSL_2    CONSTANT INTEGER := 2;
    CSL_6    CONSTANT INTEGER := 6;
    CSL_78   CONSTANT INTEGER := 78;
    out_rec           SCSISGES.TYOBGESTREGION
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
        SELECT FNEMPLEADO, FIPENSURGES AS FIIDSUCURSAL
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
                  INTO out_rec.FIREAGESTIO
                  FROM (  SELECT COUNT (1)
                            FROM SCSISGES.TAGESTION TAGES
                                 JOIN SCSISGES.TCTIPOGESTION TCGES
                                     ON TAGES.FITIPOGESTIONID =
                                        TCGES.FITIPOGESTIONID
                           WHERE     TCGES.FITIPOGESTIONID = CSL_6
                                 AND TAGES.FCEMPNUM = eachRow.FNEMPLEADO
                                 AND TAGES.FISUCURSALEMP = eachRow.FIIDSUCURSAL
                                 AND TRUNC (TAGES.FDCREACION) BETWEEN (SELECT   MIN (
                                                                                    CALEKT.FDFECHA)
                                                                              + CSL_2
                                                                         FROM SCSISGES.TCCALENDARIOEKT
                                                                              CALEKT
                                                                        WHERE     CALEKT.FISEMANA =
                                                                                  (SELECT CAL.FISEMANA
                                                                                     FROM SCSISGES.TCCALENDARIOEKT
                                                                                          CAL
                                                                                    WHERE CAL.FDFECHA =
                                                                                            TRUNC (
                                                                                                SYSDATE)
                                                                                          - CSL_2)
                                                                              AND CALEKT.FIANIO =
                                                                                  (SELECT CAL.FIANIO
                                                                                     FROM SCSISGES.TCCALENDARIOEKT
                                                                                          CAL
                                                                                    WHERE CAL.FDFECHA =
                                                                                          TRUNC (
                                                                                              SYSDATE)))
                                                                  AND (SELECT   MAX (
                                                                                    CALEKT.FDFECHA)
                                                                              + CSL_2
                                                                         FROM SCSISGES.TCCALENDARIOEKT
                                                                              CALEKT
                                                                        WHERE     CALEKT.FISEMANA =
                                                                                  (SELECT CAL.FISEMANA
                                                                                     FROM SCSISGES.TCCALENDARIOEKT
                                                                                          CAL
                                                                                    WHERE CAL.FDFECHA =
                                                                                            TRUNC (
                                                                                                SYSDATE)
                                                                                          - CSL_2)
                                                                              AND CALEKT.FIANIO =
                                                                                  (SELECT CAL.FIANIO
                                                                                     FROM SCSISGES.TCCALENDARIOEKT
                                                                                          CAL
                                                                                    WHERE CAL.FDFECHA =
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
                  INTO out_rec.FIREACTIVAC
                  FROM (  SELECT B.FIPAIS,
                                 B.FICANAL,
                                 B.FISUCURSAL,
                                 B.FIFOLIO
                            FROM SCSISGES.TAFXCAMPANASPF A
                                 INNER JOIN SCSISGES.TAFXCARTERAPF B
                                     ON     A.FIPAIS = B.FIPAIS
                                        AND A.FICANAL = B.FICANAL
                                        AND A.FISUCURSAL = B.FISUCURSAL
                                        AND A.FIFOLIO = B.FIFOLIO
                           WHERE     A.FIIDCAMPANA IN (csl_78)
                                 AND B.FIIDEMPLEADO = eachRow.FNEMPLEADO
                                 AND B.FIIDSUCURSAL = eachRow.FIIDSUCURSAL
                                 AND B.FNSTATUSCTE = csl_1
                        GROUP BY B.FIPAIS,
                                 B.FICANAL,
                                 B.FISUCURSAL,
                                 B.FIFOLIO);

                PIPE ROW (out_rec);
            EXCEPTION
                WHEN OTHERS
                THEN
                    out_rec.FISOLICITUD := NULL;
            END;
        END LOOP;
    END IF;

    RETURN;
END FNGETREACTIVACIONES;

/

  GRANT EXECUTE ON "SCSISGES"."FNGETREACTIVACIONES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNGETREACTIVACIONES" TO "USRSISGES";
