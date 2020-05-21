--------------------------------------------------------
--  DDL for Package Body PADISTRIBUCIONTRANSAC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PADISTRIBUCIONTRANSAC" 
AS
    csl_0        CONSTANT INTEGER := 0;
    csl_1        CONSTANT INTEGER := 1;
    csl_mexico   CONSTANT NUMBER (1) := 1;                      -- Pais Mexico
    csl_canal1   CONSTANT NUMBER (1) := 1;                    -- Canal Elektra
    csl_canal2   CONSTANT NUMBER (1) := 2;          -- Canal Bodega de Remates
    csl_canal3   CONSTANT NUMBER (1) := 3;            -- Canal Salinas y Rocha
    csl_canal9   CONSTANT NUMBER (1) := 9;

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
        pa_trannoreg     IN scactualizadorvt.tatrncrcb.fitrannoreg%TYPE)
    IS
    BEGIN
        IF (    pa_pais = csl_mexico
            AND pa_canal IN (csl_canal1,
                             csl_canal2,
                             csl_canal3,
                             csl_canal9))
        THEN
            INSERT INTO scactualizadorvt.tatrncrcb (fipaisid,
                                                    ficanal,
                                                    fisucursal,
                                                    fitranno,
                                                    fitrantipo,
                                                    ficonsectipo,
                                                    fdtransfechr,
                                                    fctranws,
                                                    fctranusr,
                                                    fitrannoreg,
                                                    fitransmit)
                 VALUES (pa_pais,
                         pa_canal,
                         pa_sucursal,
                         pa_tranno,
                         pa_trantipo,
                         pa_consecutivo,
                         TO_DATE (pa_transfechr, 'YYYY-MM-DD HH24:MI:SS'),
                         pa_tranws,
                         pa_tranusr,
                         pa_trannoreg,
                         csl_0);
        END IF;
    END spicabtran;

    PROCEDURE spidettran (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_consdet    IN scactualizadorvt.tatrncrdt.ficonsdeta%TYPE,
        pa_tiporeg    IN scactualizadorvt.tatrncrdt.fitiporeg%TYPE,
        pa_datodet    IN scactualizadorvt.tatrncrdt.fcdatodeta%TYPE)
    IS
    BEGIN
        IF (    pa_pais = csl_mexico
            AND pa_canal IN (csl_canal1,
                             csl_canal2,
                             csl_canal3,
                             csl_canal9))
        THEN
            INSERT INTO scactualizadorvt.tatrncrdt (fipaisid,
                                                    ficanal,
                                                    fisucursal,
                                                    fitranno,
                                                    ficonsdeta,
                                                    fitiporeg,
                                                    fcdatodeta)
                 VALUES (pa_pais,
                         pa_canal,
                         pa_sucursal,
                         pa_tranno,
                         pa_consdet,
                         pa_tiporeg,
                         pa_datodet);
        END IF;
    END spidettran;

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
        pa_trannoreg     IN scactualizadorvt.tatrncrcbe.fitrannoreg%TYPE)
    IS
    BEGIN
        INSERT INTO scactualizadorvt.tatrncrcbe (fipaisid,
                                                 ficanal,
                                                 fisucursal,
                                                 fitranno,
                                                 fitrantipo,
                                                 ficonsectipo,
                                                 fdtransfechr,
                                                 fctranws,
                                                 fctranusr,
                                                 fitrannoreg,
                                                 fitransmit,
                                                 fists_errsol,
                                                 fdfecha_errsol,
                                                 fdfecharecep)
             VALUES (pa_pais,
                     pa_canal,
                     pa_sucursal,
                     pa_tranno,
                     pa_trantipo,
                     pa_consecutivo,
                     TO_DATE (pa_transfechr, 'YYYY-MM-DD HH24:MI:SS'),
                     pa_tranws,
                     pa_tranusr,
                     pa_trannoreg,
                     csl_0,
                     csl_0,
                     TO_DATE ('1901-01-01', 'YYYY-MM-DD'),
                     SYSDATE);
    END spicabtranerror;

    PROCEDURE spidettranerror (
        pa_pais       IN scactualizadorvt.tatrncrdte.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdte.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdte.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdte.fitranno%TYPE,
        pa_consdet    IN scactualizadorvt.tatrncrdte.ficonsdeta%TYPE,
        pa_tiporeg    IN scactualizadorvt.tatrncrdte.fitiporeg%TYPE,
        pa_datodet    IN scactualizadorvt.tatrncrdte.fcdatodeta%TYPE)
    IS
    BEGIN
        INSERT INTO scactualizadorvt.tatrncrdte (fipaisid,
                                                 ficanal,
                                                 fisucursal,
                                                 fitranno,
                                                 ficonsdeta,
                                                 fitiporeg,
                                                 fcdatodeta)
             VALUES (pa_pais,
                     pa_canal,
                     pa_sucursal,
                     pa_tranno,
                     pa_consdet,
                     pa_tiporeg,
                     pa_datodet);
    END spidettranerror;

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
        pa_dettran       IN scactualizadorvt.tbtrancredet)
    IS
    BEGIN
        IF (    pa_pais = csl_mexico
            AND pa_canal IN (csl_canal1,
                             csl_canal2,
                             csl_canal3,
                             csl_canal9))
        THEN
            INSERT INTO scactualizadorvt.tatrncrcb (fipaisid,
                                                    ficanal,
                                                    fisucursal,
                                                    fitranno,
                                                    fitrantipo,
                                                    ficonsectipo,
                                                    fdtransfechr,
                                                    fctranws,
                                                    fctranusr,
                                                    fitrannoreg,
                                                    fitransmit)
                 VALUES (pa_pais,
                         pa_canal,
                         pa_sucursal,
                         pa_tranno,
                         pa_trantipo,
                         pa_consecutivo,
                         TO_DATE (pa_transfechr, 'YYYY-MM-DD HH24:MI:SS'),
                         pa_tranws,
                         pa_tranusr,
                         pa_trannoreg,
                         csl_0);

            FOR i IN csl_1 ..
                     NVL (pa_dettran, scactualizadorvt.tbtrancredet ()).COUNT
            LOOP
                INSERT INTO scactualizadorvt.tatrncrdt (fipaisid,
                                                        ficanal,
                                                        fisucursal,
                                                        fitranno,
                                                        ficonsdeta,
                                                        fitiporeg,
                                                        fcdatodeta)
                     VALUES (pa_pais,
                             pa_canal,
                             pa_sucursal,
                             pa_tranno,
                             pa_dettran (i).ficonsdeta,
                             pa_dettran (i).fitiporeg,
                             pa_dettran (i).fcdatodeta);
            END LOOP;

            COMMIT;
        END IF;
    END spinsertaregistro;

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
        pa_dettran       IN scactualizadorvt.tbtrancredet)
    IS
    BEGIN
        IF (    pa_pais = csl_mexico
            AND pa_canal IN (csl_canal1,
                             csl_canal2,
                             csl_canal3,
                             csl_canal9))
        THEN
            INSERT INTO scactualizadorvt.tatrncrcbe (fipaisid,
                                                     ficanal,
                                                     fisucursal,
                                                     fitranno,
                                                     fitrantipo,
                                                     ficonsectipo,
                                                     fdtransfechr,
                                                     fctranws,
                                                     fctranusr,
                                                     fitrannoreg,
                                                     fitransmit)
                 VALUES (pa_pais,
                         pa_canal,
                         pa_sucursal,
                         pa_tranno,
                         pa_trantipo,
                         pa_consecutivo,
                         TO_DATE (pa_transfechr, 'YYYY-MM-DD HH24:MI:SS'),
                         pa_tranws,
                         pa_tranusr,
                         pa_trannoreg,
                         csl_0);

            FOR i IN 1 ..
                     NVL (pa_dettran, scactualizadorvt.tbtrancredet ()).COUNT
            LOOP
                INSERT INTO scactualizadorvt.tatrncrdte (fipaisid,
                                                         ficanal,
                                                         fisucursal,
                                                         fitranno,
                                                         ficonsdeta,
                                                         fitiporeg,
                                                         fcdatodeta)
                     VALUES (pa_pais,
                             pa_canal,
                             pa_sucursal,
                             pa_tranno,
                             pa_dettran (i).ficonsdeta,
                             pa_dettran (i).fitiporeg,
                             pa_dettran (i).fcdatodeta);
            END LOOP;

            COMMIT;
        END IF;
    END spinsertaregistroerror;
END padistribuciontransac;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADISTRIBUCIONTRANSAC" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADISTRIBUCIONTRANSAC" TO "USRINFFENIX";
