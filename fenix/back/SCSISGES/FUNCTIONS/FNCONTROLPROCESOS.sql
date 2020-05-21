--------------------------------------------------------
--  DDL for Function FNCONTROLPROCESOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNCONTROLPROCESOS" (
    pa_Anio              IN SCSISGES.TCCONTROLJOBS.FIANIO%TYPE,
    pa_Mes               IN SCSISGES.TCCONTROLJOBS.FIMES%TYPE,
    pa_Dia               IN SCSISGES.TCCONTROLJOBS.FIDIA%TYPE,
    pa_HoraIni           IN SCSISGES.TCCONTROLJOBS.FCHORAINI%TYPE,
    pa_Horafin           IN SCSISGES.TCCONTROLJOBS.FCHORAFIN%TYPE,
    pa_NombreProc        IN SCSISGES.TCCONTROLJOBS.FCNOMBREPROCESO%TYPE,
    pa_fdfecha           IN SCSISGES.TCCONTROLJOBS.FDFECHA%TYPE,
    pa_DescError         IN SCSISGES.TCCONTROLJOBS.FCDESCERROR%TYPE,
    pa_Status            IN SCSISGES.TCCONTROLJOBS.FISTATUSEJEC%TYPE,
    pa_fiidproc          IN SCSISGES.TCCONTROLJOBS.FIIDPROC%TYPE,
    pa_fntipoejecucion   IN NUMBER)
    RETURN PLS_INTEGER
IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    CSL_0        CONSTANT PLS_INTEGER := 0;
    CSL_1        CONSTANT PLS_INTEGER := 1;
    CSL_2        CONSTANT PLS_INTEGER := 2;
    CSL_N1       CONSTANT PLS_INTEGER := -1;
    CSL_200      CONSTANT PLS_INTEGER := 200;
    vl_usuario   CONSTANT VARCHAR2 (30) := USER;
    vl_nextid             PLS_INTEGER := 0;

    FUNCTION FNSECUENCIA
        RETURN NUMBER
    IS
        vl_SEQ   PLS_INTEGER := 0;
    BEGIN
        SELECT NVL (MAX (T.FIIDPROC), CSL_0) + CSL_1
          INTO vl_SEQ
          FROM SCSISGES.TCCONTROLJOBS T;

        RETURN vl_SEQ;
    END;
--0: INICIO | 1: FIN | 2:ERROR
BEGIN
    CASE pa_fntipoejecucion
        --ejecucion procesos desde tibco y back
        WHEN CSL_1
        THEN
            --si el id de proceso es cero entonces se otorga un id
            IF pa_fiidproc = CSL_0
            THEN
                vl_nextid := FNSECUENCIA;

                INSERT INTO SCSISGES.TCCONTROLJOBS (fiidproc,
                                                    fianio,
                                                    fimes,
                                                    fidia,
                                                    fchoraini,
                                                    fchorafin,
                                                    fcnombreproceso,
                                                    fdfecha,
                                                    fcdescerror,
                                                    fistatusejec,
                                                    fcusrmodifico,
                                                    fdmodificacion)
                     VALUES (vl_nextid,
                             EXTRACT (YEAR FROM SYSDATE),
                             EXTRACT (MONTH FROM SYSDATE),
                             EXTRACT (DAY FROM SYSDATE),
                             pa_HoraIni,
                             pa_HoraFin,
                             pa_NombreProc,
                             TRUNC (pa_fdfecha),
                             pa_DescError,
                             CSL_0,
                             vl_usuario,
                             SYSDATE);

                COMMIT;
                RETURN vl_nextid;                     --retornar id de proceso
            ELSE
                --finaliza con exito
                IF pa_Status = CSL_1
                THEN
                    UPDATE SCSISGES.TCCONTROLJOBS T
                       SET FISTATUSEJEC = pa_Status, --debe venir en uno para registrar exito
                                                     FCHORAFIN = pa_HoraFin --hora de finalizacion
                     WHERE T.Fiidproc = pa_fiidproc;

                    COMMIT;
                    RETURN CSL_0;
                --si viene un status con error: 2 se registra aqui
                ELSIF pa_Status = CSL_2
                THEN
                    UPDATE SCSISGES.TCCONTROLJOBS T
                       SET FISTATUSEJEC = pa_Status,
                           FCHORAFIN = pa_HoraFin,
                           FCDESCERROR = pa_DescError
                     WHERE T.FIIDPROC = pa_fiidproc;

                    COMMIT;
                    RETURN CSL_N1; --retornar -1 para indicar que se registro con error
                --cualquier otro estatus regresamos -1
                ELSE
                    RETURN CSL_N1;
                END IF;
            END IF;
        --ejecucion de mapas
        WHEN CSL_2
        THEN
            --si el id de proceso es cero entonces se otorga un id
            IF pa_fiidproc = CSL_0
            THEN
                vl_nextid := FNSECUENCIA;

                INSERT INTO SCSISGES.TCCONTROLJOBS (fiidproc,
                                                    fianio,
                                                    fimes,
                                                    fidia,
                                                    fchoraini,
                                                    fchorafin,
                                                    fcnombreproceso,
                                                    fdfecha,
                                                    fcdescerror,
                                                    fistatusejec,
                                                    fcusrmodifico,
                                                    fdmodificacion)
                     VALUES (vl_nextid,
                             pa_Anio,
                             pa_Mes,
                             pa_Dia,
                             pa_HoraIni,
                             pa_HoraFin,
                             pa_NombreProc,
                             TRUNC (pa_fdfecha),
                             pa_DescError,
                             CSL_0,
                             vl_usuario,
                             SYSDATE);

                COMMIT;
                RETURN vl_nextid;                     --retornar id de proceso
            ELSE
                --finaliza con exito
                IF pa_Status = CSL_1
                THEN
                    UPDATE SCSISGES.TCCONTROLJOBS T
                       SET FISTATUSEJEC = pa_Status, --debe venir en uno para registrar exito
                                                     FCHORAFIN = pa_HoraFin --hora de finalizacion
                     WHERE T.Fiidproc =
                           (SELECT MAX (TC.FIIDPROC)
                              FROM SCSISGES.TCCONTROLJOBS TC
                             WHERE     TC.FCNOMBREPROCESO = pa_NombreProc
                                   AND TRUNC (T.FDFECHA) = TRUNC (pa_fdfecha));

                    COMMIT;
                    RETURN CSL_0;
                --si viene un status con error: 2 se registra aqui
                ELSIF pa_Status = CSL_2
                THEN
                    UPDATE SCSISGES.TCCONTROLJOBS T
                       SET FISTATUSEJEC = pa_Status,
                           FCHORAFIN = pa_HoraFin,
                           FCDESCERROR = pa_DescError
                     WHERE T.FIIDPROC =
                           (SELECT MAX (TC.FIIDPROC)
                              FROM SCSISGES.TCCONTROLJOBS TC
                             WHERE     TC.FCNOMBREPROCESO = pa_NombreProc
                                   AND TRUNC (T.FDFECHA) = TRUNC (pa_fdfecha));

                    COMMIT;
                    RETURN CSL_N1; --retornar -1 para indicar que se registro con error
                --cualquier otro estatus regresar -1
                ELSE
                    RETURN CSL_N1;
                END IF;
            END IF;
    END CASE;
EXCEPTION
    WHEN OTHERS
    THEN
        ROLLBACK;
        SCSISGES.SPERRORES (SYSDATE,
                            SQLCODE,
                            SUBSTR (SQLERRM, CSL_1, CSL_200),
                            'FNCONTROLPROCESOS');
        RETURN CSL_N1;
END FNCONTROLPROCESOS;

/

  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "USRACTVT";
  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."FNCONTROLPROCESOS" TO "USRVENTAST";
