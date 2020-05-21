--------------------------------------------------------
--  DDL for Package Body PAACTUALIZA0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAACTUALIZA0001" 
AS
    CSL_0   CONSTANT INTEGER := 0;
    CSL_1   CONSTANT INTEGER := 1;

    PROCEDURE SPUPDBRANCHCAT (PA_CODE      OUT INTEGER,
                              PA_MESSAGE   OUT VARCHAR2,
                              PA_DETAIL    OUT VARCHAR2)
    AS
    BEGIN
        MERGE INTO SCACTUALIZADORVT.TACTRLSUC CAT
             USING (SELECT DISTINCT
                           FIPAISID   COUNTRY,
                           FICANAL    CHANNEL,
                           FISUCURSAL BRANCH_NUMBER
                      FROM SCACTUALIZADORVT.TATRNCRCB
                     WHERE     FIPAISID > CSL_0
                           AND FICANAL > CSL_0
                           AND FISUCURSAL > CSL_0
                           AND FITRANNO > CSL_0) TRN
                ON (    CAT.FIPAISID = TRN.COUNTRY
                    AND CAT.FICANAL = TRN.CHANNEL
                    AND CAT.FISUCURSAL = TRN.BRANCH_NUMBER)
        WHEN NOT MATCHED
        THEN
            INSERT     (CAT.FIPAISID,
                        CAT.FICANAL,
                        CAT.FISUCURSAL,
                        CAT.FIULTTRANS,
                        CAT.FDULTTRANS,
                        CAT.FDULTACTCEN,
                        CAT.FITRANNO,
                        CAT.FISTSCBAN,
                        CAT.FDFECCBAN)
                VALUES (TRN.COUNTRY,
                        TRN.CHANNEL,
                        TRN.BRANCH_NUMBER,
                        CSL_0,
                        SYSDATE,
                        SYSDATE,
                        CSL_0,
                        CSL_0,
                        SYSDATE);

        COMMIT;
        PA_CODE := CSL_0;
        PA_MESSAGE := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            PA_CODE := SQLCODE;
            PA_MESSAGE := SQLERRM;
            PA_DETAIL := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    END;

    PROCEDURE SPRUNUPDATERV2 (PA_TOTBLOCKS   IN     INTEGER,
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
            PA_MIN := ((PA_ACTBLOCK - 1) * PA_SIZE) + 1;
            PA_MAX := (PA_MIN + PA_SIZE) - 1;
        END IF;

        FOR BRANCH
            IN (SELECT COUNTRY, CHANNEL, BRANCH_NUMBER
                  FROM (SELECT ROWNUM     ROW_NUM,
                               FIPAISID   COUNTRY,
                               FICANAL    CHANNEL,
                               FISUCURSAL BRANCH_NUMBER
                          FROM SCACTUALIZADORVT.TACTRLSUC
                         WHERE     FIPAISID = CSL_1
                               AND FICANAL > CSL_0
                               AND FISUCURSAL > CSL_0)
                 WHERE ROW_NUM BETWEEN PA_MIN AND PA_MAX)
        LOOP
            SCACTUALIZADORVT.PAACTUALIZA0001.SPPROCESSBRANCH (
                PA_NUM_TRAN,
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
    END;

    PROCEDURE SPRUNUPDATER (PA_NUM_TRAN   IN     INTEGER,
                            PA_CODE          OUT INTEGER,
                            PA_MESSAGE       OUT VARCHAR2,
                            PA_DETAIL        OUT VARCHAR2)
    AS
    BEGIN
        FOR BRANCH
            IN (  SELECT DISTINCT
                         FIPAISID COUNTRY,
                         FICANAL  CHANNEL,
                         FISUCURSAL BRANCH_NUMBER
                    FROM SCACTUALIZADORVT.TATRNCRCB
                   WHERE     FIPAISID > CSL_0
                         AND FICANAL > CSL_0
                         AND FISUCURSAL > CSL_0
                         AND FITRANNO > CSL_0
                ORDER BY FIPAISID, FICANAL, FISUCURSAL)
        LOOP
            SCACTUALIZADORVT.PAACTUALIZA0001.SPPROCESSBRANCH (
                PA_NUM_TRAN,
                BRANCH.COUNTRY,
                BRANCH.CHANNEL,
                BRANCH.BRANCH_NUMBER);
        END LOOP;

        PA_CODE := CSL_0;
        PA_MESSAGE := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            PA_CODE := CSL_1;
            PA_MESSAGE := 'Ocurrio un error al procesar las transacciones';
            PA_DETAIL :=
                   SQLCODE
                || ' '
                || SQLERRM
                || ' '
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    END;

    PROCEDURE SPPROCESSBRANCH (PA_NUM_TRAN   IN INTEGER,
                               PA_COUNTRY    IN INTEGER,
                               PA_CHANNEL    IN INTEGER,
                               PA_BRANCH     IN INTEGER)
    AS
        VL_DETAIL_FAULT    INTEGER;
        VL_MESSAGE_FAULT   VARCHAR2 (2000);
    BEGIN
        FOR CABECERO
            IN (SELECT ROW_ID,
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
                  FROM (  SELECT ROWID ROW_ID,
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
                            FROM SCACTUALIZADORVT.TATRNCRCB
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
                SCACTUALIZADORVT.PAACTUALIZA0002.SPPROCESSDETAIL (
                    CABECERO.FIPAISID,
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
                SCACTUALIZADORVT.PAACTUALIZA0001.SPMOVEOK (
                    CABECERO.FIPAISID,
                    CABECERO.FICANAL,
                    CABECERO.FISUCURSAL,
                    CABECERO.FITRANNO);
            ELSE
                SCACTUALIZADORVT.PAACTUALIZA0001.SPSAVEFAULT (
                    VL_MESSAGE_FAULT,
                    CABECERO.ROW_ID);
                SCACTUALIZADORVT.PAACTUALIZA0001.SPMOVEERR (
                    CABECERO.FIPAISID,
                    CABECERO.FICANAL,
                    CABECERO.FISUCURSAL,
                    CABECERO.FITRANNO);
            END IF;
        END LOOP;
    END;

    PROCEDURE SPMOVEOK (PA_COUNTRY       IN INTEGER,
                        PA_CHANNEL       IN INTEGER,
                        PA_BRANCH        IN INTEGER,
                        PA_TRANSACTION   IN INTEGER)
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
              FROM SCACTUALIZADORVT.TATRNCRCB
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
              FROM SCACTUALIZADORVT.TATRNCRDT
             WHERE     FIPAISID = PA_COUNTRY
                   AND FICANAL = PA_CHANNEL
                   AND FISUCURSAL = PA_BRANCH
                   AND FITRANNO = PA_TRANSACTION;

        DELETE FROM SCACTUALIZADORVT.TATRNCRDT
              WHERE     FIPAISID = PA_COUNTRY
                    AND FICANAL = PA_CHANNEL
                    AND FISUCURSAL = PA_BRANCH
                    AND FITRANNO = PA_TRANSACTION;

        DELETE FROM SCACTUALIZADORVT.TATRNCRCB
              WHERE     FIPAISID = PA_COUNTRY
                    AND FICANAL = PA_CHANNEL
                    AND FISUCURSAL = PA_BRANCH
                    AND FITRANNO = PA_TRANSACTION;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
    END;

    PROCEDURE SPMOVEERR (PA_COUNTRY       IN INTEGER,
                         PA_CHANNEL       IN INTEGER,
                         PA_BRANCH        IN INTEGER,
                         PA_TRANSACTION   IN INTEGER)
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO SCACTUALIZADORVT.TATRNCRCBE (ORA_ERR_ROWID,
                                                 FIPAISID,
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
            SELECT ROWID,
                   FIPAISID,
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
              FROM SCACTUALIZADORVT.TATRNCRCB
             WHERE     FIPAISID = PA_COUNTRY
                   AND FICANAL = PA_CHANNEL
                   AND FISUCURSAL = PA_BRANCH
                   AND FITRANNO = PA_TRANSACTION;

        INSERT INTO SCACTUALIZADORVT.TATRNCRDTE (ORA_ERR_ROWID,
                                                 FIPAISID,
                                                 FICANAL,
                                                 FISUCURSAL,
                                                 FITRANNO,
                                                 FICONSDETA,
                                                 FITIPOREG,
                                                 FCDATODETA)
            SELECT ROWID,
                   FIPAISID,
                   FICANAL,
                   FISUCURSAL,
                   FITRANNO,
                   FICONSDETA,
                   FITIPOREG,
                   FCDATODETA
              FROM SCACTUALIZADORVT.TATRNCRDT
             WHERE     FIPAISID = PA_COUNTRY
                   AND FICANAL = PA_CHANNEL
                   AND FISUCURSAL = PA_BRANCH
                   AND FITRANNO = PA_TRANSACTION;

        DELETE FROM SCACTUALIZADORVT.TATRNCRDT
              WHERE     FIPAISID = PA_COUNTRY
                    AND FICANAL = PA_CHANNEL
                    AND FISUCURSAL = PA_BRANCH
                    AND FITRANNO = PA_TRANSACTION;

        DELETE FROM SCACTUALIZADORVT.TATRNCRCB
              WHERE     FIPAISID = PA_COUNTRY
                    AND FICANAL = PA_CHANNEL
                    AND FISUCURSAL = PA_BRANCH
                    AND FITRANNO = PA_TRANSACTION;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
    END;

    PROCEDURE SPSAVEFAULT (PA_MESSAGE_FAULT IN VARCHAR2, ROW_ID IN ROWID)
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO SCACTUALIZADORVT.TAERROR_LOG (FCORA_ERR_MESG,
                                                  ORA_ERR_ROWID)
             VALUES (PA_MESSAGE_FAULT, ROW_ID);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
    END;
END PAACTUALIZA0001;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZA0001" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZA0001" TO "USRINFFENIX";
