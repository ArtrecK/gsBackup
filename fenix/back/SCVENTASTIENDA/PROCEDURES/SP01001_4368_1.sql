--------------------------------------------------------
--  DDL for Procedure SP01001_4368
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_4368" 
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
Descripcion: Recibe el registro 4368 en texto separados por comas, 
             inserta en la tabla TACREDSOLICITUD
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

   csl_recTAEST01001_4368    SCVENTASTIENDA.TAEST01001_4368%ROWTYPE := NULL;
   csl_ValorCero          NUMBER(1) := 0;
   vl_Solicitudes         NUMBER(3) := 0;
   vl_Estatus             SCVENTASTIENDA.TACREDSOLICITUD.FISTAT%TYPE := 0;
   vl_pa_Query2           VARCHAR2(3000) := '';

BEGIN

   pa_ErrMsg := 'TAEST01001_4368';

   SELECT REPLACE(UPPER(pa_Query),'FROM DUAL',', SYSDATE, SYSDATE, USER FROM DUAL') INTO vl_pa_Query2 from dual;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_4368;


   BEGIN
      SELECT FISTAT
        INTO vl_Estatus
        FROM SCVENTASTIENDA.TACREDSOLICITUD
       WHERE FIPAIS = pa_FiPaisId
         AND FICANAL = pa_FiCanalId
         AND FISUCURSAL = pa_FiSucursalId
         AND FISOLICITUDID = csl_recTAEST01001_4368.FISOLICITUDID;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      vl_Estatus := 0; 
   END;

   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TACREDSOLICITUD';

   MERGE INTO SCVENTASTIENDA.TACREDSOLICITUD SOL
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      csl_recTAEST01001_4368.FISOLICITUDID AS SOLICITUDID
                 FROM DUAL) TMP
           ON (TMP.PAIS = SOL.FIPAIS AND
               TMP.CANAL = SOL.FICANAL AND
               TMP.SUCURSAL = SOL.FISUCURSAL AND
               TMP.SOLICITUDID = SOL.FISOLICITUDID 
              )
   WHEN NOT MATCHED THEN   
      INSERT (
              FIPAIS, 
              FICANAL, 
              FISUCURSAL, 
              FIIDNEGOCIO, 
              FIIDTIENDA, 
              FIIDCLIENTE, 
              FISOLICITUDID, 
              FITIPOSOLICITUD, 
              FIFOLIOPARAM, 
              FDFECVISITA, 
              FCINFORMANTE, 
              FISTAT, 
              FISUBSTAT, 
              FDFECSTAT, 
              FIRECHAZOID, 
              FCEJECUTIVO, 
              FDFECSOLICITUD, 
              FITRANNO, 
              FIACEPTAPP, 
              FITIPOAUTORIZACION, 
              FNCAPACIDADPAGO, 
              FIPLAZO
             )
      VALUES (pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,
              csl_recTAEST01001_4368.FIIDNEGOCIO,
              csl_recTAEST01001_4368.FIIDTIENDA,
              csl_recTAEST01001_4368.FIIDCLIENTE,
              csl_recTAEST01001_4368.FISOLICITUDID,
              csl_recTAEST01001_4368.FITIPOSOLICITUD,
              csl_recTAEST01001_4368.FIFOLIOPARAM,
              csl_recTAEST01001_4368.FDFECVISITA,
              csl_recTAEST01001_4368.FCINFORMANTE,
              csl_recTAEST01001_4368.FISTAT,
              csl_recTAEST01001_4368.FISUBSTAT,
              csl_recTAEST01001_4368.FDFECSTAT,
              csl_recTAEST01001_4368.FIRECHAZOID,
              TRIM(csl_recTAEST01001_4368.FCEJECUTIVO),
              csl_recTAEST01001_4368.FDFECSOLICITUD,
              pa_FiTranno,
              csl_recTAEST01001_4368.FIACEPTAPP,
              csl_recTAEST01001_4368.FITIPOAUTORIZACION,
              csl_recTAEST01001_4368.FNCAPACIDADPAGO,
              csl_recTAEST01001_4368.FIPLAZO
              )

   WHEN MATCHED THEN      
      UPDATE 
         SET FDFECVISITA = csl_recTAEST01001_4368.FDFECVISITA, 
             FCINFORMANTE = csl_recTAEST01001_4368.FCINFORMANTE, 
             FDFECSTAT = csl_recTAEST01001_4368.FDFECSTAT, 
             FIRECHAZOID = csl_recTAEST01001_4368.FIRECHAZOID, 
             FCEJECUTIVO = TRIM(csl_recTAEST01001_4368.FCEJECUTIVO), 
             FIACEPTAPP = csl_recTAEST01001_4368.FIACEPTAPP, 
             FITIPOAUTORIZACION = csl_recTAEST01001_4368.FITIPOAUTORIZACION, 
             FNCAPACIDADPAGO = csl_recTAEST01001_4368.FNCAPACIDADPAGO, 
             FIPLAZO = csl_recTAEST01001_4368.FIPLAZO
       WHERE FIPAIS = pa_FiPaisId AND 
             FICANAL = pa_FiCanalId AND 
             FISUCURSAL = pa_FiSucursalId AND 
             FISOLICITUDID = csl_recTAEST01001_4368.FISOLICITUDID;


   IF (vl_Estatus =  19 AND csl_recTAEST01001_4368.FISTAT = 9)
   THEN
      UPDATE SCVENTASTIENDA.TACREDSOLICITUD
         SET FISTAT = csl_recTAEST01001_4368.FISTAT 
       WHERE FIPAIS = pa_FiPaisId
         AND FICANAL = pa_FiCanalId
         AND FISUCURSAL = pa_FiSucursalId
         AND FISOLICITUDID = csl_recTAEST01001_4368.FISOLICITUDID;
   END IF;


   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TASOLICITUDES';
   MERGE INTO SCVENTASTIENDA.TASOLICITUDES SOLI
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      csl_recTAEST01001_4368.FISOLICITUDID AS SOLICITUDID
                 FROM DUAL) TMP
           ON (TMP.PAIS = SOLI.FIPAIS AND
               TMP.CANAL = SOLI.FICANAL AND
               TMP.SUCURSAL = SOLI.FISUCURSAL AND
               TMP.SOLICITUDID = SOLI.FISOLICITUDID 
              )
   WHEN NOT MATCHED THEN   
      INSERT (
              FIPAIS, 
              FICANAL, 
              FISUCURSAL, 
              FIIDNEGOCIO, 
              FIIDTIENDA, 
              FIIDCLIENTE, 
              FISOLICITUDID, 
              FITIPOSOLICITUD, 
              FIFOLIOPARAM,
              FCEMPNO,
              FISUBSTAT,
              FNMONTO
             )
      VALUES (
              pa_FiPaisId,
              pa_FiCanalId,
              pa_FiSucursalId,
              csl_recTAEST01001_4368.FIIDNEGOCIO,
              csl_recTAEST01001_4368.FIIDTIENDA,
              csl_recTAEST01001_4368.FIIDCLIENTE,
              csl_recTAEST01001_4368.FISOLICITUDID,
              csl_recTAEST01001_4368.FITIPOSOLICITUD,
              csl_recTAEST01001_4368.FIFOLIOPARAM,
              '',
              csl_recTAEST01001_4368.FISUBSTAT,
              (csl_recTAEST01001_4368.FNCAPACIDADPAGO * 78)
             );

EXCEPTION
   WHEN OTHERS THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg := SQLERRM;
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_4368;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4368" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4368" TO "SCACTUALIZADORVT";
