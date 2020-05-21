--------------------------------------------------------
--  DDL for Package Body PAACTUALIZAERRORES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAACTUALIZAERRORES" 
AS
   CSL_0   CONSTANT INTEGER := 0;
   CSL_1   CONSTANT INTEGER := 1;

   PROCEDURE SPACTUALIZAENERROR (PA_TOTBLOCKS   IN     INTEGER,
                                 PA_ACTBLOCK    IN     INTEGER,
                                 PA_NUM_TRAN    IN     INTEGER,
                                 PA_CODE           OUT INTEGER,
                                 PA_MESSAGE        OUT VARCHAR2,
                                 PA_DETAIL         OUT VARCHAR2)
   AS
      PA_SIZE   INTEGER;
      PA_MIN    INTEGER;
      PA_MAX    INTEGER;
   BEGIN
      SELECT CEIL (COUNT (CSL_1) / PA_TOTBLOCKS)
        INTO PA_SIZE
        FROM SCACTUALIZADORVT.TACTRLSUC
       WHERE FIPAISID = CSL_1 AND FICANAL > CSL_0 AND FISUCURSAL > CSL_0;

      IF PA_ACTBLOCK = CSL_1
      THEN
         PA_MIN := CSL_1;
         PA_MAX := PA_SIZE;
      ELSE
         PA_MIN := ( (PA_ACTBLOCK - 1) * PA_SIZE) + 1;
         PA_MAX := (PA_MIN + PA_SIZE) - 1;
      END IF;

      FOR BRANCH IN (SELECT COUNTRY, CHANNEL, BRANCH_NUMBER
                       FROM (SELECT ROWNUM ROW_NUM,
                                    FIPAISID COUNTRY,
                                    FICANAL CHANNEL,
                                    FISUCURSAL BRANCH_NUMBER
                               FROM SCACTUALIZADORVT.TACTRLSUC
                              WHERE     FIPAISID = CSL_1
                                    AND FICANAL > CSL_0
                                    AND FISUCURSAL > CSL_0)
                      WHERE ROW_NUM BETWEEN PA_MIN AND PA_MAX)
      LOOP
         SPACTERRORSUCURSAL (PA_NUM_TRAN,
                             BRANCH.COUNTRY,
                             BRANCH.CHANNEL,
                             BRANCH.BRANCH_NUMBER);
      END LOOP;

      PA_CODE := CSL_0;
      PA_MESSAGE := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         PA_CODE := SQLCODE;
         PA_MESSAGE := SQLERRM;
         PA_DETAIL := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   END SPACTUALIZAENERROR;

   PROCEDURE SPACTERRORSUCURSAL (PA_NUM_TRAN   IN INTEGER,
                                 PA_COUNTRY    IN INTEGER,
                                 PA_CHANNEL    IN INTEGER,
                                 PA_BRANCH     IN INTEGER)
   AS
      VL_DETAIL_FAULT    INTEGER;
      VL_MESSAGE_FAULT   VARCHAR2 (2000);
   BEGIN
      FOR CABECERO IN (SELECT ROW_ID,
                              FIPAISID,
                              FICANAL,
                              FISUCURSAL,
                              FITRANNO,
                              FITRANNOREG,
                              FITRANTIPO,
                              FICONSECTIPO,
                              FDTRANSFECHR,
                              FCTRANWS,
                              FCTRANUSR
                         FROM (  SELECT ORA_ERR_ROWID ROW_ID,
                                        FIPAISID,
                                        FICANAL,
                                        FISUCURSAL,
                                        FITRANNO,
                                        FITRANNOREG,
                                        FITRANTIPO,
                                        FICONSECTIPO,
                                        FDTRANSFECHR,
                                        FCTRANWS,
                                        FCTRANUSR
                                   FROM SCACTUALIZADORVT.TATRNCRCBE
                                  WHERE     FIPAISID = PA_COUNTRY
                                        AND FICANAL = PA_CHANNEL
                                        AND FISUCURSAL = PA_BRANCH
                                        AND FITRANNO > CSL_0
                               ORDER BY FITRANNO)
                        WHERE ROWNUM <= PA_NUM_TRAN)
      LOOP
         VL_DETAIL_FAULT := NULL;
         VL_MESSAGE_FAULT := NULL;

         IF CABECERO.FITRANNOREG > CSL_0
         THEN
            SCACTUALIZADORVT.PADETALLETRANERROR.
             SPTRANDETERROR (CABECERO.FIPAISID,
                             CABECERO.FICANAL,
                             CABECERO.FISUCURSAL,
                             CABECERO.FITRANNO,
                             CABECERO.FITRANTIPO,
                             CABECERO.FICONSECTIPO,
                             CABECERO.FDTRANSFECHR,
                             CABECERO.FCTRANWS,
                             CABECERO.FCTRANUSR,
                             VL_DETAIL_FAULT,
                             VL_MESSAGE_FAULT);
         END IF;

         IF VL_DETAIL_FAULT IS NULL
         THEN
            SCACTUALIZADORVT.PAACTUALIZAERRORES.
             SPERRORSUCESS (CABECERO.FIPAISID,
                            CABECERO.FICANAL,
                            CABECERO.FISUCURSAL,
                            CABECERO.FITRANNO,
                            CABECERO.ROW_ID);
         ELSE
            SCACTUALIZADORVT.PAACTUALIZAERRORES.
             SPDESCRIPERROR (VL_MESSAGE_FAULT, CABECERO.ROW_ID);
         END IF;
      END LOOP;
   END SPACTERRORSUCURSAL;

   PROCEDURE SPERRORSUCESS (PA_COUNTRY       IN INTEGER,
                            PA_CHANNEL       IN INTEGER,
                            PA_BRANCH        IN INTEGER,
                            PA_TRANSACTION   IN INTEGER,
                            ROW_ID           IN ROWID)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      INSERT INTO SCACTUALIZADORVT.TATRNCRCBH (FIPAISID,
                                               FICANAL,
                                               FISUCURSAL,
                                               FITRANNO,
                                               FITRANTIPO,
                                               FICONSECTIPO,
                                               FDTRANSFECHR,
                                               FCTRANWS,
                                               FCTRANUSR,
                                               FITRANNOREG,
                                               FITRANSMIT)
         SELECT FIPAISID,
                FICANAL,
                FISUCURSAL,
                FITRANNO,
                FITRANTIPO,
                FICONSECTIPO,
                FDTRANSFECHR,
                FCTRANWS,
                FCTRANUSR,
                FITRANNOREG,
                FITRANSMIT
           FROM SCACTUALIZADORVT.TATRNCRCBE
          WHERE     FIPAISID = PA_COUNTRY
                AND FICANAL = PA_CHANNEL
                AND FISUCURSAL = PA_BRANCH
                AND FITRANNO = PA_TRANSACTION;

      INSERT INTO SCACTUALIZADORVT.TATRNCRDTH (FIPAISID,
                                               FICANAL,
                                               FISUCURSAL,
                                               FITRANNO,
                                               FICONSDETA,
                                               FITIPOREG,
                                               FCDATODETA,
                                               FDFECHAFINPROCESO)
         SELECT FIPAISID,
                FICANAL,
                FISUCURSAL,
                FITRANNO,
                FICONSDETA,
                FITIPOREG,
                FCDATODETA,
                SYSDATE
           FROM SCACTUALIZADORVT.TATRNCRDTE
          WHERE     FIPAISID = PA_COUNTRY
                AND FICANAL = PA_CHANNEL
                AND FISUCURSAL = PA_BRANCH
                AND FITRANNO = PA_TRANSACTION;

      DELETE FROM SCACTUALIZADORVT.TATRNCRDTE
            WHERE     FIPAISID = PA_COUNTRY
                  AND FICANAL = PA_CHANNEL
                  AND FISUCURSAL = PA_BRANCH
                  AND FITRANNO = PA_TRANSACTION;

      DELETE FROM SCACTUALIZADORVT.TATRNCRCBE
            WHERE     FIPAISID = PA_COUNTRY
                  AND FICANAL = PA_CHANNEL
                  AND FISUCURSAL = PA_BRANCH
                  AND FITRANNO = PA_TRANSACTION;

      DELETE FROM SCACTUALIZADORVT.TAERROR_LOG
            WHERE     ORA_ERR_ROWID = ROW_ID
                  AND FIERR_CONS = FIERR_CONS + CSL_0
                  AND FIERR_CONS > CSL_0;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
   END SPERRORSUCESS;

   PROCEDURE SPDESCRIPERROR (PA_MESSAGE_FAULT IN VARCHAR2, ROW_ID IN ROWID)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      UPDATE SCACTUALIZADORVT.TAERROR_LOG
         SET FCORA_ERR_MESG = PA_MESSAGE_FAULT
       WHERE     ORA_ERR_ROWID = ROW_ID
             AND FIERR_CONS = FIERR_CONS + CSL_0
             AND FIERR_CONS > CSL_0;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
   END SPDESCRIPERROR;
END PAACTUALIZAERRORES;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZAERRORES" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZAERRORES" TO "USRINFFENIX";
