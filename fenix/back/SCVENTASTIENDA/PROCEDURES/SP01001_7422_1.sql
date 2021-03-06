--------------------------------------------------------
--  DDL for Procedure SP01001_7422
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_7422" 
(  pa_FiPaisId     IN NUMBER
  ,pa_FiCanalId    IN NUMBER
  ,pa_FiSucursalId IN NUMBER
  ,pa_FiTranno     IN NUMBER
  ,pa_Fitrantipo   IN NUMBER
  ,pa_Ficonsectipo IN NUMBER
  ,pa_Fdtransfechr IN DATE
  ,pa_Fctranws     IN VARCHAR2
  ,pa_Fctranusr    IN VARCHAR2
  ,pa_Fitiporeg    IN NUMBER
  ,pa_Query        IN VARCHAR2
  ,pa_OraErr      IN OUT NOCOPY VARCHAR2
  ,pa_OraErrMesg  IN OUT NOCOPY VARCHAR2
  ,pa_ErrId        IN OUT NOCOPY NUMBER
  ,pa_ErrMsg       IN OUT NOCOPY VARCHAR2
)
IS
/**************************************************************************************************
Proyecto : SCVENTASTIENDA   
Descripcion: Recibe el registro 7422 en texto separados por comas, 
             actualiza la tabla TAPEDIDOS y TAPREPARAME(FINGCIOID, FICTEID, FINOTIENDA y FIDIGITOVER)
Par�metros de Entrada:    pa_FiPaisid     .- Identidicador del pais.de la transaccion
                          pa_FiCanalId    .- Identificador del canal de la transaccion
                          pa_FiSucursalId .- Ide ntificador de la sucursal.
                          pa_FiTranno     .- Numero de transaccion.                      
                          pa_Fitrantipo   .- Tipo de transaccion.
                          pa_Ficonsectipo .- Consecutivo de la transaccion.
                          pa_Fdtransfechr .- Fecha de la transaccion
                          pa_Fctranws     .- Estacion de trabajo donde se realizo la transaccion
                          pa_Fctranusr    .- Usuario la operacion
                          pa_Fitiporeg    .- Tipo de registro
                          pa_Query        .- Detalle del registro separado por coma     
Par�metros de Salida:     N/A
Valor de Retorno:         N/A
Par�metros de Entrada-Salida:  pa_OraErr$      .- Numero de cpdigo de error.
                               pa_OraErrMesg$  .- Mensaje de error
                               pa_ErrId        .- Numero de cpdigo de error.
                               pa_ErrMsg       .- Mensaje de error

Creador: Carolina P�rez Vite
Fecha de creacion: 30 de Abril del 2018
Modificacion : 30 de Abril del 2018
***************************************************************************************************/

   recTAEST01001_7422    SCVENTASTIENDA.TAEST01001_7422%ROWTYPE := NULL;
   vl_FolioParam          SCVENTASTIENDA.TAPEDIDOS.FIFOLIOPARAM%TYPE := 0;
   csl_ValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN

   pa_ErrMsg := 'TAEST01001_7422';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO recTAEST01001_7422;

   pa_ErrMsg := 'MERGE SCVENTASTIENDA.TAPEDIDOS';
   MERGE INTO SCVENTASTIENDA.TAPEDIDOS DATOS
      USING (SELECT pa_FiPaisId PAIS, 
                  pa_FiCanalId CANAL, 
                  pa_FiSucursalId  SUC, 
                  recTAEST01001_7422.FINOPEDIDO PEDIDO
             FROM DUAL) VALORES
               ON (DATOS.FIPAIS = VALORES.PAIS
              AND  DATOS.FICANAL = VALORES.CANAL
              AND  DATOS.FISUCURSAL = VALORES.SUC  
              AND  DATOS.FINOPEDIDO = VALORES.PEDIDO)
      WHEN MATCHED THEN
          UPDATE
             SET  FINGCIOID = recTAEST01001_7422.FINGCIOID,
                  FICTEID = recTAEST01001_7422.FICTEID,
                  FINOTIENDA = recTAEST01001_7422.FINOTIENDA,
                  FIDIGITOVER = recTAEST01001_7422.FIDIGITOVER;

   SELECT FIFOLIOPARAM
     INTO vl_FolioParam
     FROM SCVENTASTIENDA.TAPEDIDOS
    WHERE FIPAIS = pa_FiPaisId
      AND FICANAL = pa_FiCanalId
      AND FISUCURSAL = pa_FiSucursalId
      AND FINOPEDIDO = recTAEST01001_7422.FINOPEDIDO;

   MERGE INTO SCVENTASTIENDA.TAPREPARAME DATOS
      USING (SELECT pa_FiPaisId AS PAIS,
                    pa_FiCanalId AS CANAL,
                    pa_FiSucursalId AS SUCURSAL,     
                    vl_FolioParam AS FOLIOPARAM
               FROM DUAL) VALORES
         ON (DATOS.FIPAIS = VALORES.PAIS
             AND DATOS.FICANAL = VALORES.CANAL
             AND DATOS.FISUCURSAL = VALORES.SUCURSAL
             AND DATOS.FIFOLIOPARAM = VALORES.FOLIOPARAM)
   WHEN MATCHED THEN
      UPDATE 
         SET FINGCIOID = recTAEST01001_7422.FINGCIOID,
             FICTEID =recTAEST01001_7422.FICTEID,
             FINOTIENDA = recTAEST01001_7422.FINOTIENDA,
             FIDIGITOVER = recTAEST01001_7422.FIDIGITOVER;

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;

END SP01001_7422;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_7422" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_7422" TO "SCACTUALIZADORVT";
