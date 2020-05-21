--------------------------------------------------------
--  DDL for Package Body PALOGCOLERR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PALOGCOLERR" 
AS
   CSL_0   CONSTANT INTEGER := 0;
   CSL_1   CONSTANT INTEGER := 1;
   CSL_7   CONSTANT INTEGER := 7;

   PROCEDURE SPSAVE (PA_PROCESS   IN SCSISGES.TALOGCOLERR.FCPROCESO%TYPE,
                     PA_COLERR    IN SCSISGES.TYTBLOG)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
      VL_ID   INTEGER;
   BEGIN
      IF PA_COLERR IS NOT NULL
      THEN
         FOR idx IN CSL_1 .. PA_COLERR.COUNT
         LOOP
            VL_ID := SCSISGES.SEQLOGCOLERR.NEXTVAL ();

            INSERT INTO SCSISGES.TALOGCOLERR (FICOLERRID,
                                              FCPROCESO,
                                              FCSUBPROCESO,
                                              FICODIGO,
                                              FCMENSAJE,
                                              FDCREACION,
                                              FISTATUS,
                                              FDMODIFICACION,
                                              FCUSUARIO)
                 VALUES (VL_ID,
                         PA_PROCESS,
                         PA_COLERR (IDX).FCNOMBRE,
                         PA_COLERR (IDX).FICODERROR,
                         PA_COLERR (IDX).FCDESCERROR,
                         PA_COLERR (IDX).FCFECHAERROR,
                         CSL_1,
                         SYSDATE,
                         USER);
         END LOOP;

         COMMIT;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
   END;

   PROCEDURE SPGET (
      PA_PROCESS        IN     SCSISGES.TALOGCOLERR.FCPROCESO%TYPE,
      PA_INITIAL_DATE   IN     SCSISGES.TALOGCOLERR.FDCREACION%TYPE,
      PA_FINAL_DATE     IN     SCSISGES.TALOGCOLERR.FDCREACION%TYPE,
      PA_DATOS             OUT SYS_REFCURSOR,
      PA_CODE              OUT INTEGER,
      PA_MESSAGE           OUT VARCHAR2,
      PA_DETAIL            OUT VARCHAR2)
   AS
      VL_INITIAL_DATE   DATE;
      VL_FINAL_DATE     DATE;
   BEGIN
      IF PA_INITIAL_DATE IS NULL
      THEN
         VL_INITIAL_DATE := TRUNC (SYSDATE);
      ELSE
         VL_INITIAL_DATE := PA_INITIAL_DATE;
      END IF;

      IF PA_FINAL_DATE IS NULL
      THEN
         VL_FINAL_DATE := TRUNC (SYSDATE);
      ELSE
         VL_FINAL_DATE := PA_FINAL_DATE;
      END IF;

      IF PA_PROCESS IS NULL
      THEN
         OPEN PA_DATOS FOR
              SELECT FICOLERRID,
                     FCPROCESO,
                     FCSUBPROCESO,
                     FICODIGO,
                     FCMENSAJE,
                     FDCREACION
                FROM SCSISGES.TALOGCOLERR
               WHERE TRUNC (FDCREACION) BETWEEN TRUNC (VL_INITIAL_DATE)
                                            AND TRUNC (VL_FINAL_DATE)
            ORDER BY FICOLERRID;
      ELSE
         OPEN PA_DATOS FOR
              SELECT FICOLERRID,
                     FCPROCESO,
                     FCSUBPROCESO,
                     FICODIGO,
                     FCMENSAJE,
                     FDCREACION
                FROM SCSISGES.TALOGCOLERR
               WHERE TRUNC (FDCREACION) BETWEEN TRUNC (VL_INITIAL_DATE)
                                            AND TRUNC (VL_FINAL_DATE)
                     AND FCPROCESO = PA_PROCESS
            ORDER BY FICOLERRID;
      END IF;

      PA_CODE := CSL_0;
      PA_MESSAGE := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN PA_DATOS FOR
            SELECT NULL FICOLERRID,
                   NULL FCPROCESO,
                   NULL FCSUBPROCESO,
                   NULL FICODIGO,
                   NULL FCMENSAJE,
                   NULL FDCREACION
              FROM DUAL;

         PA_CODE := SQLCODE;
         PA_MESSAGE := SQLERRM;
         PA_DETAIL := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   END;

   PROCEDURE SPPURGE (PA_CODE      OUT INTEGER,
                      PA_MESSAGE   OUT VARCHAR2,
                      PA_DETAIL    OUT VARCHAR2)
   AS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      DELETE FROM SCSISGES.TALOGCOLERR
            WHERE TRUNC (FDCREACION) < TRUNC (SYSDATE - CSL_7);

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
END PALOGCOLERR;

/

  GRANT EXECUTE ON "SCSISGES"."PALOGCOLERR" TO "USRSISGES";
