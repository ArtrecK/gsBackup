--------------------------------------------------------
--  DDL for Package Body PADETALLETRANERROR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PADETALLETRANERROR" 
AS
   CSL_0              CONSTANT INTEGER := 0;
   CSL_1              CONSTANT INTEGER := 1;
   CLS_SP01001_0217   CONSTANT VARCHAR2 (50) := 'SP01001_0217';
   CLS_SP01001_0208   CONSTANT VARCHAR2 (50) := 'SP01001_0208';
   CLS_SP01001_0210   CONSTANT VARCHAR2 (50) := 'SP01001_0210';
   CLS_SP01001_0220   CONSTANT VARCHAR2 (50) := 'SP01001_0220';
   CLS_SP01001_4633   CONSTANT VARCHAR2 (50) := 'SP01001_4633';
   CLS_SP01001_4719   CONSTANT VARCHAR2 (50) := 'SP01001_4719';
   CLS_SP01001_5320   CONSTANT VARCHAR2 (50) := 'SP01001_5320';
   CLS_SP01001_7422   CONSTANT VARCHAR2 (50) := 'SP01001_7422';
   CLS_SP01001_0010   CONSTANT VARCHAR2 (50) := 'SP01001_0010';
   CLS_SP01001_0012   CONSTANT VARCHAR2 (50) := 'SP01001_0012';
   CLS_SP01001_0070   CONSTANT VARCHAR2 (50) := 'SP01001_0070';
   CLS_SP01001_0075   CONSTANT VARCHAR2 (50) := 'SP01001_0075';
   CLS_SP01001_0050   CONSTANT VARCHAR2 (50) := 'SP01001_0050';
   CLS_SP01001_0060   CONSTANT VARCHAR2 (50) := 'SP01001_0060';
   CLS_SP01001_0120   CONSTANT VARCHAR2 (50) := 'SP01001_0120';
   CLS_SP01001_4361   CONSTANT VARCHAR2 (50) := 'SP01001_4361';
   CLS_SP01001_4368   CONSTANT VARCHAR2 (50) := 'SP01001_4368';
   CLS_SP01001_4380   CONSTANT VARCHAR2 (50) := 'SP01001_4380';
   CLS_SP01001_0110   CONSTANT VARCHAR2 (50) := 'SP01001_0110';
   CLS_SP01001_0100   CONSTANT VARCHAR2 (50) := 'SP01001_0100';
   CLS_SP01001_4462   CONSTANT VARCHAR2 (50) := 'SP01001_4462';
   CLS_SP01001_0115   CONSTANT VARCHAR2 (50) := 'SP01001_0115';
   CLS_SP01001_0185   CONSTANT VARCHAR2 (50) := 'SP01001_0185';
   CLS_SP01001_4381   CONSTANT VARCHAR2 (50) := 'SP01001_4381';
   CSL_OWNER          CONSTANT VARCHAR (100) := 'SCVENTASTIENDA';

   PROCEDURE SPTRANDETERROR (
      PA_COUNTRY             SCACTUALIZADORVT.TATRNCRCB.FIPAISID%TYPE,
      PA_CHANNEL             SCACTUALIZADORVT.TATRNCRCB.FICANAL%TYPE,
      PA_BRANCH              SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE,
      PA_TRANSACTION         SCACTUALIZADORVT.TATRNCRCB.FITRANNO%TYPE,
      PA_TRN_TYPE            SCACTUALIZADORVT.TATRNCRCB.FITRANTIPO%TYPE,
      PA_CON_TYPE            SCACTUALIZADORVT.TATRNCRCB.FICONSECTIPO%TYPE,
      PA_DATE                SCACTUALIZADORVT.TATRNCRCB.FDTRANSFECHR%TYPE,
      PA_WS                  SCACTUALIZADORVT.TATRNCRCB.FCTRANWS%TYPE,
      PA_USER                SCACTUALIZADORVT.TATRNCRCB.FCTRANUSR%TYPE,
      PA_FAULT           OUT INTEGER,
      PA_MESSAGE_FAULT   OUT VARCHAR2)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
      EXC_ERRORVALIDACION   EXCEPTION;
      VL_ACTION             INTEGER;
      VL_SP_NAME            VARCHAR2 (4000);
      VL_QUERY              VARCHAR2 (15000);
      VL_AUX1               SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR%TYPE;
      VL_AUX2               SCACTUALIZADORVT.TAERROR_LOG.FCORA_ERR_MESG%TYPE;
      VL_AUX3               SCACTUALIZADORVT.TAERROR_LOG.FIERR_ID%TYPE;
      VL_AUX4               SCACTUALIZADORVT.TAERROR_LOG.FCERR_MSG%TYPE;
      VL_STRUCTURE          SCACTUALIZADORVT.ARR_ESTRUCTURA_TAEST;
      VL_LENGTH             SCACTUALIZADORVT.TACATESTRUCTURA.FIEST_LENGTH%TYPE;
   BEGIN
      FOR DETAIL
         IN (  SELECT FIPAISID,
                      FICANAL,
                      FISUCURSAL,
                      FITRANNO,
                      FICONSDETA,
                      FITIPOREG,
                      FCDATODETA
                 FROM SCACTUALIZADORVT.TATRNCRDTE
                WHERE     FIPAISID = PA_COUNTRY
                      AND FICANAL = PA_CHANNEL
                      AND FISUCURSAL = PA_BRANCH
                      AND FITRANNO = PA_TRANSACTION
             ORDER BY FICONSDETA)
      LOOP
         PA_MESSAGE_FAULT :=
               'PAIS='
            || PA_COUNTRY
            || ', '
            || 'CANAL='
            || PA_CHANNEL
            || ', '
            || 'SUCURSAL='
            || PA_BRANCH
            || ', '
            || 'TRANSACCION='
            || PA_TRANSACTION
            || ', '
            || 'DETALLE='
            || DETAIL.FICONSDETA;

         VL_ACTION := NULL;
         VL_SP_NAME := NULL;
         SCACTUALIZADORVT.PAACTUALIZA0002.
          SPGETRECORDDETAIL (DETAIL.FIPAISID,
                             DETAIL.FICANAL,
                             DETAIL.FITIPOREG,
                             VL_ACTION,
                             VL_SP_NAME);

         IF VL_ACTION = 1
         THEN
            SCACTUALIZADORVT.PAACTUALIZA0002.
             SPGETSTRUCTUREDETAIL (VL_SP_NAME, VL_STRUCTURE, VL_LENGTH);

            IF NVL (LENGTH (RTRIM (DETAIL.FCDATODETA)), CSL_0) > VL_LENGTH
            THEN
               PA_MESSAGE_FAULT :=
                  PA_MESSAGE_FAULT
                  || ' - La longitud del campo FCDATODETA es mayor a la definida en el cat�logo SCACTUALIZADORVT.TACATESTRUCTURA';
               RAISE EXC_ERRORVALIDACION;
            END IF;

            SCACTUALIZADORVT.PAACTUALIZADOR.SPOBTENERSQL (DETAIL.FCDATODETA,
                                                          VL_STRUCTURE,
                                                          CSL_OWNER,
                                                          VL_QUERY,
                                                          VL_AUX1,
                                                          VL_AUX2,
                                                          VL_AUX3,
                                                          VL_AUX4);

            IF VL_AUX3 IS NOT NULL
            THEN
               PA_MESSAGE_FAULT :=
                  PA_MESSAGE_FAULT
                  || ' - Error al generar query de la estructura';
               RAISE EXC_ERRORVALIDACION;
            END IF;

            CASE TRIM (UPPER (VL_SP_NAME))
               WHEN CLS_SP01001_0217
               THEN
                  SCVENTASTIENDA.SP01001_0217 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0208
               THEN
                  SCVENTASTIENDA.SP01001_0208 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0210
               THEN
                  SCVENTASTIENDA.SP01001_0210 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0220
               THEN
                  SCVENTASTIENDA.SP01001_0220 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4633
               THEN
                  SCVENTASTIENDA.SP01001_4633 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4719
               THEN
                  SCVENTASTIENDA.SP01001_4719 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_5320
               THEN
                  SCVENTASTIENDA.SP01001_5320 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_7422
               THEN
                  SCVENTASTIENDA.SP01001_7422 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0010
               THEN
                  SCVENTASTIENDA.SP01001_0010 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0012
               THEN
                  SCVENTASTIENDA.SP01001_0012 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0070
               THEN
                  SCVENTASTIENDA.SP01001_0070 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0075
               THEN
                  SCVENTASTIENDA.SP01001_0075 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0050
               THEN
                  SCVENTASTIENDA.SP01001_0050 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0060
               THEN
                  SCVENTASTIENDA.SP01001_0060 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0120
               THEN
                  SCVENTASTIENDA.SP01001_0120 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4361
               THEN
                  SCVENTASTIENDA.SP01001_4361 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4368
               THEN
                  SCVENTASTIENDA.SP01001_4368 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4380
               THEN
                  SCVENTASTIENDA.SP01001_4380 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0110
               THEN
                  SCVENTASTIENDA.SP01001_0110 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0100
               THEN
                  SCVENTASTIENDA.SP01001_0100 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4462
               THEN
                  SCVENTASTIENDA.SP01001_4462 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0115
               THEN
                  SCVENTASTIENDA.SP01001_0115 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_0185
               THEN
                  SCVENTASTIENDA.SP01001_0185 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               WHEN CLS_SP01001_4381
               THEN
                  SCVENTASTIENDA.SP01001_4381 (PA_COUNTRY,
                                               PA_CHANNEL,
                                               PA_BRANCH,
                                               PA_TRANSACTION,
                                               PA_TRN_TYPE,
                                               PA_CON_TYPE,
                                               PA_DATE,
                                               PA_WS,
                                               PA_USER,
                                               DETAIL.FITIPOREG,
                                               VL_QUERY,
                                               VL_AUX1,
                                               VL_AUX2,
                                               VL_AUX3,
                                               VL_AUX4);
               ELSE
                  NULL;
            END CASE;

            IF VL_AUX3 IS NOT NULL
            THEN
               PA_MESSAGE_FAULT := PA_MESSAGE_FAULT || ' - ' || VL_AUX2;
               RAISE EXC_ERRORVALIDACION;
            END IF;
         END IF;
      END LOOP;
   EXCEPTION
      WHEN EXC_ERRORVALIDACION
      THEN
         ROLLBACK;
         PA_FAULT := CSL_1;
      WHEN OTHERS
      THEN
         ROLLBACK;
         PA_FAULT := CSL_1;
         PA_MESSAGE_FAULT :=
               PA_MESSAGE_FAULT
            || ' - '
            || SQLCODE
            || ' '
            || SQLERRM
            || ' '
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   END SPTRANDETERROR;
END PADETALLETRANERROR;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADETALLETRANERROR" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADETALLETRANERROR" TO "USRINFFENIX";
