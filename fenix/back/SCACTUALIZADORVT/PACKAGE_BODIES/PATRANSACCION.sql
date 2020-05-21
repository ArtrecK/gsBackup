--------------------------------------------------------
--  DDL for Package Body PATRANSACCION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PATRANSACCION" AS

    csl_sysdate   DATE := SYSDATE;
    csl_user      VARCHAR2(100) := user;
    csl_0         CONSTANT PLS_INTEGER := 0;
    csl_1         CONSTANT PLS_INTEGER := 1;

    PROCEDURE spitransaccion (
        pa_fitrantipo       IN scactualizadorvt.tacattransaccion.fitrantipo%TYPE,
        pa_fipaisid         IN scactualizadorvt.tacattransaccion.fipaisid%TYPE,
        pa_ficanal          IN scactualizadorvt.tacattransaccion.ficanal%TYPE,
        pa_fctran_desc      IN scactualizadorvt.tacattransaccion.fctran_desc%TYPE,
        pa_fitran_estatus   IN scactualizadorvt.tacattransaccion.fitran_estatus%TYPE,
        pa_fctran_comen     IN scactualizadorvt.tacattransaccion.fctran_comen%TYPE,
        pa_fimod_sist       IN scactualizadorvt.tacattransaccion.fimod_sist%TYPE,
        pa_fcora_usr        IN scactualizadorvt.tacattransaccion.fcora_usr%TYPE,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2,
        pa_mensajeerror     OUT VARCHAR2
    )
        AS
    BEGIN
        INSERT INTO scactualizadorvt.tacattransaccion (
            fitrantipo,
            fipaisid,
            ficanal,
            fctran_desc,
            fitran_estatus,
            fctran_comen,
            fimod_sist,
            fcora_usr
        ) VALUES (
            pa_fitrantipo,
            pa_fipaisid,
            pa_ficanal,
            pa_fctran_desc,
            pa_fitran_estatus,
            pa_fctran_comen,
            pa_fimod_sist,
            pa_fcora_usr
        );

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al guardar transaccion';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE sputransaccion (
        pa_fitrantipo       IN scactualizadorvt.tacattransaccion.fitrantipo%TYPE,
        pa_fipaisid         IN scactualizadorvt.tacattransaccion.fipaisid%TYPE,
        pa_ficanal          IN scactualizadorvt.tacattransaccion.ficanal%TYPE,
        pa_fctran_desc      IN scactualizadorvt.tacattransaccion.fctran_desc%TYPE,
        pa_fitran_estatus   IN scactualizadorvt.tacattransaccion.fitran_estatus%TYPE,
        pa_fctran_comen     IN scactualizadorvt.tacattransaccion.fctran_comen%TYPE,
        pa_fimod_sist       IN scactualizadorvt.tacattransaccion.fimod_sist%TYPE,
        pa_fcora_usr        IN scactualizadorvt.tacattransaccion.fcora_usr%TYPE,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2,
        pa_mensajeerror     OUT VARCHAR2
    )
        AS
    BEGIN
        UPDATE scactualizadorvt.tacattransaccion
        SET
            fctran_desc = pa_fctran_desc,
            fitran_estatus = pa_fitran_estatus,
            fctran_comen = pa_fctran_comen,
            fimod_sist = pa_fimod_sist,
            fcora_usr = pa_fcora_usr
        WHERE
            fitrantipo = pa_fitrantipo
            AND fipaisid = pa_fipaisid
            AND ficanal = pa_ficanal;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al actualizar transaccion';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spdtransaccion (
        pa_fitrantipo     IN scactualizadorvt.tacattransaccion.fitrantipo%TYPE,
        pa_fipaisid       IN scactualizadorvt.tacattransaccion.fipaisid%TYPE,
        pa_ficanal        IN scactualizadorvt.tacattransaccion.ficanal%TYPE,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    )
        AS
    BEGIN
        DELETE FROM scactualizadorvt.tacattransaccion
        WHERE
            fitrantipo = pa_fitrantipo
            AND fipaisid = pa_fipaisid
            AND ficanal = pa_ficanal;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al eliminar transaccion';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spstransaccion (
        pa_fitrantipo      IN scactualizadorvt.tacattransaccion.fitrantipo%TYPE,
        pa_fipaisid        IN scactualizadorvt.tacattransaccion.fipaisid%TYPE,
        pa_ficanal         IN scactualizadorvt.tacattransaccion.ficanal%TYPE,
        pa_transacciones   OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2,
        pa_mensajeerror    OUT VARCHAR2
    ) AS

        vl_fitrantipo_ini   scactualizadorvt.tacattransaccion.fitrantipo%TYPE;
        vl_fitrantipo_fin   scactualizadorvt.tacattransaccion.fitrantipo%TYPE;
        vl_fipaisid_ini     scactualizadorvt.tacattransaccion.fipaisid%TYPE;
        vl_fipaisid_fin     scactualizadorvt.tacattransaccion.fipaisid%TYPE;
        vl_ficanal_ini      scactualizadorvt.tacattransaccion.ficanal%TYPE;
        vl_ficanal_fin      scactualizadorvt.tacattransaccion.ficanal%TYPE;
    BEGIN
        IF
            pa_fipaisid IS NULL or pa_fipaisid = 0
        THEN
            vl_fipaisid_ini := 0;
            vl_fipaisid_fin := 99999;
        ELSE
            vl_fipaisid_ini := pa_fipaisid;
            vl_fipaisid_fin := pa_fipaisid;
        END IF;

        IF
            pa_ficanal IS NULL or pa_ficanal = 0
        THEN
            vl_ficanal_ini := 0;
            vl_ficanal_fin := 99999;
        ELSE
            vl_ficanal_ini := pa_ficanal;
            vl_ficanal_fin := pa_ficanal;
        END IF;

        IF
            pa_fitrantipo IS NULL or pa_fitrantipo = 0
        THEN
            vl_fitrantipo_ini := 0;
            vl_fitrantipo_fin := 99999;
        ELSE
            vl_fitrantipo_ini := pa_fitrantipo;
            vl_fitrantipo_fin := pa_fitrantipo;
        END IF;

        OPEN pa_transacciones FOR SELECT
            fitrantipo,
            fipaisid,
            ficanal,
            fctran_desc,
            fitran_estatus,
            fctran_comen,
            fimod_sist,
            fcora_usr,
            TO_CHAR(fdfecha_alta,'DD/MM/YYYY HH24:MI:SS') fdfecha_alta,
            TO_CHAR(fdcreacion,'DD/MM/YYYY HH24:MI:SS') fdcreacion,
            TO_CHAR(fdmodifico,'DD/MM/YYYY HH24:MI:SS') fdmodifico,
            fcusrmodifico
                                  FROM
            scactualizadorvt.tacattransaccion
                                  WHERE
            fitrantipo BETWEEN vl_fitrantipo_ini AND vl_fitrantipo_fin
            AND fipaisid BETWEEN vl_fipaisid_ini AND vl_fipaisid_FIN
            AND ficanal BETWEEN vl_ficanal_ini AND vl_ficanal_FIN;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN pa_transacciones FOR SELECT
                NULL fitrantipo,
                NULL fipaisid,
                NULL ficanal,
                NULL fctran_desc,
                NULL fitran_estatus,
                NULL fctran_comen,
                NULL fimod_sist,
                NULL fcora_usr,
                NULL fdfecha_alta,
                NULL fdcreacion,
                NULL fdmodifico,
                NULL fcusrmodifico
                                      FROM
                dual;

            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al consultar transaccion';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spsTRANSACCIONcat (
        pa_tipos          OUT scactualizadorvt.patypes.rcgcursor,
        pa_pais           OUT scactualizadorvt.patypes.rcgcursor,
        pa_canal          OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    )
        AS
    BEGIN
        OPEN pa_tipos FOR SELECT DISTINCT
            FITRANTIPO
                          FROM
            scactualizadorvt.tacattransaccion
                          WHERE
            FITRANTIPO > csl_0
            AND FIPAISID > csl_0
            AND FICANAL > csl_0;

        OPEN pa_pais FOR SELECT DISTINCT
            FIPAISID
                         FROM
            scactualizadorvt.tacattransaccion
                         WHERE
            FITRANTIPO > csl_0
            AND FIPAISID > csl_0
            AND FICANAL > csl_0;

        OPEN pa_canal FOR SELECT DISTINCT
            FICANAL
                          FROM
            scactualizadorvt.tacattransaccion
                          WHERE
            FITRANTIPO > csl_0
            AND FIPAISID > csl_0
            AND FICANAL > csl_0;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN pa_tipos FOR SELECT
                NULL FITRANTIPO
                              FROM
                dual;

            OPEN pa_pais FOR SELECT
                NULL FIPAISID
                             FROM
                dual;

            OPEN pa_canal FOR SELECT
                NULL FICANAL
                              FROM
                dual;

            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al realizar la consulta';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

END PATRANSACCION;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PATRANSACCION" TO "USRACTVT";
