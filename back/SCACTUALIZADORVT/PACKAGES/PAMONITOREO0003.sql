--------------------------------------------------------
--  DDL for Package PAMONITOREO0003
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAMONITOREO0003" AS
    procedure spobtienetotalpagina_head (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    procedure spobtienetotalpagina_det (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    procedure spobtieneerror_transac_head (
        pa_numpagina   IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    procedure spobtieneerror_transac_det (
        pa_numpagina   IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    PROCEDURE spdepuraerror_transac_head (
        pa_pais       IN scactualizadorvt.tatrncrcbe.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrcbe.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrcbe.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrcbe.fitranno%TYPE,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    PROCEDURE spdepuraerror_transac_det (
        pa_pais       IN scactualizadorvt.tatrncrdte.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdte.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdte.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdte.fitranno%TYPE,
        pa_condet     IN scactualizadorvt.tatrncrdte.ficonsdeta%TYPE,
        pa_tiporeg    IN scactualizadorvt.tatrncrdte.fitiporeg%TYPE,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

END pamonitoreo0003;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0003" TO "USRACTVT";
