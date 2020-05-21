--------------------------------------------------------
--  DDL for Procedure SP01001_4462
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_4462" 
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
Descripcion: Recibe el registro 4462 en texto separados por comas, 
             inserta en la tabla TACENCTETIENDA
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
Fecha de creacion: 27 de Abril del 2018
Modificacion : 11 de Mayo del 2018
***************************************************************************************************/

   recTAEST01001_4462    SCVENTASTIENDA.TAEST01001_4462%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_4462';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO recTAEST01001_4462;

   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TACENCTETIENDA';

   MERGE INTO SCVENTASTIENDA.TACENCTETIENDA C
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      recTAEST01001_4462.FINGCIOID AS NGCIOID,
                      recTAEST01001_4462.FINOTIENDA AS NOTIENDA,
                      recTAEST01001_4462.FICTEID AS CTEID,
                      recTAEST01001_4462.FIDIGITOVER AS DIGITOVER,
                      recTAEST01001_4462.FIFOLIO AS FOLIO
                 FROM DUAL) TMP
           ON (TMP.PAIS = C.FIPAIS AND
               TMP.CANAL = C.FICANAL AND
               TMP.SUCURSAL = C.FISUCURSAL AND
               TMP.NGCIOID = C.FINGCIOID AND
               TMP.NOTIENDA = C.FINOTIENDA AND
               TMP.CTEID = C.FICTEID AND
               TMP.DIGITOVER = C.FIDIGITOVER AND
               TMP.FOLIO = C.FIFOLIO
              )
   WHEN NOT MATCHED THEN   
      INSERT (
              FIPAIS, 
              FICANAL, 
              FISUCURSAL, 
              FIPAISCU, 
              FICANALCU, 
              FISUCURSALCU,
              FINGCIOID, 
              FINOTIENDA, 
              FICTEID, 
              FIDIGITOVER, 
              FIFOLIO,
              FDFECHAALTA
             )
      VALUES (pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,
              recTAEST01001_4462.FIPAIS, 
              recTAEST01001_4462.FICANAL, 
              recTAEST01001_4462.FISUCURSAL,
              recTAEST01001_4462.FINGCIOID, 
              recTAEST01001_4462.FINOTIENDA, 
              recTAEST01001_4462.FICTEID, 
              recTAEST01001_4462.FIDIGITOVER,
              recTAEST01001_4462.FIFOLIO,
              SYSDATE
              );

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_4462;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4462" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4462" TO "SCACTUALIZADORVT";
