--------------------------------------------------------
--  DDL for Package Body PAMONITOREO0002
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAMONITOREO0002" AS

    csg_tipoaplicacion   scactualizadorvt.tactrlerrores.fitipoaplicacion%TYPE := 78000; -- Identificador de error. para el modulo de transacciones.
    csl_0                CONSTANT INTEGER := 0;
    csl_1                CONSTANT INTEGER := 1;

    PROCEDURE spgettotpagerrorlog (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) AS

        vl_stserr           NUMBER(1) := 0; -- Status para Error
        vl_regxpag          NUMBER(2) := 20; -- registros por pagina 
        vl_totpagina        NUMBER(10) := 0;-- numero total de paginas
        vl_totalregistros   NUMBER(10) := 0;-- total de registros
    BEGIN
        SELECT
            COUNT(ROWID)
        INTO vl_totalregistros
        FROM
            scactualizadorvt.taerror_log
        WHERE
            fists_errsol = vl_stserr;

        pa_totalpaginas := ceil(vl_totalregistros / vl_regxpag);
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spgettotpagerrorlog;

    PROCEDURE spgeterrorlog (
        pa_numeropag        IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) AS

        vl_stserr         NUMBER(1) := 0; -- Status para Error 
        vl_paginauno      NUMBER(1) := 1; -- pagina uno  
        vl_regini         NUMBER(10) := 0; -- pagina inicial
        vl_regfin         NUMBER(10) := 0; -- pagina final
        vl_maxregpagina   NUMBER(2) := 20; -- maximo de registros x pagina
    BEGIN
        IF
            pa_numeropag = vl_paginauno
        THEN
            vl_regini := csl_1;
            vl_regfin := vl_maxregpagina;
        ELSE
            vl_regini := ( ( pa_numeropag - csl_1 ) * vl_maxregpagina ) + csl_1;
            vl_regfin := ( vl_regini + vl_maxregpagina ) - csl_1;
        END IF;

        OPEN pa_datos FOR SELECT
            b.fecha AS "FECHA-SURGIO-ERROR",
            b.errproc AS "PROCESO-GENERO",
            b.iderr AS "ID-DEL-ERROR",
            b.msgerr AS "MENSAJE-DE-ERROR",
            b.errora AS "ERROR-ORACLE",
            b.msgora AS "MENSAJE-ERROR-ORACLE",
            b.usrora AS "USUARIO-ERROR-ORACLE",
            b.bdora AS "BD-ERROR-ORACLE",
            b.iperrora AS "IP-ERROR-ORACLE",
            b.idrow AS idrow --EL ROWID ESTA EN RAW
                          FROM
            (
                SELECT
                    ROWNUM AS idcolumn,
                    TO_CHAR(fderr_fecha,'YYYY-MM-DD HH24:MI:SS') AS fecha,
                    fcerr_proceso AS errproc,
                    fierr_id AS iderr,
                    fcerr_msg AS msgerr,
                    fcora_err AS errora,
                    fcora_err_mesg AS msgora,
                    fcora_err_usr AS usrora,
                    fcora_db_name AS bdora,
                    fcora_ip_address AS iperrora,
                    rowidtochar(ROWID) AS idrow
                FROM
                    scactualizadorvt.taerror_log
                WHERE
                    fists_errsol = vl_stserr
            ) b
                          WHERE
            b.idcolumn BETWEEN vl_regini AND vl_regfin;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
        OPEN pa_datos FOR SELECT
            null AS "FECHA-SURGIO-ERROR",
            null AS "PROCESO-GENERO",
            null AS "ID-DEL-ERROR",
            null AS "MENSAJE-DE-ERROR",
            null AS "ERROR-ORACLE",
            null AS "MENSAJE-ERROR-ORACLE",
            null AS "USUARIO-ERROR-ORACLE",
            null AS "BD-ERROR-ORACLE",
            null AS "IP-ERROR-ORACLE",
            null AS idrow --EL ROWID ESTA EN RAW
                          FROM dual;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spgeterrorlog;

    PROCEDURE spupderrorlog (
        pa_erridrow         IN VARCHAR2,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) AS
   -- Constantes 
        vl_stserr      NUMBER(1) := 1; -- Status para Error, Guardando Mensaje 
        vl_stssalida   NUMBER := 0; -- varaiable de salida
        vl_rowid       ROWID;    --Variable que contiene el ROWID en tipo caracter
    BEGIN
        vl_rowid := chartorowid(pa_erridrow);
        UPDATE scactualizadorvt.taerror_log
        SET
            fists_errsol = vl_stserr,
            fdfecha_errsol = SYSDATE
        WHERE
            ROWID = vl_rowid;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
            scactualizadorvt.pautil.spictrlerrores(csg_tipoaplicacion,'SCACTUALIZADORVT.pamonitoreo0002.FNUPDERRORLOG',sqlcode,sqlerrm,'Hubo problemas al depurar el error con ROWID = '
                                                                                                                                         || pa_erridrow
                                                                                                                                         || ' <<');

    END spupderrorlog;

END pamonitoreo0002;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0002" TO "USRACTVT";
