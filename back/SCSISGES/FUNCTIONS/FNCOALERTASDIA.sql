--------------------------------------------------------
--  DDL for Function FNCOALERTASDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOALERTASDIA" (PA_FNEMPLEADO NUMBER)
    RETURN NUMBER
IS
    -- Consulta alertas por empleado
    -- author  909511 - MJGM
    -- param   ID del empleado
    -- return  Numero de alertas del empleado.

    CSL_0   CONSTANT INTEGER := 0;
    vl_coun          NUMBER;
BEGIN
    SELECT COUNT (1)
      INTO vl_coun
      FROM SCSISGES.TAALERTA  TA
           JOIN SCSISGES.TAALERTAPERSONA TPER
               ON TPER.FIALERTAID = TA.FIALERTAID
     WHERE     TPER.FIEMPNUM = PA_FNEMPLEADO
           AND NOT EXISTS
                   (SELECT TEMP.FIALERTAID
                      FROM SCSISGES.TAEMPALERTA TEMP
                     WHERE     TEMP.FIEMPNUM = TPER.FIEMPNUM
                           AND TEMP.FIALERTAID = TPER.FIALERTAID);

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOALERTASDIA');
        RETURN CSL_0;
END FNCOALERTASDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOALERTASDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOALERTASDIA" TO "USRSISGES";
