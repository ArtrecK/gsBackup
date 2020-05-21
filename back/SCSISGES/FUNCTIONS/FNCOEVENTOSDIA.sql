--------------------------------------------------------
--  DDL for Function FNCOEVENTOSDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOEVENTOSDIA" (PA_FNEMPLEADO NUMBER)
    RETURN NUMBER
IS
    -- Consulta eventos  por empleado
    -- author  909511 - MJGM
    -- param   ID tipo de agenda
    -- return  Numero de eventos del empleado.

    CSL_0   CONSTANT INTEGER := 0;
    vl_coun          NUMBER;
BEGIN
    SELECT COUNT (ev.FIUSUARIOID)
      INTO vl_coun
      FROM SCSISGES.TAEVENTO ev
     WHERE     TRUNC (ev.FDFECHA) = TRUNC (SYSDATE)
           AND ev.FIUSUARIOID = PA_FNEMPLEADO;

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOEVENTOSDIA');
        RETURN CSL_0;
END FNCOEVENTOSDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOEVENTOSDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOEVENTOSDIA" TO "USRSISGES";
