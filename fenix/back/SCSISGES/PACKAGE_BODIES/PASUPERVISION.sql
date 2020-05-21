--------------------------------------------------------
--  DDL for Package Body PASUPERVISION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PASUPERVISION" 
IS
    csl_0      CONSTANT INTEGER := 0;
    csl_1      CONSTANT INTEGER := 1;
    csl_2      CONSTANT INTEGER := 2;
    csl_3      CONSTANT INTEGER := 3;
    csl_4      CONSTANT INTEGER := 4;
    csl_n4     CONSTANT INTEGER := -4;
    csl_5      CONSTANT INTEGER := 5;
    csl_6      CONSTANT INTEGER := 6;
    csl_52     CONSTANT PLS_INTEGER := 52;
    csl_8067   CONSTANT INTEGER := 8067;

    PROCEDURE spConVendedores (pa_sucursal      IN     VARCHAR2,
                               pa_curVendedor      OUT SYS_REFCURSOR)
    AS
        PRAGMA AUTONOMOUS_TRANSACTION;
        vl_codigoerror    NUMBER;
        vl_mensajeerror   VARCHAR2 (200);
    BEGIN
        OPEN pa_curVendedor FOR
            SELECT fnempleado,
                   fcnombre,
                   fcapaterno,
                   fcamaterno
              FROM SCSISGES.taempleado
             WHERE     FNCC =
                          csl_52
                       || SUBSTR ('0000' || TO_CHAR (pa_sucursal),
                                  csl_n4,
                                  csl_4)
                   AND fcnegocio = 'EKT'
                   AND FNFUNCION = csl_8067;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            vl_codigoerror := SQLCODE;
            vl_mensajeerror := SQLERRM;

            COMMIT;
    END;

    PROCEDURE spGetAgendados (pa_idSucursal   IN     NUMBER,
                              pa_idVendedor   IN     NUMBER,
                              pa_llamadas        OUT NUMBER,
                              pa_visitas         OUT NUMBER,
                              pa_cambaceo        OUT NUMBER,
                              pa_codError        OUT INTEGER,
                              pa_msgError        OUT VARCHAR2)
    AS
        vl_funcionGe   INTEGER;
        vl_idGerente   INTEGER;
        vl_count       INTEGER;
        vl_funcionVe   INTEGER;
    BEGIN
        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_llamadas
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = csl_1
               AND TO_DATE (ev.FDBITACORA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_visitas
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = csl_3
               AND TO_DATE (ev.FDBITACORA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_cambaceo
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = csl_2
               AND TO_DATE (ev.FDBITACORA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        pa_codError := csl_0;
        pa_msgError := 200;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_llamadas := csl_0;
            pa_visitas := csl_0;
            pa_cambaceo := csl_0;
            pa_codError := csl_1;
            pa_msgError := SQLCODE || '  ' || SQLERRM;
    END spGetAgendados;

    PROCEDURE SPCONTALERNOVISTAS (
        pa_FIEMPNUM       IN     SCSISGES.TAGEOALERTA.FIEMPNUM%TYPE,
        pa_CONTEO            OUT NUMBER,
        pa_CODIGO            OUT INTEGER,
        pa_MENSAJE           OUT VARCHAR2,
        pa_MENSAJEERROR      OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL
        THEN
            SELECT COUNT (TAAGEO.FIEMPNUM) AS FICOUNTALER
              INTO pa_CONTEO
              FROM SCSISGES.TAALERTA  TA
                   JOIN SCSISGES.TAGEOALERTA TAAGEO
                       ON     TAAGEO.FIALERTAID = TA.FIALERTAID
                          AND TAAGEO.FIGEOALERTAID > CSL_0
             WHERE     TAAGEO.FIEMPNUM = pa_FIEMPNUM
                   AND TAAGEO.FIALERTAID NOT IN
                           (SELECT TEMP.FIALERTAID
                              FROM SCSISGES.TAEMPALERTA TEMP
                             WHERE TEMP.FIEMPNUM = pa_FIEMPNUM);
        END IF;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.SPCONTALERNOVISTAS';
    END SPCONTALERNOVISTAS;


    PROCEDURE SPPPTOSGESTIONADOS (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL
        THEN
            SELECT COUNT (1) AS CONTEOPPTOS
              INTO pa_CONTEO
              FROM SCSISGES.TAGESTION  TAGES
                   JOIN SCSISGES.TCTIPOGESTION TCGES
                       ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
             WHERE     TCGES.FITIPOGESTIONID = csl_4
                   AND TAGES.FCEMPNUM = pa_FIEMPNUM
                   AND TAGES.FISUCURSALEMP = pa_FISUCURSALEMP
                   AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE);
        END IF;



        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_CODIGO := 1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PASUPERVISION.SPPPTOSGESTIONADOS';
    END SPPPTOSGESTIONADOS;

    PROCEDURE SPPEDIDOSGESTIONADOS (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL
        THEN
            SELECT COUNT (1) AS CONTEOPEDIDOS
              INTO pa_CONTEO
              FROM SCSISGES.TAGESTION  TAGES
                   JOIN SCSISGES.TCTIPOGESTION TCGES
                       ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
             WHERE     TCGES.FITIPOGESTIONID = csl_2
                   AND TAGES.FCEMPNUM = pa_FIEMPNUM
                   AND TAGES.FISUCURSALEMP = pa_FISUCURSALEMP
                   AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE);
        END IF;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PASUPERVISION.SPPEDIDOSGESTIONADOS';
    END SPPEDIDOSGESTIONADOS;

    PROCEDURE SPSOLSGESTIONADAS (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL
        THEN
            SELECT COUNT (1) AS CONTEOPEDIDOS
              INTO pa_CONTEO
              FROM SCSISGES.TAGESTION  TAGES
                   JOIN SCSISGES.TCTIPOGESTION TCGES
                       ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
             WHERE     TCGES.FITIPOGESTIONID = csl_3
                   AND TAGES.FCEMPNUM = pa_FIEMPNUM
                   AND TAGES.FISUCURSALEMP = pa_FISUCURSALEMP
                   AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE);
        END IF;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PASUPERVISION.SPSOLSGESTIONADAS';
    END SPSOLSGESTIONADAS;

    PROCEDURE SpPromoGestionadas (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL
        THEN
            SELECT COUNT (1) AS CONTEOPEDIDOS
              INTO pa_CONTEO
              FROM SCSISGES.TAGESTION  TAGES
                   JOIN SCSISGES.TCTIPOGESTION TCGES
                       ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
             WHERE     TCGES.FITIPOGESTIONID = csl_5
                   AND TAGES.FCEMPNUM = pa_FIEMPNUM
                   AND TAGES.FISUCURSALEMP = pa_FISUCURSALEMP
                   AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE);
        END IF;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PASUPERVISION.SPSOLSGESTIONADAS';
    END SpPromoGestionadas;

    PROCEDURE SpReactivaGestionadas (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL
        THEN
            SELECT COUNT (1) AS CONTEOPEDIDOS
              INTO pa_CONTEO
              FROM SCSISGES.TAGESTION  TAGES
                   JOIN SCSISGES.TCTIPOGESTION TCGES
                       ON TAGES.FITIPOGESTIONID = TCGES.FITIPOGESTIONID
             WHERE     TCGES.FITIPOGESTIONID = csl_6
                   AND TAGES.FCEMPNUM = pa_FIEMPNUM
                   AND TAGES.FISUCURSALEMP = pa_FISUCURSALEMP
                   AND TRUNC (TAGES.FDCREACION) = TRUNC (SYSDATE);
        END IF;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PASUPERVISION.SPSOLSGESTIONADAS';
    END SpReactivaGestionadas;

    PROCEDURE spEventosDia (pa_idVendedor     IN     NUMBER,
                            pa_evenLLamadas      OUT NUMBER,
                            pa_evenVisitas       OUT NUMBER,
                            pa_evenCambaceo      OUT NUMBER,
                            pa_evenTotal         OUT NUMBER,
                            pa_codError          OUT INTEGER,
                            pa_msgError          OUT VARCHAR2)
    AS
    BEGIN
        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_evenLLamadas
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = csl_1
               AND TO_DATE (ev.FDFECHA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_evenVisitas
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = csl_3
               AND TO_DATE (ev.FDFECHA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_evenCambaceo
          FROM SCSISGES.TAEVENTO ev
         WHERE     ev.FIEVENTO = csl_2
               AND TO_DATE (ev.FDFECHA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        SELECT COUNT (ev.FIUSUARIOID)
          INTO pa_evenTotal
          FROM SCSISGES.TAEVENTO ev
         WHERE     TO_DATE (ev.FDFECHA, 'dd-MM-yy') =
                   TO_DATE (SYSDATE, 'dd-MM-yy')
               AND ev.FIUSUARIOID = pa_idVendedor;

        pa_codError := csl_0;
        pa_msgError := 200;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_evenLLamadas := csl_0;
            pa_evenVisitas := csl_0;
            pa_evenCambaceo := csl_0;
            pa_evenTotal := csl_0;
            pa_codError := csl_1;
            pa_msgError := SQLCODE || '  ' || SQLERRM;
    END spEventosDia;
END PASUPERVISION;

/

  GRANT EXECUTE ON "SCSISGES"."PASUPERVISION" TO "USRSISGES";
