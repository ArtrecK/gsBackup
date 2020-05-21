--------------------------------------------------------
--  DDL for Function FNGETGESTIONES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNGETGESTIONES" (
   PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
   PA_OPCION    IN NUMBER)
   RETURN SCSISGES.TYTBGESTREGION
   PIPELINED
IS
   out_rec   SCSISGES.TYOBGESTREGION
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
      SELECT FNEMPLEADO, FIPENSURGES AS FIIDSUCURSAL FROM TABLE (PA_DATOSIN);
BEGIN
   FOR eachRow IN cur_Empleados
   LOOP
      BEGIN
         out_rec.FIIDSUCURSAL := eachRow.FIIDSUCURSAL;
         out_rec.FNEMPLEADO := eachRow.FNEMPLEADO;

         SELECT COUNT (1)
           INTO out_rec.FIGESTIONES
           FROM (  SELECT COUNT (1)
                     FROM    SCSISGES.TAGESTION TAGES
                          JOIN
                             SCSISGES.TCTIPOGESTION TCGES
                          ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
                    WHERE     TCGES.FITIPOGESTIONID = PA_OPCION
                          AND TAGES.FCEMPNUM = eachRow.FNEMPLEADO
                          AND TAGES.FISUCURSALEMP = eachRow.FIIDSUCURSAL
                          AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE)
                 GROUP BY TAGES.FIPAISCU,
                          TAGES.FICANALCU,
                          TAGES.FISUCURSALCU,
                          TAGES.FIFOLIOCU);

         PIPE ROW (out_rec);
      EXCEPTION
         WHEN OTHERS
         THEN
            out_rec.FIGESTIONES := NULL;
      END;
   END LOOP;

   RETURN;
END FNGETGESTIONES;

/

  GRANT EXECUTE ON "SCSISGES"."FNGETGESTIONES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNGETGESTIONES" TO "USRSISGES";
