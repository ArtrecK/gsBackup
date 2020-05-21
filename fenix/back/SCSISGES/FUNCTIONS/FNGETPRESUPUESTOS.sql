--------------------------------------------------------
--  DDL for Function FNGETPRESUPUESTOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNGETPRESUPUESTOS" (
   PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
   PA_OPCION    IN NUMBER)
   RETURN SCSISGES.TYTBGESTREGION
   PIPELINED
IS
   CSL_0   CONSTANT INTEGER := 0;
   CSL_4   CONSTANT INTEGER := 4;
   CSL_7   CONSTANT INTEGER := 7;
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
              INTO out_rec.FIPREGESTIO
              FROM (  SELECT TAGES.FIPAISCU,
                             TAGES.FICANALCU,
                             TAGES.FISUCURSALCU,
                             TAGES.FIFOLIOCU
                        FROM    SCSISGES.TAGESTION TAGES
                             JOIN
                                SCSISGES.TCTIPOGESTION TCGES
                             ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
                       WHERE     TCGES.FITIPOGESTIONID = CSL_4
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
               out_rec.FIPREGESTIO := NULL;
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

            SELECT COUNT (
                      DISTINCT    C.FIPAISCU
                               || C.FICANALCU
                               || C.FISUCURSALCU
                               || C.FIFOLIO)
              INTO out_rec.FIPRESUPUES
              FROM SCVENTASTIENDA.TAPREPARAME PP
                   INNER JOIN SCVENTASTIENDA.TACENCTETIENDA C
                      ON     C.FINGCIOID = PP.FINGCIOID
                         AND C.FINOTIENDA = PP.FINOTIENDA
                         AND C.FICTEID = PP.FICTEID
                         AND C.FIDIGITOVER = PP.FIDIGITOVER
                   INNER JOIN SCVENTASTIENDA.TADETPREPARAM TP
                      ON     PP.FIPAIS = TP.FIPAIS
                         AND PP.FICANAL = TP.FICANAL
                         AND PP.FISUCURSAL = TP.FISUCURSAL
                         AND PP.FIFOLIOPARAM = TP.FIFOLIOPARAM
                   LEFT JOIN SCVENTASTIENDA.TCPRODUCTO T
                      ON TP.FIPRODID = T.FNSKU
                   INNER JOIN SCVENTASTIENDA.TCLINEA L
                      ON T.FNLINEASIE = L.FNLINEA
                   LEFT JOIN SCVENTASTIENDA.TAPEDIDOS P
                      ON PP.FIFOLIOPARAM = P.FIFOLIOPARAM
             WHERE PP.FISUCURSAL = eachRow.FIIDSUCURSAL
                   AND TRIM (PP.FCEMPNO) = eachRow.FNEMPLEADO
                   AND TO_DATE (FDFECPREP, 'DD/MM/YYYY') BETWEEN TO_DATE (
                                                                    SYSDATE,
                                                                    'DD/MM/YYYY')
                                                                 - CSL_7
                                                             AND TO_DATE (
                                                                    SYSDATE,
                                                                    'DD/MM/YYYY')
                   AND T.FNSKU > CSL_0
                   AND T.FNLINEASIE > CSL_0
                   AND T.FNLINEASAP > CSL_0
                   AND PP.FINOPEDIDO = CSL_0;

            PIPE ROW (out_rec);
         EXCEPTION
            WHEN OTHERS
            THEN
               out_rec.FIPRESUPUES := NULL;
         END;
      END LOOP;
   END IF;

   RETURN;
END FNGETPRESUPUESTOS;

/

  GRANT EXECUTE ON "SCSISGES"."FNGETPRESUPUESTOS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNGETPRESUPUESTOS" TO "USRSISGES";
