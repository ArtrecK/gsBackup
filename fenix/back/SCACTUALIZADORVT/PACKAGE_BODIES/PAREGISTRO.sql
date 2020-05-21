--------------------------------------------------------
--  DDL for Package Body PAREGISTRO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAREGISTRO" AS

    csl_sysdate   DATE := SYSDATE;
    csl_user      VARCHAR2(100) := user;
    csl_0         CONSTANT PLS_INTEGER := 0;
    csl_1         CONSTANT PLS_INTEGER := 1;

    PROCEDURE spiregistro (
        pa_fitiporeg       scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid        scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal         scactualizadorvt.taregistro.ficanal%TYPE,
        pa_fcreg_desc      scactualizadorvt.taregistro.fcreg_desc%TYPE,
        pa_fireg_estatus   scactualizadorvt.taregistro.fireg_estatus%TYPE,
        pa_fireg_accion    scactualizadorvt.taregistro.fireg_accion%TYPE,
        pa_fcreg_sp_name   scactualizadorvt.taregistro.fcreg_sp_name%TYPE,
        pa_fcreg_comen     scactualizadorvt.taregistro.fcreg_comen%TYPE,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2,
        pa_mensajeerror    OUT VARCHAR2
    )
        AS
    BEGIN
        INSERT INTO scactualizadorvt.taregistro (
            fitiporeg,
            fipaisid,
            ficanal,
            fcreg_desc,
            fireg_estatus,
            fireg_accion,
            fcreg_sp_name,
            fcreg_comen,
            fcstoreproc,
            fcora_usr,
            fdfecha_alta,
            fdcreacion,
            fdmodifico,
            fcusrmodifico
        ) VALUES (
            pa_fitiporeg,
            pa_fipaisid,
            pa_ficanal,
            pa_fcreg_desc,
            pa_fireg_estatus,
            pa_fireg_accion,
            pa_fcreg_sp_name,
            pa_fcreg_comen,
            NULL,
            NULL,
            csl_sysdate,
            csl_sysdate,
            csl_sysdate,
            csl_user
        );

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al guardar el registro';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spuregistro (
        pa_fitiporeg       scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid        scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal         scactualizadorvt.taregistro.ficanal%TYPE,
        pa_fcreg_desc      scactualizadorvt.taregistro.fcreg_desc%TYPE,
        pa_fireg_estatus   scactualizadorvt.taregistro.fireg_estatus%TYPE,
        pa_fireg_accion    scactualizadorvt.taregistro.fireg_accion%TYPE,
        pa_fcreg_sp_name   scactualizadorvt.taregistro.fcreg_sp_name%TYPE,
        pa_fcreg_comen     scactualizadorvt.taregistro.fcreg_comen%TYPE,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2,
        pa_mensajeerror    OUT VARCHAR2
    )
        AS
    BEGIN
        UPDATE scactualizadorvt.taregistro
        SET
            fcreg_desc = coalesce(pa_fcreg_desc,fcreg_desc),
            fireg_estatus = coalesce(fireg_estatus,fireg_estatus),
            fireg_accion = coalesce(pa_fireg_accion,fireg_accion),
            fcreg_sp_name = coalesce(pa_fcreg_sp_name,fcreg_sp_name),
            fcreg_comen = coalesce(pa_fcreg_comen,fcreg_comen),
            fdfecha_alta = coalesce(csl_sysdate,fdfecha_alta),
            fdcreacion = coalesce(csl_sysdate,fdcreacion),
            fdmodifico = coalesce(csl_sysdate,fdmodifico),
            fcusrmodifico = coalesce(csl_user,fcusrmodifico)
        WHERE
            fitiporeg = pa_fitiporeg
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
            pa_mensaje := 'Ocurrio un problema al actualizar el registro';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spdregistro (
        pa_fitiporeg      scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid       scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal        scactualizadorvt.taregistro.ficanal%TYPE,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    )
        AS
    BEGIN
        DELETE FROM scactualizadorvt.taregistro
        WHERE
            fitiporeg = pa_fitiporeg
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
            pa_mensaje := 'Ocurrio un problema al eliminar el registro';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spsregistro (
        pa_fitiporeg      scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid       scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal        scactualizadorvt.taregistro.ficanal%TYPE,
        pa_registros      OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    ) AS
        vl_tipo_ini    NUMBER;
        vl_tipo_fin    NUMBER;
        vl_pais_ini    NUMBER;
        vl_pais_fin    NUMBER;
        vl_canal_ini   NUMBER;
        vl_canal_fin   NUMBER;
    BEGIN
        IF
            pa_fitiporeg IS NULL
        THEN
            vl_tipo_ini := 0;
            vl_tipo_fin := 9999999999;
        ELSE
            vl_tipo_ini := pa_fitiporeg;
            vl_tipo_fin := pa_fitiporeg;
        END IF;

        IF
            pa_fipaisid IS NULL
        THEN
            vl_pais_ini := 0;
            vl_pais_fin := 9999999999;
        ELSE
            vl_pais_ini := pa_fipaisid;
            vl_pais_fin := pa_fipaisid;
        END IF;

        IF
            pa_ficanal IS NULL
        THEN
            vl_canal_ini := 0;
            vl_canal_fin := 9999999999;
        ELSE
            vl_canal_ini := pa_ficanal;
            vl_canal_fin := pa_ficanal;
        END IF;

        OPEN pa_registros FOR SELECT
            fitiporeg,
            fipaisid,
            ficanal,
            fcreg_desc,
            fireg_estatus,
            fireg_accion,
            fcreg_sp_name,
            fcreg_comen,
            fcstoreproc,
            fcora_usr,
            TO_CHAR(fdfecha_alta,'DD/MM/YYYY HH24:MI:SS') fdfecha_alta,
            TO_CHAR(fdcreacion,'DD/MM/YYYY HH24:MI:SS') fdcreacion,
            TO_CHAR(fdmodifico,'DD/MM/YYYY HH24:MI:SS') fdmodifico,
            fcusrmodifico
                              FROM
            scactualizadorvt.taregistro
                              WHERE
            fitiporeg BETWEEN vl_tipo_ini AND vl_tipo_fin
            AND fipaisid BETWEEN vl_pais_ini AND vl_pais_fin
            AND ficanal BETWEEN vl_canal_ini AND vl_canal_fin;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN pa_registros FOR SELECT
                NULL fitiporeg,
                NULL fipaisid,
                NULL ficanal,
                NULL fcreg_desc,
                NULL fireg_estatus,
                NULL fireg_accion,
                NULL fcreg_sp_name,
                NULL fcreg_comen,
                NULL fcstoreproc,
                NULL fcora_usr,
                NULL fdfecha_alta,
                NULL fdcreacion,
                NULL fdmodifico,
                NULL fcusrmodifico
                                  FROM
                dual;

            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al consultar registros';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

    PROCEDURE spsregistrocat (
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
            fitiporeg
                          FROM
            scactualizadorvt.taregistro
                          WHERE
            fitiporeg > csl_0
            AND fipaisid > csl_0
            AND ficanal > csl_0;

        OPEN pa_pais FOR SELECT DISTINCT
            fipaisid
                         FROM
            scactualizadorvt.taregistro
                         WHERE
            fitiporeg > csl_0
            AND fipaisid > csl_0
            AND ficanal > csl_0;

        OPEN pa_canal FOR SELECT DISTINCT
            ficanal
                          FROM
            scactualizadorvt.taregistro
                          WHERE
            fitiporeg > csl_0
            AND fipaisid > csl_0
            AND ficanal > csl_0;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_mensajeerror := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN pa_tipos FOR SELECT
                NULL fitiporeg
                              FROM
                dual;

            OPEN pa_pais FOR SELECT
                NULL fipaisid
                             FROM
                dual;

            OPEN pa_canal FOR SELECT
                NULL ficanal
                              FROM
                dual;

            pa_codigo := 1;
            pa_mensaje := 'Ocurrio un problema al realizar la consulta';
            pa_mensajeerror := dbms_utility.format_error_backtrace ();
    END;

END PAREGISTRO;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAREGISTRO" TO "USRACTVT";
