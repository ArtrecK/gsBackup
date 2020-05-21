--------------------------------------------------------
--  DDL for Procedure SP01001_0217
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0217" 
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
Descripcion: Recibe el registro 217 en texto separados por comas, 
             actualiza la tabla TADETPEDIDOS (FNCOMISIONG y FNCOMISIONV)
Par�metros de Entrada:    pa_FiPaisId     .- Identidicador del pais.de la transaccion
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
Par�metros de Entrada-Salida:  pa_OraErr      .- Numero de cpdigo de error.
                               pa_OraErrMesg  .- Mensaje de error
                               pa_ErrId        .- Numero de cpdigo de error.
                               pa_ErrMsg       .- Mensaje de error

Creador: Carolina P�rez Vite
Fecha de creacion: 30 de Abril del 2018
Modificacion : 30 de Abril del 2018
***************************************************************************************************/

   csl_recTAEST01001_0217    SCVENTASTIENDA.TAEST01001_0217%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN

   pa_ErrMsg := 'TAEST01001_0217';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_0217;

   pa_ErrMsg := 'MERGE SCVENTASTIENDA.TADETPEDIDOS';
   MERGE INTO SCVENTASTIENDA.TADETPEDIDOS DATOS
       USING (SELECT pa_FiPaisId PAIS, 
                     pa_FiCanalId CANAL, 
                     pa_FiSucursalId  SUC, 
                     csl_recTAEST01001_0217.FINOPEDIDO PEDIDO
                FROM DUAL) VALORES
                  ON (DATOS.FIPAIS = VALORES.PAIS
                 AND  DATOS.FICANAL = VALORES.CANAL
                 AND  DATOS.FISUCURSAL = VALORES.SUC  
                 AND  DATOS.FINOPEDIDO = VALORES.PEDIDO)
        WHEN MATCHED THEN
             UPDATE
                SET  FNCOMISIONG = csl_recTAEST01001_0217.FNCOMISIONG,
                     FNCOMISIONV = csl_recTAEST01001_0217.FNCOMISIONV;

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;

END SP01001_0217;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0217" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0217" TO "SCACTUALIZADORVT";
