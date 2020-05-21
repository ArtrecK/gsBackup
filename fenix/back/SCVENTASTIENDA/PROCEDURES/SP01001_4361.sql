--------------------------------------------------------
--  DDL for Procedure SP01001_4361
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_4361" 
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
Descripcion: Recibe el registro 4361 en texto separados por comas, 
             inserta en la tabla TACREDCLIENTES
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

   csl_recTAEST01001_4361    SCVENTASTIENDA.TAEST01001_4361%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_4361';
   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;
   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_4361;


   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TACREDCLIENTES';

   MERGE INTO SCVENTASTIENDA.TACREDCLIENTES CLI
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      csl_recTAEST01001_4361.FIIDNEGOCIO AS IDNEGOCIO, 
                      csl_recTAEST01001_4361.FIIDTIENDA AS IDTIENDA, 
                      csl_recTAEST01001_4361.FIIDCLIENTE AS IDCLIENTE
                 FROM DUAL) TMP
           ON (TMP.PAIS = CLI.FIPAIS AND
               TMP.CANAL = CLI.FICANAL AND
               TMP.SUCURSAL = CLI.FISUCURSAL AND
               TMP.IDNEGOCIO = CLI.FIIDNEGOCIO AND
               TMP.IDTIENDA = CLI.FIIDTIENDA AND
               TMP.IDCLIENTE = CLI.FIIDCLIENTE
              )
   WHEN NOT MATCHED THEN   
      INSERT (
              FIPAIS, 
              FICANAL, 
              FISUCURSAL, 
              FIIDNEGOCIO, 
              FIIDTIENDA, 
              FIIDCLIENTE, 
              FIIDPERSONA, 
              FITIPOCLIENTE, 
              FIFISMOR, 
              FDFECHAALTA, 
              FITRANNO
             )
      VALUES (pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,
              csl_recTAEST01001_4361.FIIDNEGOCIO, 
              csl_recTAEST01001_4361.FIIDTIENDA, 
              csl_recTAEST01001_4361.FIIDCLIENTE, 
              csl_recTAEST01001_4361.FIIDPERSONA, 
              csl_recTAEST01001_4361.FITIPOCLIENTE, 
              csl_recTAEST01001_4361.FIFISMOR,
              SYSDATE,
              pa_FiTranno
              )

    WHEN MATCHED THEN
      UPDATE
         SET FITIPOCLIENTE = csl_recTAEST01001_4361.FITIPOCLIENTE, 
             FIFISMOR = csl_recTAEST01001_4361.FIFISMOR, 
             FITRANNO = pa_FiTranno
       WHERE FIPAIS = pa_FiPaisId AND
             FICANAL = pa_FiCanalId AND
             FISUCURSAL = pa_FiSucursalId AND 
             FIIDNEGOCIO = csl_recTAEST01001_4361.FIIDNEGOCIO AND 
             FIIDTIENDA = csl_recTAEST01001_4361.FIIDTIENDA AND  
             FIIDCLIENTE = csl_recTAEST01001_4361.FIIDCLIENTE;


EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_4361;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4361" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4361" TO "SCACTUALIZADORVT";
