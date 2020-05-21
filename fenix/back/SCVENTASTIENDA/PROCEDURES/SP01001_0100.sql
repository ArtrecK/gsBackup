--------------------------------------------------------
--  DDL for Procedure SP01001_0100
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0100" 
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
  ,pa_OraErr$      IN OUT NOCOPY VARCHAR2
  ,pa_OraErrMesg$  IN OUT NOCOPY VARCHAR2
  ,pa_ErrId        IN OUT NOCOPY NUMBER
  ,pa_ErrMsg       IN OUT NOCOPY VARCHAR2
)
IS
/**************************************************************************************************
Proyecto : SCVENTASTIENDA   
Descripcion: Recibe el registro 100 en texto separados por comas, 
             inserta en la tabla PEDIDOS
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
Par�metros de Entrada-Salida:  pa_OraErr$      .- Numero de cpdigo de error.
                               pa_OraErrMesg$  .- Mensaje de error
                               pa_ErrId        .- Numero de cpdigo de error.
                               pa_ErrMsg       .- Mensaje de error

Creador: Carolina P�rez Vite
Fecha de creacion: 27 de Abril del 2018
Modificacion : 11 de Mayo del 2018
***************************************************************************************************/

   recTAEST01001_0100    SCVENTASTIENDA.TAEST01001_0100%ROWTYPE := NULL;
   cslValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_0100';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO recTAEST01001_0100;

   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TAPEDIDOS ';

   MERGE INTO SCVENTASTIENDA.TAPEDIDOS DET
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      recTAEST01001_0100.FINOPEDIDO AS NOPEDIDO
                 FROM DUAL) TMP
           ON (TMP.PAIS = DET.FIPAIS AND
               TMP.CANAL = DET.FICANAL AND
               TMP.SUCURSAL = DET.FISUCURSAL AND
               TMP.NOPEDIDO = DET.FINOPEDIDO
              )
   WHEN NOT MATCHED THEN   
      INSERT (
              FIPAIS, 
              FICANAL, 
              FISUCURSAL, 
              FINOPEDIDO, 
              FINGCIOID, 
              FINOTIENDA, 
              FICTEID, 
              FIDIGITOVER, 
              FCEMPNOVENTA,
              FITIPOVENTA, 
              FDPEDFEC, 
              FIFOLIOPARAM, 
              FDFECHAARRIBO
             )
      VALUES (pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,
              recTAEST01001_0100.FINOPEDIDO, 
              recTAEST01001_0100.FINGCIOID, 
              recTAEST01001_0100.FINOTIENDA, 
              recTAEST01001_0100.FICTEID, 
              recTAEST01001_0100.FIDIGITOVER, 
              trim(recTAEST01001_0100.FCEMPNO), 
              recTAEST01001_0100.FITIPOVENTA, 
              recTAEST01001_0100.FDPEDFEC, 
              recTAEST01001_0100.FCFOLIOPARAM,
              SYSDATE
              );

      pa_ErrMsg := 'UPDATE SCVENTASTIENDA.TAPREPARAME ';
      UPDATE SCVENTASTIENDA.TAPREPARAME
         SET FINOPEDIDO = recTAEST01001_0100.FINOPEDIDO
       WHERE FIPAIS = pa_FiPaisId
         AND FICANAL = pa_FiCanalId
         AND FISUCURSAL = pa_FiSucursalId
         AND FIFOLIOPARAM = recTAEST01001_0100.FCFOLIOPARAM;


   IF (recTAEST01001_0100.FITIPOVENTA = 4) 
  THEN
   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TAPEDIDOS';
   UPDATE SCVENTASTIENDA.TAPEDIDOS DET
      SET  DET.FCEMPNOSURTE= TRIM(recTAEST01001_0100.Fcempno)
      where FIFOLIOPARAM = recTAEST01001_0100.FCFOLIOPARAM;
      COMMIT;



   ELSIF(recTAEST01001_0100.FITIPOVENTA = 2)
   THEN
      pa_ErrMsg := 'INSERT SCVENTASTIENDA.TACREDITO ';
      MERGE INTO SCVENTASTIENDA.TACREDITO CRED
           USING (SELECT pa_FiPaisId AS PAIS,
                         pa_FiCanalId AS CANAL,
                         pa_FiSucursalId AS SUCURSAL,
                         recTAEST01001_0100.FINOPEDIDO AS NOPEDIDO
                    FROM DUAL) TEM
              ON (TEM.PAIS = CRED.FIPAIS AND
                  TEM.CANAL = CRED.FICANAL AND
                  TEM.SUCURSAL = CRED.FISUCURSAL AND
                  TEM.NOPEDIDO = CRED.FINOPEDIDO
                 )
      WHEN NOT MATCHED THEN   
         INSERT (
                  FIPAIS,
                  FICANAL,
                  FISUCURSAL,
                  FINOPEDIDO,
                  FIPLAZO,
                  FIPERIODO,
                  FNENGANCHE,
                  FNPEDPAGOPER,
                  FNPEDULTPAGO,
                  FICLASIFCUENTA,
                  FNPEDIMPMORA,
                  FNULTIMPMORA,
                  FINOATRASOS,
                  FIPERIODOACT,
                  FINOPERIODOCORR,
                  FIDIASGRACIA,
                  FNIMPPAGADO,
                  FNIMPDEVENG,
                  FCSTATCARTERA,
                  FITIR,
                  FNPAGOMIN,
                  FNIMPBONIF,
                  FIZONACOBRO,
                  FCCOBRADOR,
                  FITIPOCTA
                )
         VALUES ( 
                  pa_FiPaisId,
                  pa_FiCanalId,
                  pa_FiSucursalId,
                  recTAEST01001_0100.FINOPEDIDO,
                  recTAEST01001_0100.FIPLAZO,
                  recTAEST01001_0100.FIPERIODO,
                  0,               
                  recTAEST01001_0100.FNPEDPAGOPER,
                  recTAEST01001_0100.FNPEDULTPAGO,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  0,
                  '0',
                  0,
                  0,
                  0,
                  0,
                  ' ',
                  recTAEST01001_0100.FITIPOCTA
                 );
   END IF;


EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := cslValorCero;
      pa_OraErr$ := SQLCODE;
      pa_OraErrMesg$ := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_0100;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0100" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0100" TO "SCACTUALIZADORVT";
