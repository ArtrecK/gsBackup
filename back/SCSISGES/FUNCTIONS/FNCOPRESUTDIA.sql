--------------------------------------------------------
--  DDL for Function FNCOPRESUTDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOPRESUTDIA" (PA_FNSUCURSAL    NUMBER,
                                                   PA_FNEMPLEADO    NUMBER)
    RETURN NUMBER
IS
    -- Consulta presupuestos total por empleado
    -- author  909511 - MJGM
    -- param   ID sucursal, ID del empleado
    -- return  Numero de presupuestos total del empleado.

    CSL_0   CONSTANT INTEGER := 0;
    CSL_7   CONSTANT INTEGER := 7;
    vl_coun          NUMBER;
BEGIN
    SELECT COUNT (
               DISTINCT    C.FIPAISCU
                        || C.FICANALCU
                        || C.FISUCURSALCU
                        || C.FIFOLIO)
      INTO vl_coun
      FROM SCVENTASTIENDA.TAPREPARAME  PP
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
           LEFT JOIN SCVENTASTIENDA.TCPRODUCTO T ON TP.FIPRODID = T.FNSKU
           INNER JOIN SCVENTASTIENDA.TCLINEA L ON T.FNLINEASIE = L.FNLINEA
           LEFT JOIN SCVENTASTIENDA.TAPEDIDOS P
               ON PP.FIFOLIOPARAM = P.FIFOLIOPARAM
     WHERE     PP.FISUCURSAL = PA_FNSUCURSAL
           AND TRIM (PP.FCEMPNO) = PA_FNEMPLEADO
           AND TRUNC (FDFECPREP) BETWEEN TRUNC (SYSDATE) - CSL_7
                                     AND TRUNC (SYSDATE)
           AND T.FNSKU > CSL_0
           AND T.FNLINEASIE > CSL_0
           AND T.FNLINEASAP > CSL_0
           AND PP.FINOPEDIDO = CSL_0;

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOPRESUTDIA');
        RETURN CSL_0;
END FNCOPRESUTDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOPRESUTDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOPRESUTDIA" TO "USRSISGES";
