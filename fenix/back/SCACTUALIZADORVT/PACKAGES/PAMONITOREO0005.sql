--------------------------------------------------------
--  DDL for Package PAMONITOREO0005
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAMONITOREO0005" AS
    FUNCTION fngetproctransac RETURN scactualizadorvt.pautil.rcg_tipocursor;

    FUNCTION fngettotpagetactrlerrores RETURN NUMBER;

    FUNCTION fngettactrlerrores (
        pa_numeropag IN NUMBER
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor;

    PROCEDURE spdepuraerror_transac (
        pa_pais       IN scactualizadorvt.tatrncrcbe.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrcbe.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrcbe.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrcbe.fitranno%TYPE
    );

    FUNCTION fngettrandeta (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor;

    FUNCTION fncosultran (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrcb.fisucursal%TYPE
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor;

    FUNCTION fndeletedeta (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE,
        pa_numedeta   IN NUMBER
    ) RETURN NUMBER;

    FUNCTION fncosultrandeta (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE,
        pa_numedeta   IN NUMBER
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor;

    FUNCTION fnupdtactrlerrores (
        pa_erridrow IN VARCHAR2
    ) RETURN NUMBER;

END pamonitoreo0005;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0005" TO "USRACTVT";
