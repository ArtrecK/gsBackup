--------------------------------------------------------
--  DDL for Procedure SP01001_0120
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0120" 
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
Descripcion: Recibe el registro 120 en texto separados por comas, 
             inserta en la tabla TAMOVPEDIDOS
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
Modificacion : 11 de Mayo del 2018
***************************************************************************************************/

   recTAEST01001_0120    SCVENTASTIENDA.TAEST01001_0120%ROWTYPE := NULL;
   cslValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_0120';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO recTAEST01001_0120;


   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TAMOVPEDIDOS';

   IF(recTAEST01001_0120.FITIPOOP IN (6,4,108))
   THEN
      MERGE INTO SCVENTASTIENDA.TAMOVPEDIDOS DET
           USING (SELECT pa_FiPaisId AS PAIS,
                         pa_FiCanalId AS CANAL,
                         pa_FiSucursalId AS SUCURSAL,
                         recTAEST01001_0120.FINOPEDIDO AS NOPEDIDO,
                         recTAEST01001_0120.FICONSNOMOVTO AS NOMOVTO
                    FROM DUAL) TMP
              ON (TMP.PAIS = DET.FIPAIS AND
                  TMP.CANAL = DET.FICANAL AND
                  TMP.SUCURSAL = DET.FISUCURSAL AND
                  TMP.NOPEDIDO = DET.FINOPEDIDO AND
                  TMP.NOMOVTO = DET.FINOMOVTO
                 )
      WHEN NOT MATCHED THEN   
         INSERT (
                 FIPAIS, 
                 FICANAL, 
                 FISUCURSAL, 
                 FINOPEDIDO, 
                 FINOMOVTO, 
                 FINOTRANSAC, 
                 FITIPOOP, 
                 FDFECMOVTOPED, 
                 FIMOVPCARABO, 
                 FNMOVPIMP, 
                 FCUSERID, 
                 FCWS, 
                 FICONCEPMOV
                )
         VALUES (pa_FiPaisId,
                 pa_FiCanalId,
                 pa_FiSucursalId,
                 recTAEST01001_0120.FINOPEDIDO,
                 recTAEST01001_0120.FICONSNOMOVTO,
                 pa_FiTranno,
                 recTAEST01001_0120.FITIPOOP,
                 recTAEST01001_0120.FDFECMOVTOPED,
                 recTAEST01001_0120.FIMOVPCARABO,
                 recTAEST01001_0120.FNMOVPIMP,
                 ' ',
                 ' ',
                 recTAEST01001_0120.FICONCEPMOV
                 );
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := cslValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_0120;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0120" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0120" TO "SCACTUALIZADORVT";
