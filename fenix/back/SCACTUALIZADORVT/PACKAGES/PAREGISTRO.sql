--------------------------------------------------------
--  DDL for Package PAREGISTRO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAREGISTRO" AS
    PROCEDURE spiregistro (
        pa_fitiporeg       IN scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid        IN scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal         IN scactualizadorvt.taregistro.ficanal%TYPE,
        pa_fcreg_desc      IN scactualizadorvt.taregistro.fcreg_desc%TYPE,
        pa_fireg_estatus   IN scactualizadorvt.taregistro.fireg_estatus%TYPE,
        pa_fireg_accion    IN scactualizadorvt.taregistro.fireg_accion%TYPE,
        pa_fcreg_sp_name   IN scactualizadorvt.taregistro.fcreg_sp_name%TYPE,
        pa_fcreg_comen     IN scactualizadorvt.taregistro.fcreg_comen%TYPE,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2,
        pa_mensajeerror    OUT VARCHAR2
    );

    PROCEDURE spuregistro (
        pa_fitiporeg       IN scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid        IN scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal         IN scactualizadorvt.taregistro.ficanal%TYPE,
        pa_fcreg_desc      IN scactualizadorvt.taregistro.fcreg_desc%TYPE,
        pa_fireg_estatus   IN scactualizadorvt.taregistro.fireg_estatus%TYPE,
        pa_fireg_accion    IN scactualizadorvt.taregistro.fireg_accion%TYPE,
        pa_fcreg_sp_name   IN scactualizadorvt.taregistro.fcreg_sp_name%TYPE,
        pa_fcreg_comen     IN scactualizadorvt.taregistro.fcreg_comen%TYPE,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2,
        pa_mensajeerror    OUT VARCHAR2
    );

    PROCEDURE spdregistro (
        pa_fitiporeg      scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid       scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal        scactualizadorvt.taregistro.ficanal%TYPE,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    );

    PROCEDURE spsregistro (
        pa_fitiporeg      IN scactualizadorvt.taregistro.fitiporeg%TYPE,
        pa_fipaisid       IN scactualizadorvt.taregistro.fipaisid%TYPE,
        pa_ficanal        IN scactualizadorvt.taregistro.ficanal%TYPE,
        pa_registros      OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    );

    PROCEDURE spsregistrocat (
        pa_tipos          OUT scactualizadorvt.patypes.rcgcursor,
        pa_pais           OUT scactualizadorvt.patypes.rcgcursor,
        pa_canal          OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    );

END PAREGISTRO;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAREGISTRO" TO "USRACTVT";
