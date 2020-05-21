--------------------------------------------------------
--  DDL for Function FNCOSOLICTDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCOSOLICTDIA" (PA_FNSUCURSAL    NUMBER,
                                                   PA_FNEMPLEADO    NUMBER)
    RETURN NUMBER
IS
    -- Consulta solicitudes total por empleado
    -- author  909511 - MJGM
    -- param   ID sucursal, ID del empleado
    -- return  Numero de solicitudes total del empleado.

    CSL_0   CONSTANT INTEGER := 0;
    CSL_7   CONSTANT INTEGER := 7;
    CSL_9   CONSTANT INTEGER := 9;
    vl_coun          NUMBER;
BEGIN
    SELECT COUNT (1)
      INTO vl_coun
      FROM (SELECT T.FIIDNEGOCIO,
                   T.FIIDTIENDA,
                   T.FIIDCLIENTE,
                   T.FIPAIS,
                   T.FICANAL,
                   T.FISUCURSAL,
                   T.FISOLICITUDID,
                   TC.FINGCIOID,
                   TC.FINOTIENDA,
                   TC.FICTEID,
                   TC.FIDIGITOVER,
                   TC.FISUCURSAL AS FIIDSUCURSAL
              FROM SCVENTASTIENDA.TASOLICITUDES  T,
                   SCVENTASTIENDA.TACREDCTECTES  TC
             WHERE     T.FIIDNEGOCIO = TC.FIIDNEGOCIO
                   AND T.FIIDTIENDA = TC.FIIDTIENDA
                   AND T.FIIDCLIENTE = TC.FIIDCLIENTE
                   AND T.FCEMPNO = PA_FNEMPLEADO
                   AND TC.FISUCURSAL = PA_FNSUCURSAL) TS
           INNER JOIN SCVENTASTIENDA.TACLIENTES TACL
               ON (    TACL.FIPAIS = TS.FIPAIS
                   AND TACL.FICANAL = TS.FICANAL
                   AND TACL.FISUCURSAL = TS.FISUCURSAL
                   AND TS.FINGCIOID = TACL.FINGCIOID
                   AND TS.FINOTIENDA = TACL.FINOTIENDA
                   AND TS.FICTEID = TACL.FICTEID
                   AND TS.FIDIGITOVER = TACL.FIDIGITOVER)
           INNER JOIN SCVENTASTIENDA.TACREDSOLICITUD TACR
               ON (    TACR.FISOLICITUDID = TS.FISOLICITUDID
                   AND TS.FIIDSUCURSAL = TACR.FISUCURSAL)
           INNER JOIN SCVENTASTIENDA.TAESTSOLICITUD TAES
               ON (TAES.FIESTATUS = TACR.FISTAT)
           LEFT JOIN SCVENTASTIENDA.TAPEDIDOS PED
               ON     TS.FINGCIOID = PED.FINGCIOID
                  AND TS.FINOTIENDA = PED.FINOTIENDA
                  AND TS.FICTEID = PED.FICTEID
                  AND TS.FIDIGITOVER = PED.FIDIGITOVER
     WHERE     PED.FINOPEDIDO IS NULL
           AND (   (TACR.FISTAT = CSL_9 AND TACR.FDFECSTAT > SYSDATE - CSL_7)
                OR TACR.FISTAT <> CSL_9);

    RETURN vl_coun;
EXCEPTION
    WHEN OTHERS
    THEN
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, 0, 200),
                            'SCSISGES.FNCOSOLICTDIA');
        RETURN CSL_0;
END FNCOSOLICTDIA;

/

  GRANT EXECUTE ON "SCSISGES"."FNCOSOLICTDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCOSOLICTDIA" TO "USRSISGES";
