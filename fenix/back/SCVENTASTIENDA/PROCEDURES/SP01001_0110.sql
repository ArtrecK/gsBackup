--------------------------------------------------------
--  DDL for Procedure SP01001_0110
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0110" 
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
Descripcion: Recibe el registro 110 en texto separados por comas, 
             inserta en la tabla TADETPEDIDOS
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
Fecha de creacion: 27 de Abril del 2018
Modificacion : 27 de Abril del 2018
***************************************************************************************************/

   recTAEST01001_0110    SCVENTASTIENDA.TAEST01001_0110%ROWTYPE := NULL;
   cslValorCero          NUMBER(1) := 0;
   excParentKey          NUMBER(5):= -2291;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_0110';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO recTAEST01001_0110;

   BEGIN 
      pa_ErrMsg := 'INSERT SCVENTASTIENDA.TADETPEDIDOS';

      MERGE INTO SCVENTASTIENDA.TADETPEDIDOS DET
           USING (SELECT pa_FiPaisId AS PAIS,
                         pa_FiCanalId AS CANAL,
                         pa_FiSucursalId AS SUCURSAL,
                         recTAEST01001_0110.FINOPEDIDO AS NOPEDIDO,
                         recTAEST01001_0110.FIPRODID AS PRODID
                    FROM DUAL) TMP
              ON (TMP.PAIS = DET.FIPAIS AND
                  TMP.CANAL = DET.FICANAL AND
                  TMP.SUCURSAL = DET.FISUCURSAL AND
                  TMP.NOPEDIDO = DET.FINOPEDIDO AND
                  TMP.PRODID = DET.FIPRODID
                 )
      WHEN NOT MATCHED THEN
         INSERT (
                 FIPAIS, 
                 FICANAL, 
                 FISUCURSAL, 
                 FINOPEDIDO, 
                 FIPRODID, 
                 FICANTART, 
                 FNPRCUNIT, 
                 FNPDCTODESCTO, 
                 FNPRODDESCTOE, 
                 FNCOMISIONG, 
                 FNCOMISIONV, 
                 FNIMPSOBREP, 
                 FNCOSTOPDCTO, 
                 FNPORCENGANCHE, 
                 FNINTERESES, 
                 FNPORCIVA, 
                 FNDESCTOMKT, 
                 FNPRECIOVENTA,
                 FICVEPROM
                )
         VALUES (
                 pa_FiPaisId, 
                 pa_FiCanalId, 
                 pa_FiSucursalId, 
                 recTAEST01001_0110.FINOPEDIDO, 
                 recTAEST01001_0110.FIPRODID, 
                 recTAEST01001_0110.FICANTART, 
                 recTAEST01001_0110.FNPRCUNIT, 
                 recTAEST01001_0110.FNPDCTODESCTO, 
                 recTAEST01001_0110.FNPRODDESCTOE, 
                 recTAEST01001_0110.FNCOMISIONG, 
                 recTAEST01001_0110.FNCOMISIONV, 
                 recTAEST01001_0110.FNIMPSOBREP, 
                 recTAEST01001_0110.FNCOSTOPDCTO, 
                 recTAEST01001_0110.FNPORCPROMOENG, 
                 recTAEST01001_0110.FNINTERESES, 
                 recTAEST01001_0110.FIPORCIVA, 
                 recTAEST01001_0110.FNDESCTOMKT, 
                 recTAEST01001_0110.FNPRECIOVENTA,
                 recTAEST01001_0110.FICVEPROM
                );                   

   EXCEPTION 
   WHEN OTHERS THEN
      IF SQLCODE = excParentKey THEN
         --en caso de cualquier otro error
         pa_ErrMsg := 'ORA-02291: integrity constraint (FK_TADETPEDIDOS_01) violated - parent key not found.';
         pa_ErrId := excParentKey;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
      ELSE
         --en caso de cualquier otro error
         pa_ErrId := 0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
      END IF;
   END; 

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := cslValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_0110;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0110" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0110" TO "SCACTUALIZADORVT";
