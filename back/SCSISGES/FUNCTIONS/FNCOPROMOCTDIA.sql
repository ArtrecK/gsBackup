--------------------------------------------------------
--  DDL for Function FNCOPROMOCTDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOPROMOCTDIA" (PA_FNSUCURSAL    NUMBER,
                                                    PA_FNEMPLEADO    NUMBER)
    RETURN NUMBER
IS
    -- Consulta promociones total por empleado
    -- author  909511 - MJGM
    -- param   ID sucursal, ID del empleado
    -- return  Numero de promociones total del empleado.

    CSL_0    CONSTANT INTEGER := 0;
    CSL_1    CONSTANT INTEGER := 1;
    CSL_78   CONSTANT INTEGER := 78;
    vl_coun           NUMBER;
BEGIN
    SELECT COUNT (1)
      INTO vl_coun
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
               WHERE     A.FIIDCAMPANA NOT IN (CSL_78)
                     AND B.FIIDEMPLEADO = PA_FNEMPLEADO
                     AND B.FIIDSUCURSAL = PA_FNSUCURSAL
                     AND B.FNSTATUSCTE = CSL_1
                     AND A.FIIDCAMPANA = A.FIIDCAMPANA + CSL_0
                     AND A.FIIDCAMPANA > CSL_0
            GROUP BY B.FIPAIS,
                     B.FICANAL,
                     B.FISUCURSAL,
                     B.FIFOLIO);

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOPROMOCTDIA');
        RETURN CSL_0;
END FNCOPROMOCTDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOPROMOCTDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOPROMOCTDIA" TO "USRSISGES";
