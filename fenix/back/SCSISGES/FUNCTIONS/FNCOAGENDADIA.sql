--------------------------------------------------------
--  DDL for Function FNCOAGENDADIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOAGENDADIA" (PA_FNEMPLEADO    NUMBER,
                                                   PA_OPCION        NUMBER)
    RETURN NUMBER
IS
    -- Consulta agenda por empleado
    -- author  909511 - MJGM
    -- param   ID Empleado, ID tipo de agenda
    -- return  Numero de registro en agenda del empleado.

    CSL_0   CONSTANT INTEGER := 0;
    CSL_1   CONSTANT INTEGER := 1;
    CSL_2   CONSTANT INTEGER := 2;
    CSL_3   CONSTANT INTEGER := 3;
    vl_coun          NUMBER;
BEGIN
    IF PA_OPCION IN (CSL_1, CSL_2, CSL_3)
    THEN
        SELECT COUNT (ev.FIUSUARIOID)
          INTO vl_coun
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = PA_OPCION
               AND TRUNC (ev.FDBITACORA) = TRUNC (SYSDATE)
               AND ev.FIUSUARIOID = PA_FNEMPLEADO;
    END IF;

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOAGENDADIA');
        RETURN CSL_0;
END FNCOAGENDADIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOAGENDADIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOAGENDADIA" TO "USRSISGES";
