--------------------------------------------------------
--  DDL for Procedure SP01001_4380
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SP01001_4380" (
   pa_FiPaisId       IN            NUMBER,
   pa_FiCanalId      IN            NUMBER,
   pa_FiSucursalId   IN            NUMBER,
   pa_FiTranno       IN            NUMBER,
   pa_Fitrantipo     IN            NUMBER,
   pa_Ficonsectipo   IN            NUMBER,
   pa_Fdtransfechr   IN            DATE,
   pa_Fctranws       IN            VARCHAR2,
   pa_Fctranusr      IN            VARCHAR2,
   pa_Fitiporeg      IN            NUMBER,
   pa_Query          IN            VARCHAR2,
   pa_OraErr         IN OUT NOCOPY VARCHAR2,
   pa_OraErrMesg     IN OUT NOCOPY VARCHAR2,
   pa_ErrId          IN OUT NOCOPY NUMBER,
   pa_ErrMsg         IN OUT NOCOPY VARCHAR2)
IS
   csl_recTAEST01001_4380   SCVENTASTIENDA.TAEST01001_4380%ROWTYPE := NULL;
   csl_ValorCero            NUMBER (1) := 0;
   csl_FIROLID              NUMBER := 500;
   csl_FCTIPOALERTA         VARCHAR2 (10 BYTE) := 'C';
   csl_pa_GEOALERTA         SCSISGES.TBGEOALERTA := NULL;
   csl_FIUSUARIOID          INTEGER := 111111;
   csl_3           CONSTANT INTEGER := 3;
   csl_1           CONSTANT INTEGER := 1;
   vl_FCALERTADESC          VARCHAR2 (150) := '';
   vl_ESTATUS               VARCHAR2 (15) := '';
   vl_CODIGO                NUMBER (3) := 0;
   vl_MENSAJE               VARCHAR2 (100) := '';
   vl_MENSAJEERROR          VARCHAR2 (200) := '';
   vl_pa_Query2             VARCHAR2 (3000) := '';
   vl_FIUSUARIOID           SCVENTASTIENDA.TAPREPARAME.FCEMPNO%TYPE := NULL;
   vl_GEOALERTA             SCSISGES.TBGEOALERTA;
   vl_PA_FIPAIS             SCSISGES.TAALERTACLIENTE.FIPAIS%TYPE;
   vl_PA_FICANAL            SCSISGES.TAALERTACLIENTE.FICANAL%TYPE;
   vl_PA_FISUCURSAL         SCSISGES.TAALERTACLIENTE.FISUCURSAL%TYPE;
   vl_PA_FIFOLIO            SCSISGES.TAALERTACLIENTE.FIFOLIO%TYPE;
   CSL_SYS         CONSTANT VARCHAR2 (3) := 'SYS';
BEGIN
   pa_ErrMsg := 'TAEST01001_4380';

   SELECT REPLACE (UPPER (pa_Query),
                   'FROM DUAL',
                   ', SYSDATE, SYSDATE, USER FROM DUAL')
     INTO vl_pa_Query2
     FROM DUAL;

   EXECUTE IMMEDIATE vl_pa_Query2 INTO csl_recTAEST01001_4380;

   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TACREDINVES';

   MERGE INTO SCVENTASTIENDA.TACREDINVES INV
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      csl_recTAEST01001_4380.FISOLICITUDID AS SOLICITUDID,
                      csl_recTAEST01001_4380.FIINVESTSTAT AS INVESTSTAT
                 FROM DUAL) TMP
           ON (    TMP.PAIS = INV.FIPAIS
               AND TMP.CANAL = INV.FICANAL
               AND TMP.SUCURSAL = INV.FISUCURSAL
               AND TMP.SOLICITUDID = INV.FISOLICITUDID
               AND TMP.INVESTSTAT = INV.FIINVESTSTAT)
   WHEN NOT MATCHED
   THEN
      INSERT     (FIPAIS,
                  FICANAL,
                  FISUCURSAL,
                  FISOLICITUDID,
                  FIINVESTSTAT,
                  FCEMPNO,
                  FDINVESTFEC,
                  FCOBSERVINV,
                  FITRANNO)
          VALUES (pa_FiPaisId,
                  pa_FiCanalId,
                  pa_FiSucursalId,
                  csl_recTAEST01001_4380.FISOLICITUDID,
                  csl_recTAEST01001_4380.FIINVESTSTAT,
                  TRIM (csl_recTAEST01001_4380.FCEMPNO),
                  csl_recTAEST01001_4380.FDINVESTFEC,
                  csl_recTAEST01001_4380.FCOBSERVINV,
                  pa_FiTranno)
   WHEN MATCHED
   THEN
      UPDATE SET
         FCEMPNO = TRIM (csl_recTAEST01001_4380.FCEMPNO),
         FDINVESTFEC = csl_recTAEST01001_4380.FDINVESTFEC,
         FCOBSERVINV = csl_recTAEST01001_4380.FCOBSERVINV,
         FITRANNO = pa_FiTranno,
         FDMODIFICO = SYSDATE
              WHERE     FIPAIS = pa_FiPaisId
                    AND FICANAL = pa_FiCanalId
                    AND FISUCURSAL = pa_FiSucursalId
                    AND FISOLICITUDID = csl_recTAEST01001_4380.FISOLICITUDID
                    AND FIINVESTSTAT = csl_recTAEST01001_4380.FIINVESTSTAT;


   UPDATE SCVENTASTIENDA.TACREDSOLICITUD
      SET FISTAT = csl_recTAEST01001_4380.FIINVESTSTAT,
          FDFECSTAT = csl_recTAEST01001_4380.FDINVESTFEC
    WHERE     FIPAIS = pa_FiPaisId
          AND FICANAL = pa_FiCanalId
          AND FISUCURSAL = pa_FiSucursalId
          AND FISOLICITUDID = csl_recTAEST01001_4380.FISOLICITUDID;


   pa_ErrMsg := 'INSERT SCVENTASTIENDA.TASOLICITUDES';

   MERGE INTO SCVENTASTIENDA.TASOLICITUDES SOLI
        USING (SELECT pa_FiPaisId AS PAIS,
                      pa_FiCanalId AS CANAL,
                      pa_FiSucursalId AS SUCURSAL,
                      csl_recTAEST01001_4380.FISOLICITUDID AS SOLICITUDID
                 FROM DUAL) TMP
           ON (    TMP.PAIS = SOLI.FIPAIS
               AND TMP.CANAL = SOLI.FICANAL
               AND TMP.SUCURSAL = SOLI.FISUCURSAL
               AND TMP.SOLICITUDID = SOLI.FISOLICITUDID)
   WHEN MATCHED
   THEN
      UPDATE SET
         FCEMPNO =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 3
               THEN
                  TRIM (csl_recTAEST01001_4380.FCEMPNO)
               ELSE
                  FCEMPNO
            END,
         FISOLCOMPLETA =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 3 THEN 1
               ELSE FISOLCOMPLETA
            END,
         FIINE =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 11 THEN 1
               ELSE FIINE
            END,
         FICOMPDOMICILIO =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 13 THEN 1
               ELSE FICOMPDOMICILIO
            END,
         FICOMPINGRESOS =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 12 THEN 1
               ELSE FICOMPINGRESOS
            END,
         FIFIRMACONTRATO =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 10 THEN 1
               ELSE FIFIRMACONTRATO
            END,
         FIVISITAJVC =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 5 THEN 1
               ELSE FIVISITAJVC
            END,
         FIAUTORIZADA =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 6 THEN 1
               ELSE FIAUTORIZADA
            END,
         FILCRSINTAZ =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 253 THEN 1
               ELSE FILCRSINTAZ
            END,
         FILCRCONTAZ =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 254 THEN 1
               ELSE FILCRCONTAZ
            END,
         FILIBERADA =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT IN (253, 254) THEN 1
               ELSE FILIBERADA
            END,
         FCOBSERVACIONES =
            CASE
               WHEN csl_recTAEST01001_4380.FIINVESTSTAT = 9
               THEN
                  csl_recTAEST01001_4380.FCOBSERVINV
               ELSE
                  FCOBSERVACIONES
            END;

   BEGIN
      SELECT REGEXP_REPLACE (INV.FCEMPNO, CSL_SYS)
        INTO vl_FIUSUARIOID
        FROM    SCVENTASTIENDA.TACREDSOLICITUD SOL
             INNER JOIN
                SCVENTASTIENDA.TACREDINVES INV
             ON (    INV.FIPAIS = SOL.FIPAIS
                 AND INV.FICANAL = SOL.FICANAL
                 AND INV.FISUCURSAL = SOL.FISUCURSAL
                 AND INV.FISOLICITUDID = SOL.FISOLICITUDID)
       WHERE     SOL.FIPAIS = pa_FiPaisId
             AND SOL.FICANAL = pa_FiCanalId
             AND SOL.FISUCURSAL = pa_FiSucursalId
             AND SOL.FISOLICITUDID = csl_recTAEST01001_4380.FISOLICITUDID
             AND INV.FIINVESTSTAT = csl_3; /*3 para obtener el empleado que capturo la solicitud*/


      pa_ErrMsg := 'EJECUTA SCSISGES.PAALERTAS0001.SPGUARDARALERTA';

      IF (csl_recTAEST01001_4380.FIINVESTSTAT = 6
          OR csl_recTAEST01001_4380.FIINVESTSTAT = 9)
      THEN
         IF (vl_FIUSUARIOID IS NOT NULL)
         THEN
            IF (csl_recTAEST01001_4380.FIINVESTSTAT = 6)
            THEN
               vl_ESTATUS := 'autorizada';
            ELSIF (csl_recTAEST01001_4380.FIINVESTSTAT = 9)
            THEN
               vl_ESTATUS := 'rechazada';
            END IF;

            vl_FCALERTADESC :=
                  'La solicitud '
               || csl_recTAEST01001_4380.FISOLICITUDID
               || ' ha sido '
               || vl_ESTATUS;

            vl_GEOALERTA := SCSISGES.TBGEOALERTA ();
            vl_GEOALERTA.EXTEND;

            BEGIN
               vl_GEOALERTA (vl_GEOALERTA.COUNT) :=
                  SCSISGES.OBJGEOALERTA (NULL,
                                         NULL,
                                         NULL,
                                         NULL,
                                         NULL,
                                         TO_NUMBER (vl_FIUSUARIOID));
            EXCEPTION
               WHEN OTHERS
               THEN
                  vl_GEOALERTA (vl_GEOALERTA.COUNT) :=
                     SCSISGES.OBJGEOALERTA (NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            111111);
            END;

            BEGIN
               SELECT DISTINCT TCEN.FIPAISCU,
                               TCEN.FICANALCU,
                               TCEN.FISUCURSALCU,
                               TCEN.FIFOLIO
                 INTO vl_PA_FIPAIS,
                      vl_PA_FICANAL,
                      vl_PA_FISUCURSAL,
                      vl_PA_FIFOLIO
                 FROM SCVENTASTIENDA.TASOLICITUDES TS
                      INNER JOIN SCVENTASTIENDA.TACREDCTECTES CRED
                         ON     TS.FIPAIS = CRED.FIPAIS
                            AND TS.FICANAL = CRED.FICANAL
                            AND TS.FISUCURSAL = CRED.FISUCURSAL
                            AND TS.FIIDNEGOCIO = CRED.FIIDNEGOCIO
                            AND TS.FIIDTIENDA = CRED.FIIDTIENDA
                            AND TS.FIIDCLIENTE = CRED.FIIDCLIENTE
                      INNER JOIN SCVENTASTIENDA.TACENCTETIENDA TCEN
                         ON     CRED.FIPAIS = TCEN.FIPAIS
                            AND CRED.FICANAL = TCEN.FICANAL
                            AND CRED.FISUCURSAL = TCEN.FISUCURSAL
                            AND CRED.FINGCIOID = TCEN.FINGCIOID
                            AND CRED.FINOTIENDA = TCEN.FINOTIENDA
                            AND CRED.FICTEID = TCEN.FICTEID
                            AND CRED.FIDIGITOVER = TCEN.FIDIGITOVER
                WHERE TS.FISOLICITUDID = csl_recTAEST01001_4380.FISOLICITUDID
                      AND CRED.FIPAIS >= csl_ValorCero
                      AND CRED.FICANAL >= csl_ValorCero
                      AND CRED.FISUCURSAL >= csl_ValorCero
                      AND CRED.FIIDNEGOCIO >= csl_ValorCero
                      AND CRED.FIIDTIENDA >= csl_ValorCero
                      AND CRED.FIIDCLIENTE >= csl_ValorCero
                      AND TCEN.FISUCURSAL >= csl_ValorCero;

               IF (   vl_PA_FIPAIS IS NULL
                   OR vl_PA_FICANAL IS NULL
                   OR vl_PA_FISUCURSAL IS NULL
                   OR vl_PA_FIFOLIO IS NULL)
               THEN
                  vl_GEOALERTA (vl_GEOALERTA.COUNT) :=
                     SCSISGES.OBJGEOALERTA (NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            111111);
               ELSE
                  SCSISGES.PQSISGESALERTAS.
                   SPALTAALERTAAUTOM (csl_ValorCero,
                                      csl_FIUSUARIOID,
                                      vl_FCALERTADESC,
                                      vl_FCALERTADESC,
                                      SYSDATE,
                                      SYSDATE,
                                      pa_FiCanalId,
                                      csl_1,
                                      vl_FIUSUARIOID,
                                      csl_3,
                                      vl_PA_FIPAIS,
                                      vl_PA_FICANAL,
                                      vl_PA_FISUCURSAL,
                                      vl_PA_FIFOLIO,
                                      csl_recTAEST01001_4380.FISOLICITUDID,
                                      vl_CODIGO,
                                      vl_MENSAJE,
                                      vl_MENSAJEERROR);
               END IF;
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
            END;
         END IF;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;
EXCEPTION
   WHEN OTHERS
   THEN
      pa_ErrId := csl_ValorCero;
      pa_OraErr := SQLCODE;
      pa_OraErrMesg :=
         SQLERRM || ' ERROR:' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ();
      pa_ErrMsg := 'Bloque: ' || pa_ErrMsg || ', ' || pa_Query;
END SP01001_4380;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4380" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4380" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4380" TO "SCSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SP01001_4380" TO "USRINFFENIX";
