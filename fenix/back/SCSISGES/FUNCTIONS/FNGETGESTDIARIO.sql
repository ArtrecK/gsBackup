--------------------------------------------------------
--  DDL for Function FNGETGESTDIARIO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNGETGESTDIARIO" (
   PA_DATOSIN   IN SCSISGES.TYTBGESTIONBRANCH,
   PA_OPCION    IN NUMBER)
   RETURN SCSISGES.TYTBGESTREGION
   PIPELINED
IS
   CSL_1   CONSTANT INTEGER := 1;
   CSL_2   CONSTANT INTEGER := 2;
   CSL_3   CONSTANT INTEGER := 3;
   CSL_4   CONSTANT INTEGER := 4;
   CSL_5   CONSTANT INTEGER := 5;
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
      SELECT FNEMPLEADO, FIPENSURGES AS FIIDSUCURSAL FROM TABLE (PA_DATOSIN);
BEGIN
   --consultar llamada
   IF PA_OPCION IN (CSL_1, CSL_2, CSL_3)
   THEN
      FOR eachRow IN cur_Empleados
      LOOP
         BEGIN
            out_rec.FIIDSUCURSAL := eachRow.FIIDSUCURSAL;
            out_rec.FNEMPLEADO := eachRow.FNEMPLEADO;

            SELECT COUNT (ev.FIUSUARIOID)
              INTO out_rec.FIGESTIONES
              FROM SCSISGES.TAEVENTO ev
             WHERE ev.FIEVENTO = PA_OPCION
                   AND TO_DATE (ev.FDBITACORA, 'dd-MM-yy') =
                          TO_DATE (SYSDATE, 'dd-MM-yy')
                   AND ev.FIUSUARIOID = eachRow.FNEMPLEADO;

            PIPE ROW (out_rec);
         EXCEPTION
            WHEN OTHERS
            THEN
               out_rec.FIGESTIONES := NULL;
         END;
      END LOOP;
   --consultar total de solicitudes
   ELSIF PA_OPCION = CSL_4
   THEN
      FOR eachRow IN cur_Empleados
      LOOP
         BEGIN
            out_rec.FIIDSUCURSAL := eachRow.FIIDSUCURSAL;
            out_rec.FNEMPLEADO := eachRow.FNEMPLEADO;

            SELECT COUNT (ev.FIUSUARIOID)
              INTO out_rec.FIGESTIONES
              FROM SCSISGES.TAEVENTO ev
             WHERE TO_DATE (ev.FDFECHA, 'dd-MM-yy') =
                      TO_DATE (SYSDATE, 'dd-MM-yy')
                   AND ev.FIUSUARIOID = eachRow.FNEMPLEADO;

            PIPE ROW (out_rec);
         EXCEPTION
            WHEN OTHERS
            THEN
               out_rec.FIGESTIONES := NULL;
         END;
      END LOOP;
   ELSIF PA_OPCION = 5
   THEN
      FOR eachRow IN cur_Empleados
      LOOP
         BEGIN
            out_rec.FIIDSUCURSAL := eachRow.FIIDSUCURSAL;
            out_rec.FNEMPLEADO := eachRow.FNEMPLEADO;

            SELECT COUNT (1)
              INTO out_rec.FIGESTIONES
              FROM    SCSISGES.TAALERTA TA
                   JOIN
                      SCSISGES.TAALERTAPERSONA TPER
                   ON TPER.FIALERTAID = TA.FIALERTAID
             WHERE TPER.FIEMPNUM = eachRow.FNEMPLEADO
                   AND NOT EXISTS
                              (SELECT TEMP.FIALERTAID
                                 FROM SCSISGES.TAEMPALERTA TEMP
                                WHERE TEMP.FIEMPNUM = TPER.FIEMPNUM
                                      AND TEMP.FIALERTAID = TPER.FIALERTAID);

            PIPE ROW (out_rec);
         EXCEPTION
            WHEN OTHERS
            THEN
               out_rec.FIGESTIONES := NULL;
         END;
      END LOOP;
   END IF;

   RETURN;
END FNGETGESTDIARIO;

/

  GRANT EXECUTE ON "SCSISGES"."FNGETGESTDIARIO" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNGETGESTDIARIO" TO "USRSISGES";
