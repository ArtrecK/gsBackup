--------------------------------------------------------
--  DDL for Package Body PAREPORTES0002
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAREPORTES0002" 
AS
    CSL_0   CONSTANT INTEGER := 0;
    CSL_1   CONSTANT INTEGER := 1;
    CSL_2   CONSTANT INTEGER := 2;
    CSL_3   CONSTANT INTEGER := 3;
    CSL_4   CONSTANT INTEGER := 4;
    CSL_5   CONSTANT INTEGER := 5;
    CSL_6   CONSTANT INTEGER := 6;
    CSL_7   CONSTANT INTEGER := 7;

    PROCEDURE SPGESTIONES (PA_DATA      OUT SYS_REFCURSOR,
                           PA_CODE      OUT INTEGER,
                           PA_MESSAGE   OUT VARCHAR2,
                           PA_DETAIL    OUT VARCHAR2)
    AS
    BEGIN
        OPEN PA_DATA FOR
              SELECT GES.FIPAISEMP
                         PAIS,
                     GES.FICANALEMP
                         CANAL,
                     GES.FISUCURSALEMP
                         SUCURSAL,
                     TO_CHAR (GES.FDCREACION, 'DD/MM/YYYY HH24:MI:SS')
                         FECHA_GESTION,
                     GES.FCEMPNUM
                         NO_EMPLEADO,
                        EMP.FCNOMBRE
                     || ' '
                     || EMP.FCAPATERNO
                     || ' '
                     || EMP.FCAMATERNO
                         NOMBRE_EMPLEADO,
                        LPAD (GES.FIPAISCU, CSL_2, CSL_0)
                     || LPAD (GES.FICANALCU, CSL_2, CSL_0)
                     || '-'
                     || LPAD (GES.FISUCURSALCU, CSL_4, CSL_0)
                     || '-'
                     || GES.FIFOLIOCU
                         CLIENTE_UNICO,
                     TIPO.FCTIPOGESTIONDESC
                         MODULO,
                     GES.FCDESCCAMPANA
                         CAMPANA,
                     MEDIO.FCMEDIOSGESTIONDESC
                         COMO_CONTACTE,
                     RESULTADO.FCRESULTGESTIONDESC
                         RESULTADO,
                     DESCGES.FCDESCGESTION
                         MOTIVO,
                     GES.FCNOTAS
                         NOTAS,
                     EVENTO.FCEVENTO
                         AGENDA,
                     TO_CHAR (AGENDA.FDHORAINICIO, 'DD/MM/YYYY HH24:MI:SS')
                         FECHA_AGENDA
                FROM SCSISGES.TAGESTION GES
                     LEFT JOIN SCSISGES.TAEMPLEADO EMP
                         ON     EMP.FNCC >= CSL_0
                            AND EMP.FNEMPLEADO = TO_NUMBER (GES.FCEMPNUM)
                            AND EMP.FNCC = EMP.FNCC + CSL_0
                     INNER JOIN SCSISGES.TCTIPOGESTION TIPO
                         ON     TIPO.FITIPOGESTIONID = GES.FITIPOGESTIONID
                            AND TIPO.FITIPOGESTIONID IN (CSL_2,
                                                         CSL_3,
                                                         CSL_4,
                                                         CSL_5,
                                                         CSL_6,
                                                         CSL_7)
                     INNER JOIN SCSISGES.TCMEDIOGESTION MEDIO
                         ON     MEDIO.FIMEDIOGESTIONID = GES.FIMEDIOGESTIONID
                            AND MEDIO.FIMEDIOGESTIONID IN (CSL_1, CSL_2, CSL_3)
                     INNER JOIN SCSISGES.TCRESULTGESTION RESULTADO
                         ON     RESULTADO.FIRESULTGESTIONID =
                                GES.FIRESULTGESTIONID
                            AND RESULTADO.FIRESULTGESTIONID IN (CSL_1,
                                                                CSL_2,
                                                                CSL_3,
                                                                CSL_4,
                                                                CSL_5,
                                                                CSL_6)
                     LEFT JOIN SCSISGES.TAEVENTGEST EVENTGEST
                         ON     GES.FIGESTIONID = EVENTGEST.FIGESTIONID
                            AND EVENTGEST.FIGESTIONID >= CSL_0
                     LEFT JOIN SCSISGES.TAEVENTO AGENDA
                         ON     AGENDA.FIUSUARIOID = EVENTGEST.FIUSUARIOID
                            AND AGENDA.FICLIENTE = EVENTGEST.FICLIENTE
                            AND AGENDA.FIIDEVENTO = EVENTGEST.FIEVENTOID
                            AND AGENDA.FIUSUARIOID >= CSL_0
                            AND AGENDA.FIIDEVENTO >= CSL_0
                     LEFT JOIN SCSISGES.TCEVENTO EVENTO
                         ON     EVENTO.FIEVENTO = AGENDA.FIEVENTO
                            AND EVENTO.FIEVENTO IN (CSL_1,
                                                    CSL_2,
                                                    CSL_3,
                                                    CSL_4)
                     LEFT JOIN SCSISGES.TCDESCGESTION DESCGES
                         ON     DESCGES.FITIPOGESTION = GES.FITIPOGESTIONID
                            AND DESCGES.FIMEDIOGESTION = GES.FIMEDIOGESTIONID
                            AND DESCGES.FIRESULGESTION = GES.FIRESULTGESTIONID
                            AND DESCGES.FIDESCGESTION = GES.FIDESCGESTION
                            AND DESCGES.FITIPOGESTION =
                                DESCGES.FITIPOGESTION + CSL_0
                            AND DESCGES.FIMEDIOGESTION =
                                DESCGES.FIMEDIOGESTION + CSL_0
                            AND DESCGES.FIRESULGESTION =
                                DESCGES.FIRESULGESTION + CSL_0
                            AND DESCGES.FIDESCGESTION =
                                DESCGES.FIDESCGESTION + CSL_0
               WHERE TRUNC (GES.FDCREACION) >= TRUNC (SYSDATE - CSL_1)
            ORDER BY CSL_1,
                     CSL_2,
                     CSL_3,
                     CSL_4;

        PA_CODE := CSL_0;
        PA_MESSAGE := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN PA_DATA FOR SELECT NULL PAIS,
                                    NULL CANAL,
                                    NULL SUCURSAL,
                                    NULL FECHA_GESTION,
                                    NULL NO_EMPLEADO,
                                    NULL NOMBRE_EMPLEADO,
                                    NULL CLIENTE_UNICO,
                                    NULL MODULO,
                                    NULL CAMPANA,
                                    NULL COMO_CONTACTE,
                                    NULL RESULTADO,
                                    NULL MOTIVO,
                                    NULL NOTAS,
                                    NULL AGENDA,
                                    NULL FECHA_AGENDA
                               FROM DUAL;

            PA_CODE := SQLCODE;
            PA_MESSAGE := SQLERRM;
            PA_DETAIL := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    END;

    /*
    * Consulta para reporte de gestiones V2
    * param   N/A.
    * return  Gestiones con Zona y Region.
    * author  Marcos Glez
    */
    PROCEDURE SPGESTIONESV2 (PA_DATA      OUT SYS_REFCURSOR,
                             PA_CODE      OUT INTEGER,
                             PA_MESSAGE   OUT VARCHAR2,
                             PA_DETAIL    OUT VARCHAR2)
    AS
    BEGIN
        OPEN PA_DATA FOR
              SELECT GES.FIPAISEMP
                         PAIS,
                     GES.FICANALEMP
                         CANAL,
                     SUC.FIIDZONA
                         ZONA,
                     SUC.FIIDREGION
                         REGION,
                     GES.FISUCURSALEMP
                         SUCURSAL,
                     TO_CHAR (GES.FDCREACION, 'DD/MM/YYYY HH24:MI:SS')
                         FECHA_GESTION,
                     GES.FCEMPNUM
                         NO_EMPLEADO,
                        EMP.FCNOMBRE
                     || ' '
                     || EMP.FCAPATERNO
                     || ' '
                     || EMP.FCAMATERNO
                         NOMBRE_EMPLEADO,
                        LPAD (GES.FIPAISCU, CSL_2, CSL_0)
                     || LPAD (GES.FICANALCU, CSL_2, CSL_0)
                     || '-'
                     || LPAD (GES.FISUCURSALCU, CSL_4, CSL_0)
                     || '-'
                     || GES.FIFOLIOCU
                         CLIENTE_UNICO,
                     TIPO.FCTIPOGESTIONDESC
                         MODULO,
                     GES.FCDESCCAMPANA
                         CAMPANA,
                     MEDIO.FCMEDIOSGESTIONDESC
                         COMO_CONTACTE,
                     RESULTADO.FCRESULTGESTIONDESC
                         RESULTADO,
                     DESCGES.FCDESCGESTION
                         MOTIVO,
                     GES.FCNOTAS
                         NOTAS
                FROM SCSISGES.TAGESTION GES
                     LEFT JOIN SCSISGES.TAEMPLEADO EMP
                         ON     EMP.FNCC >= CSL_0
                            AND EMP.FNEMPLEADO = TO_NUMBER (GES.FCEMPNUM)
                            AND EMP.FNCC = EMP.FNCC + CSL_0
                     LEFT JOIN SCSISGES.TCFXSUCURSAL SUC
                         ON     SUC.FINUMCECOSUC >= CSL_0
                            AND SUC.FINUMCECOSUC = EMP.FNCC
                            AND SUC.FINUMCECOSUC = EMP.FNCC + CSL_0
                     INNER JOIN SCSISGES.TCTIPOGESTION TIPO
                         ON     TIPO.FITIPOGESTIONID = GES.FITIPOGESTIONID
                            AND TIPO.FITIPOGESTIONID IN (CSL_2,
                                                         CSL_3,
                                                         CSL_4,
                                                         CSL_5,
                                                         CSL_6,
                                                         CSL_7)
                     INNER JOIN SCSISGES.TCMEDIOGESTION MEDIO
                         ON     MEDIO.FIMEDIOGESTIONID = GES.FIMEDIOGESTIONID
                            AND MEDIO.FIMEDIOGESTIONID IN (CSL_1, CSL_2, CSL_3)
                     INNER JOIN SCSISGES.TCRESULTGESTION RESULTADO
                         ON     RESULTADO.FIRESULTGESTIONID =
                                GES.FIRESULTGESTIONID
                            AND RESULTADO.FIRESULTGESTIONID IN (CSL_1,
                                                                CSL_2,
                                                                CSL_3,
                                                                CSL_4,
                                                                CSL_5,
                                                                CSL_6)
                     LEFT JOIN SCSISGES.TAEVENTGEST EVENTGEST
                         ON     GES.FIGESTIONID = EVENTGEST.FIGESTIONID
                            AND EVENTGEST.FIGESTIONID >= CSL_0
                     LEFT JOIN SCSISGES.TCDESCGESTION DESCGES
                         ON     DESCGES.FITIPOGESTION = GES.FITIPOGESTIONID
                            AND DESCGES.FIMEDIOGESTION = GES.FIMEDIOGESTIONID
                            AND DESCGES.FIRESULGESTION = GES.FIRESULTGESTIONID
                            AND DESCGES.FIDESCGESTION = GES.FIDESCGESTION
                            AND DESCGES.FITIPOGESTION =
                                DESCGES.FITIPOGESTION + CSL_0
                            AND DESCGES.FIMEDIOGESTION =
                                DESCGES.FIMEDIOGESTION + CSL_0
                            AND DESCGES.FIRESULGESTION =
                                DESCGES.FIRESULGESTION + CSL_0
                            AND DESCGES.FIDESCGESTION =
                                DESCGES.FIDESCGESTION + CSL_0
               WHERE TRUNC (GES.FDCREACION) >= TRUNC (SYSDATE - CSL_1)
            ORDER BY CSL_1,
                     CSL_2,
                     CSL_3,
                     CSL_4;

        PA_CODE := CSL_0;
        PA_MESSAGE := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN PA_DATA FOR SELECT NULL PAIS,
                                    NULL CANAL,
                                    NULL ZONA,
                                    NULL REGION,
                                    NULL SUCURSAL,
                                    NULL FECHA_GESTION,
                                    NULL NO_EMPLEADO,
                                    NULL NOMBRE_EMPLEADO,
                                    NULL CLIENTE_UNICO,
                                    NULL MODULO,
                                    NULL CAMPANA,
                                    NULL COMO_CONTACTE,
                                    NULL RESULTADO,
                                    NULL MOTIVO,
                                    NULL NOTAS
                               FROM DUAL;

            PA_CODE := SQLCODE;
            PA_MESSAGE := SQLERRM;
            PA_DETAIL := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    END;
END PAREPORTES0002;

/

  GRANT EXECUTE ON "SCSISGES"."PAREPORTES0002" TO "USRSISGES";
