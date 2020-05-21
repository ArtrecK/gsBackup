--------------------------------------------------------
--  DDL for Function FNCOPPXSTDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOPPXSTDIA" (PA_FNSUCURSAL    NUMBER,
                                                  PA_FNEMPLEADO    NUMBER)
    RETURN NUMBER
IS
    -- Consulta ppxs total por empleado
    -- author  909511 - MJGM
    -- param   ID sucursal, ID del empleado
    -- return  Numero de ppxs total del empleado.

    CSL_0   CONSTANT INTEGER := 0;
    CSL_2   CONSTANT INTEGER := 2;
    vl_coun          NUMBER;
BEGIN
    SELECT COUNT (1)
      INTO vl_coun
      FROM (  SELECT TCEN.FIPAIS,
                     TCEN.FICANAL,
                     TCEN.FISUCURSAL,
                     TCEN.FIFOLIO
                FROM SCVENTASTIENDA.TACENCTETIENDA TCEN
                     JOIN SCVENTASTIENDA.TAPEDIDOS TAPED
                         ON     TCEN.FINGCIOID = TAPED.FINGCIOID
                            AND TCEN.FINOTIENDA = TAPED.FINOTIENDA
                            AND TCEN.FICTEID = TAPED.FICTEID
                            AND TCEN.FIDIGITOVER = TAPED.FIDIGITOVER
                            AND TRIM (TAPED.FCEMPNOVENTA) = PA_FNEMPLEADO
                            AND TAPED.FISUCURSAL = PA_FNSUCURSAL
                            AND TAPED.FIPEDSTAT = CSL_0
                            AND TAPED.FITIPOVENTA = CSL_2
                            AND tcen.fipaiscu > CSL_0
                            AND tcen.ficanalcu > CSL_0
                            AND tcen.fisucursalcu > CSL_0
                            AND tcen.fifolio > CSL_0
                            AND TCEN.FINGCIOID > CSL_0
                            AND TCEN.FINOTIENDA > CSL_0
                            AND TCEN.FICTEID > CSL_0
                            AND TCEN.FIDIGITOVER > CSL_0
            GROUP BY TCEN.FIPAIS,
                     TCEN.FICANAL,
                     TCEN.FISUCURSAL,
                     TCEN.FIFOLIO);

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOPPXSTDIA');
        RETURN CSL_0;
END FNCOPPXSTDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOPPXSTDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOPPXSTDIA" TO "USRSISGES";
