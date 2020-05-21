--------------------------------------------------------
--  DDL for Package PAMONITOREO0004
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAMONITOREO0004" 
AS
    PROCEDURE spobtienetotcabe (
        pa_fechainiciotran   IN     VARCHAR2,
        pa_fechafintran      IN     VARCHAR2,
        pa_pais              IN     scactualizadorvt.tatrncrcb.fipaisid%TYPE,
        pa_canal             IN     scactualizadorvt.tatrncrcb.ficanal%TYPE,
        pa_sucursal          IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_tipotran          IN     scactualizadorvt.tatrncrcb.fitrantipo%TYPE,
        pa_totalpaginas         OUT NUMBER,
        pa_codigo               OUT NUMBER,
        pa_mensaje              OUT VARCHAR2,
        pa_detallemensaje       OUT VARCHAR2);

    PROCEDURE spobtienecabe (
        pa_fechainiciotran   IN     VARCHAR2,
        pa_fechafintran      IN     VARCHAR2,
        pa_pais              IN     scactualizadorvt.tatrncrcb.fipaisid%TYPE,
        pa_canal             IN     scactualizadorvt.tatrncrcb.ficanal%TYPE,
        pa_sucursal          IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_tipotran          IN     scactualizadorvt.tatrncrcb.fitrantipo%TYPE,
        pa_numpagina         IN     NUMBER,
        pa_datos                OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo               OUT NUMBER,
        pa_mensaje              OUT VARCHAR2,
        pa_detallemensaje       OUT VARCHAR2);

    PROCEDURE spobtienepais (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2);

    PROCEDURE spobtienecanal (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2);

    PROCEDURE spobtienesuc (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2);

    PROCEDURE spobtienetransac (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2);

    PROCEDURE spupdatetransaction (
        pa_pais             IN     scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal            IN     scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno           IN     scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal         IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_consectipo       IN     scactualizadorvt.tatrncrcb.ficonsectipo%TYPE,
        pa_trannoreg        IN     scactualizadorvt.tatrncrcb.fitrannoreg%TYPE,
        pa_codigo              OUT NUMBER,
        pa_mensaje             OUT VARCHAR2,
        pa_detallemensaje      OUT VARCHAR2);

    PROCEDURE spomitirtransac (
        pa_pais             IN     scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal            IN     scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno           IN     scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal         IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_codigo              OUT NUMBER,
        pa_mensaje             OUT VARCHAR2,
        pa_detallemensaje      OUT VARCHAR2);

    PROCEDURE spdeletetran (
        pa_pais             IN     scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal            IN     scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno           IN     scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal         IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_codigo              OUT NUMBER,
        pa_mensaje             OUT VARCHAR2,
        pa_detallemensaje      OUT VARCHAR2);
END pamonitoreo0004;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0004" TO "USRACTVT";
