--------------------------------------------------------
--  DDL for Function FNCOGESTIONDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOGESTIONDIA" (
    PA_FIIDSUCURSAL    NUMBER,
    PA_FNEMPLEADO      NUMBER,
    PA_TIPOGES         NUMBER)
    RETURN NUMBER
IS
    -- Consulta gestiones  por empleado
    -- author  909511 - MJGM
    -- param   ID de sucursal, ID Empleado
    -- return  Numero de gestiones.

    CSL_0   CONSTANT INTEGER := 0;
    vl_gestioncoun   NUMBER;
BEGIN
    SELECT COUNT (1)
      INTO vl_gestioncoun
      FROM (  SELECT COUNT (1)
                FROM SCSISGES.TAGESTION TAGES
                     JOIN SCSISGES.TCTIPOGESTION TCGES
                         ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
               WHERE     TCGES.FITIPOGESTIONID = PA_TIPOGES
                     AND TAGES.FCEMPNUM = PA_FNEMPLEADO
                     AND TAGES.FISUCURSALEMP = PA_FIIDSUCURSAL
                     AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE)
            GROUP BY TAGES.FIPAISCU,
                     TAGES.FICANALCU,
                     TAGES.FISUCURSALCU,
                     TAGES.FIFOLIOCU);

    RETURN vl_gestioncoun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOGESTIONDIA');
        RETURN CSL_0;
END FNCOGESTIONDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOGESTIONDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOGESTIONDIA" TO "USRSISGES";
