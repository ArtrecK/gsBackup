--------------------------------------------------------
--  DDL for Package PATRANSACCION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PATRANSACCION" AS

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
    );

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
    );

    PROCEDURE spdtransaccion (
        pa_fitrantipo     IN scactualizadorvt.tacattransaccion.fitrantipo%TYPE,
        pa_fipaisid       IN scactualizadorvt.tacattransaccion.fipaisid%TYPE,
        pa_ficanal        IN scactualizadorvt.tacattransaccion.ficanal%TYPE,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    );

    PROCEDURE spstransaccion (
        pa_fitrantipo      IN scactualizadorvt.tacattransaccion.fitrantipo%TYPE,
        pa_fipaisid        IN scactualizadorvt.tacattransaccion.fipaisid%TYPE,
        pa_ficanal         IN scactualizadorvt.tacattransaccion.ficanal%TYPE,
        pa_transacciones   OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2,
        pa_mensajeerror    OUT VARCHAR2
    );

    PROCEDURE spstransaccioncat (
        pa_tipos          OUT scactualizadorvt.patypes.rcgcursor,
        pa_pais           OUT scactualizadorvt.patypes.rcgcursor,
        pa_canal          OUT scactualizadorvt.patypes.rcgcursor,
        pa_codigo         OUT INTEGER,
        pa_mensaje        OUT VARCHAR2,
        pa_mensajeerror   OUT VARCHAR2
    );

END PATRANSACCION;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PATRANSACCION" TO "USRACTVT";
