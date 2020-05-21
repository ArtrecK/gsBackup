--------------------------------------------------------
--  DDL for Procedure SP01001_0050
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0050" 
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
Descripcion: Recibe el registro 50 en texto separados por comas, 
             inserta en la tabla TAPREPARAME
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
Fecha de creacion: 25 de Abril del 2018
Modificacion : 25 de Abril del 2018
***************************************************************************************************/

   csl_recTAEST01001_0050    SCVENTASTIENDA.TAEST01001_0050%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   csl_excParentKey          NUMBER(5):= -2291;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_0050';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_0050;

   pa_ErrMsg := 'UPDATE/INSERT SCVENTASTIENDA.TAPREPARAME';
   MERGE INTO SCVENTASTIENDA.TAPREPARAME DATOS
      USING (SELECT pa_FiPaisId AS PAIS,
                    pa_FiCanalId AS CANAL,
                    pa_FiSucursalId AS SUCURSAL,     
                    csl_recTAEST01001_0050.FCFOLIOPARAM AS FOLIOPARAM
               FROM DUAL) VALORES
         ON (DATOS.FIPAIS = VALORES.PAIS
             AND DATOS.FICANAL = VALORES.CANAL
             AND DATOS.FISUCURSAL = VALORES.SUCURSAL
             AND DATOS.FIFOLIOPARAM = VALORES.FOLIOPARAM)
   WHEN MATCHED THEN
      UPDATE 
         SET FNPABO = csl_recTAEST01001_0050.FNPABO, 
             FNUABO = csl_recTAEST01001_0050.FNUABO,
             FIPLAZO = csl_recTAEST01001_0050.FIPLAZO

   WHEN NOT MATCHED THEN
      INSERT ( 
              FIPAIS, 
              FICANAL, 
              FISUCURSAL, 
              FIFOLIOPARAM, 
              FINGCIOID, 
              FINOTIENDA, 
              FICTEID, 
              FIDIGITOVER, 
              FITIPOVENTA, 
              FCEMPNO, 
              FIPLAZO, 
              FIPERIODO, 
              FNPABO, 
              FNUABO, 
              FDFECPREP, 
              FIAUTORIZA, 
              FITRANNO
             )
      VALUES ( 
              pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,
              csl_recTAEST01001_0050.FCFOLIOPARAM, 
              csl_recTAEST01001_0050.FINGCIOID, 
              csl_recTAEST01001_0050.FINOTIENDA, 
              csl_recTAEST01001_0050.FICTEID, 
              csl_recTAEST01001_0050.FIDIGITOVER, 
              csl_recTAEST01001_0050.FITIPOVENTA, 
              TRIM(csl_recTAEST01001_0050.FCEMPNO), 
              csl_recTAEST01001_0050.FIPLAZO, 
              csl_recTAEST01001_0050.FIPERIODO, 
              csl_recTAEST01001_0050.FNPABO, 
              csl_recTAEST01001_0050.FNUABO, 
              csl_recTAEST01001_0050.FDFECPREP, 
              csl_recTAEST01001_0050.FIAUTORIZA,
              pa_FiTranno
             );

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_0050;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0050" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0050" TO "SCACTUALIZADORVT";
