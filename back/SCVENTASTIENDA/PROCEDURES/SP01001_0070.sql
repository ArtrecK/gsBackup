--------------------------------------------------------
--  DDL for Procedure SP01001_0070
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0070" 
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
Descripcion: Recibe el registro 70 en texto separados por comas, 
             actualiza datos de Clientes la tabla TACLIENTES
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
Fecha de creacion: 24 de Abril del 2018
Modificacion : 24 de Abril del 2018
***************************************************************************************************/

   csl_recTAEST01001_0070    SCVENTASTIENDA.TAEST01001_0070%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_0070';   

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_0070;

   pa_ErrMsg := 'UPDATE/INSERT SCVENTASTIENDA.TACLIENTES';
   MERGE INTO SCVENTASTIENDA.TACLIENTES DATOS
      USING (SELECT pa_FiPaisId AS PAIS,
                    pa_FiCanalId AS CANAL,
                    pa_FiSucursalId AS SUCURSAL,     
                    csl_recTAEST01001_0070.FINGCIOID AS NGCIOID, 
                    csl_recTAEST01001_0070.FINOTIENDA AS NOTIENDA, 
                    csl_recTAEST01001_0070.FICTEID AS CTEID, 
                    csl_recTAEST01001_0070.FIDIGITOVER AS DIGITOVER
               FROM DUAL) VALORES
         ON (DATOS.FIPAIS = VALORES.PAIS
             AND DATOS.FICANAL = VALORES.CANAL
             AND DATOS.FISUCURSAL = VALORES.SUCURSAL
             AND DATOS.FINGCIOID = VALORES.NGCIOID
             AND DATOS.FINOTIENDA = VALORES.NOTIENDA
             AND DATOS.FICTEID = VALORES.CTEID
             AND DATOS.FIDIGITOVER = VALORES.DIGITOVER)
   WHEN MATCHED THEN
      UPDATE
      SET
         FCCTENOMBRE = csl_recTAEST01001_0070.FCCTENOMBRE,
         FCCTEAPATERNO = csl_recTAEST01001_0070.FCCTEAPATERNO,
         FCCTEAMATERNO = csl_recTAEST01001_0070.FCCTEAMATERNO,
         FCCTEDIRCALLE = csl_recTAEST01001_0070.FCCTEDIRCALLE,
         FCCTEDIRNOEXT = csl_recTAEST01001_0070.FCCTEDIRNOEXT,
         FCCTEDIRNOINT = csl_recTAEST01001_0070.FCCTEDIRNOINT,
         FCCTECP = csl_recTAEST01001_0070.FCCTECP,
         FCCTECOLONIA = csl_recTAEST01001_0070.FCCTECOLONIA,
         FITRANNOACT = pa_FiTranno
   WHEN NOT MATCHED THEN
      INSERT ( 
              FIPAIS,
              FICANAL,
              FISUCURSAL,
              FINGCIOID,
              FINOTIENDA,
              FICTEID,
              FIDIGITOVER,
              FCCTENOMBRE,
              FCCTEAPATERNO,
              FCCTEAMATERNO,
              FCCTEDIRCALLE,
              FCCTEDIRNOEXT,
              FCCTEDIRNOINT,
              FCCTECP,
              FCCTECOLONIA,
              FITRANNO,
              FITRANNOACT,
              FDCTEFECALT
             )
      VALUES ( 
              pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,     
              csl_recTAEST01001_0070.FINGCIOID, 
              csl_recTAEST01001_0070.FINOTIENDA, 
              csl_recTAEST01001_0070.FICTEID, 
              csl_recTAEST01001_0070.FIDIGITOVER,
              csl_recTAEST01001_0070.FCCTENOMBRE, 
              csl_recTAEST01001_0070.FCCTEAPATERNO, 
              csl_recTAEST01001_0070.FCCTEAMATERNO, 
              csl_recTAEST01001_0070.FCCTEDIRCALLE, 
              csl_recTAEST01001_0070.FCCTEDIRNOEXT, 
              csl_recTAEST01001_0070.FCCTEDIRNOINT, 
              csl_recTAEST01001_0070.FCCTECP, 
              csl_recTAEST01001_0070.FCCTECOLONIA,
              pa_FiTranno,
              pa_FiTranno,
              SYSDATE
             );

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_0070;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0070" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0070" TO "SCACTUALIZADORVT";
