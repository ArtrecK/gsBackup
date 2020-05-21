--------------------------------------------------------
--  DDL for Procedure SP01001_0060
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_0060" 
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
Descripcion: Recibe el registro 60 en texto separados por comas, 
             inserta en la tabla TADETPREPARAM
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

   csl_recTAEST01001_0060    SCVENTASTIENDA.TAEST01001_0060%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   csl_excParentKey          NUMBER(5) := -2291;
   vl_Update              NUMBER(1) := 1;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN
   pa_ErrMsg := 'TAEST01001_0060';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_0060;

   BEGIN
      pa_ErrMsg := 'INSERT SCVENTASTIENDA.TADETPREPARAM';
      MERGE INTO SCVENTASTIENDA.TADETPREPARAM DATOS
         USING (SELECT pa_FiPaisId AS PAIS,
                       pa_FiCanalId AS CANAL,
                       pa_FiSucursalId AS SUCURSAL,     
                       csl_recTAEST01001_0060.FCFOLIOPARAM AS FOLIOPARAM,
                       csl_recTAEST01001_0060.FIPRODID AS PRODID
                  FROM DUAL) VALORES
            ON (DATOS.FIPAIS = VALORES.PAIS
                AND DATOS.FICANAL = VALORES.CANAL
                AND DATOS.FISUCURSAL = VALORES.SUCURSAL
                AND DATOS.FIFOLIOPARAM = VALORES.FOLIOPARAM
                AND DATOS.FIPRODID = VALORES.PRODID)
      WHEN NOT MATCHED THEN
         INSERT ( 
                 FIPAIS, 
                 FICANAL, 
                 FISUCURSAL, 
                 FIFOLIOPARAM, 
                 FIPRODID, 
                 FNPRODPRECIOD, 
                 FICANT, 
                 FNDESCTO, 
                 FNDESCTOESP, 
                 FNSOBREPRECIO, 
                 FNPORCIVA, 
                 FNDESCTOMKT, 
                 FNCOSTOPDCTO, 
                 FISTATDP, 
                 FNINTERESES, 
                 FNENGANCHE, 
                 FICVEPROM, 
                 FNCOMISIONV, 
                 FNCOMISIONG
                )
         VALUES ( 
                 pa_FiPaisId,
                 pa_FiCanalId,
                 pa_FiSucursalId,
                 csl_recTAEST01001_0060.FCFOLIOPARAM, 
                 csl_recTAEST01001_0060.FIPRODID, 
                 csl_recTAEST01001_0060.FNPRODPRECIOD, 
                 csl_recTAEST01001_0060.FICANT, 
                 csl_recTAEST01001_0060.FNDESCTO, 
                 csl_recTAEST01001_0060.FNDESCTOESP, 
                 csl_recTAEST01001_0060.FNSOBREPRECIO, 
                 csl_recTAEST01001_0060.FIPORCIVA, 
                 csl_recTAEST01001_0060.FNDESCTOMKT, 
                 csl_recTAEST01001_0060.FNCOSTOPDCTO, 
                 csl_recTAEST01001_0060.FISTATDP, 
                 csl_recTAEST01001_0060.FNINTERESES, 
                 csl_recTAEST01001_0060.FNENGANCHE, 
                 csl_recTAEST01001_0060.FICVEPROM, 
                 csl_recTAEST01001_0060.FNCOMISIONV, 
                 csl_recTAEST01001_0060.FNCOMISIONG
                );
         vl_Update := 0;

   EXCEPTION 
   WHEN OTHERS THEN
      IF SQLCODE = csl_excParentKey THEN
         --se valida error: ORA-02291: integrity constraint (C3FACTURAMEX.FK_TASURTIMIENTOMOTOS_01) violated - parent key not found
          NULL;
      ELSE
         --en caso de cualquier otro error
         pa_ErrId := 0;
         pa_OraErr := SQLCODE;
         pa_OraErrMesg := SQLERRM;
         pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
      END IF;
   END; 


   IF(vl_Update = 1)
   THEN
      pa_ErrMsg := 'UPDATE SCVENTASTIENDA.TADETPREPARAM';
      IF(pa_Fitrantipo = 2012 OR pa_Fitrantipo = 2010)
      THEN
         UPDATE SCVENTASTIENDA.TADETPREPARAM
            SET FNPRODPRECIOD = csl_recTAEST01001_0060.FNPRODPRECIOD, 
                FNDESCTO = csl_recTAEST01001_0060.FNDESCTO, 
                FNDESCTOESP = csl_recTAEST01001_0060.FNDESCTOESP, 
                FNSOBREPRECIO = csl_recTAEST01001_0060.FNSOBREPRECIO, 
                FNDESCTOMKT = csl_recTAEST01001_0060.FNDESCTOMKT
          WHERE FIPAIS = pa_FiPaisId
            AND FICANAL = pa_FiCanalId
            AND FISUCURSAL = pa_FiSucursalId
            AND FIFOLIOPARAM = csl_recTAEST01001_0060.FCFOLIOPARAM
            AND FIPRODID = csl_recTAEST01001_0060.FIPRODID;

      ELSIF(pa_Fitrantipo = 2100)
      THEN
         UPDATE SCVENTASTIENDA.TADETPREPARAM
            SET FNPRODPRECIOD = csl_recTAEST01001_0060.FNPRODPRECIOD, 
                FICANT = csl_recTAEST01001_0060.FICANT, 
                FNDESCTO = csl_recTAEST01001_0060.FNDESCTO, 
                FNDESCTOESP = csl_recTAEST01001_0060.FNDESCTOESP, 
                FNSOBREPRECIO = csl_recTAEST01001_0060.FNSOBREPRECIO, 
                FNPORCIVA = csl_recTAEST01001_0060.FIPORCIVA, 
                FNDESCTOMKT = csl_recTAEST01001_0060.FNDESCTOMKT, 
                FNCOSTOPDCTO = csl_recTAEST01001_0060.FNCOSTOPDCTO, 
                FISTATDP = csl_recTAEST01001_0060.FISTATDP, 
                FNINTERESES = csl_recTAEST01001_0060.FNINTERESES, 
                FNENGANCHE = csl_recTAEST01001_0060.FNENGANCHE, 
                FICVEPROM = csl_recTAEST01001_0060.FICVEPROM, 
                FNCOMISIONV = csl_recTAEST01001_0060.FNCOMISIONV, 
                FNCOMISIONG = csl_recTAEST01001_0060.FNCOMISIONG
          WHERE FIPAIS = pa_FiPaisId
            AND FICANAL = pa_FiCanalId
            AND FISUCURSAL = pa_FiSucursalId
            AND FIFOLIOPARAM = csl_recTAEST01001_0060.FCFOLIOPARAM
            AND FIPRODID = csl_recTAEST01001_0060.FIPRODID;
      END IF;
   END IF;



EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_0060;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0060" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_0060" TO "SCACTUALIZADORVT";
