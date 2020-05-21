--------------------------------------------------------
--  DDL for Package PADISTRIBUCIONTRANSAC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PADISTRIBUCIONTRANSAC" 
AS
    PROCEDURE spicabtran (
        pa_pais          IN scactualizadorvt.tatrncrcb.fipaisid%TYPE,
        pa_canal         IN scactualizadorvt.tatrncrcb.ficanal%TYPE,
        pa_sucursal      IN scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_tranno        IN scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_trantipo      IN scactualizadorvt.tatrncrcb.fitrantipo%TYPE,
        pa_consecutivo   IN scactualizadorvt.tatrncrcb.ficonsectipo%TYPE,
        pa_transfechr    IN VARCHAR2,
        pa_tranws        IN scactualizadorvt.tatrncrcb.fctranws%TYPE,
        pa_tranusr       IN scactualizadorvt.tatrncrcb.fctranusr%TYPE,
        pa_trannoreg     IN scactualizadorvt.tatrncrcb.fitrannoreg%TYPE);

    PROCEDURE spidettran (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_consdet    IN scactualizadorvt.tatrncrdt.ficonsdeta%TYPE,
        pa_tiporeg    IN scactualizadorvt.tatrncrdt.fitiporeg%TYPE,
        pa_datodet    IN scactualizadorvt.tatrncrdt.fcdatodeta%TYPE);

    PROCEDURE spicabtranerror (
        pa_pais          IN scactualizadorvt.tatrncrcbe.fipaisid%TYPE,
        pa_canal         IN scactualizadorvt.tatrncrcbe.ficanal%TYPE,
        pa_sucursal      IN scactualizadorvt.tatrncrcbe.fisucursal%TYPE,
        pa_tranno        IN scactualizadorvt.tatrncrcbe.fitranno%TYPE,
        pa_trantipo      IN scactualizadorvt.tatrncrcbe.fitrantipo%TYPE,
        pa_consecutivo   IN scactualizadorvt.tatrncrcbe.ficonsectipo%TYPE,
        pa_transfechr    IN VARCHAR2,
        pa_tranws        IN scactualizadorvt.tatrncrcbe.fctranws%TYPE,
        pa_tranusr       IN scactualizadorvt.tatrncrcbe.fctranusr%TYPE,
        pa_trannoreg     IN scactualizadorvt.tatrncrcbe.fitrannoreg%TYPE);

    PROCEDURE spidettranerror (
        pa_pais       IN scactualizadorvt.tatrncrdte.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdte.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdte.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdte.fitranno%TYPE,
        pa_consdet    IN scactualizadorvt.tatrncrdte.ficonsdeta%TYPE,
        pa_tiporeg    IN scactualizadorvt.tatrncrdte.fitiporeg%TYPE,
        pa_datodet    IN scactualizadorvt.tatrncrdte.fcdatodeta%TYPE);

    PROCEDURE spinsertaregistro (
        pa_pais          IN scactualizadorvt.tatrncrcb.fipaisid%TYPE,
        pa_canal         IN scactualizadorvt.tatrncrcb.ficanal%TYPE,
        pa_sucursal      IN scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_tranno        IN scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_trantipo      IN scactualizadorvt.tatrncrcb.fitrantipo%TYPE,
        pa_consecutivo   IN scactualizadorvt.tatrncrcb.ficonsectipo%TYPE,
        pa_transfechr    IN VARCHAR2,
        pa_tranws        IN scactualizadorvt.tatrncrcb.fctranws%TYPE,
        pa_tranusr       IN scactualizadorvt.tatrncrcb.fctranusr%TYPE,
        pa_trannoreg     IN scactualizadorvt.tatrncrcb.fitrannoreg%TYPE,
        pa_dettran       IN scactualizadorvt.tbtrancredet);

    PROCEDURE spinsertaregistroerror (
        pa_pais          IN scactualizadorvt.tatrncrcb.fipaisid%TYPE,
        pa_canal         IN scactualizadorvt.tatrncrcb.ficanal%TYPE,
        pa_sucursal      IN scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_tranno        IN scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_trantipo      IN scactualizadorvt.tatrncrcb.fitrantipo%TYPE,
        pa_consecutivo   IN scactualizadorvt.tatrncrcb.ficonsectipo%TYPE,
        pa_transfechr    IN VARCHAR2,
        pa_tranws        IN scactualizadorvt.tatrncrcb.fctranws%TYPE,
        pa_tranusr       IN scactualizadorvt.tatrncrcb.fctranusr%TYPE,
        pa_trannoreg     IN scactualizadorvt.tatrncrcb.fitrannoreg%TYPE,
        pa_dettran       IN scactualizadorvt.tbtrancredet);
END padistribuciontransac;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADISTRIBUCIONTRANSAC" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADISTRIBUCIONTRANSAC" TO "USRINFFENIX";
