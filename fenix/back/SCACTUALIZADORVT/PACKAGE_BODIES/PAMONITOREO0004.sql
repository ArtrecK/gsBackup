--------------------------------------------------------
--  DDL for Package Body PAMONITOREO0004
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAMONITOREO0004" 
AS
    csl_0   CONSTANT INTEGER := 0;

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
        pa_detallemensaje       OUT VARCHAR2)
    AS
        vl_totalregistros   NUMBER (10) := 0; -- almacena el total de registros
        csg_regxpag         NUMBER (5) := 20; -- NUMERO DE REGISTROS POR PAGINA
        vl_pais_ini         scactualizadorvt.tatrncrcb.fipaisid%TYPE;
        vl_pais_fin         scactualizadorvt.tatrncrcb.fipaisid%TYPE;
        vl_canal_ini        scactualizadorvt.tatrncrcb.ficanal%TYPE;
        vl_canal_fin        scactualizadorvt.tatrncrcb.ficanal%TYPE;
        vl_sucursal_ini     scactualizadorvt.tatrncrcb.fisucursal%TYPE;
        vl_sucursal_fin     scactualizadorvt.tatrncrcb.fisucursal%TYPE;
        vl_tipotran_ini     scactualizadorvt.tatrncrcb.fitrantipo%TYPE;
        vl_tipotran_fin     scactualizadorvt.tatrncrcb.fitrantipo%TYPE;
        vl_fecha_ini        DATE;
        vl_fecha_fin        DATE;
    BEGIN
        IF pa_pais IS NULL
        THEN
            vl_pais_ini := 0;
            vl_pais_fin := 99999;
        ELSE
            vl_pais_ini := pa_pais;
            vl_pais_fin := pa_pais;
        END IF;

        IF pa_canal IS NULL
        THEN
            vl_canal_ini := 0;
            vl_canal_fin := 99999;
        ELSE
            vl_canal_ini := pa_canal;
            vl_canal_fin := pa_canal;
        END IF;

        IF pa_sucursal IS NULL
        THEN
            vl_sucursal_ini := 0;
            vl_sucursal_fin := 9999999999;
        ELSE
            vl_sucursal_ini := pa_sucursal;
            vl_sucursal_fin := pa_sucursal;
        END IF;

        IF pa_tipotran IS NULL
        THEN
            vl_tipotran_ini := 0;
            vl_tipotran_fin := 99999;
        ELSE
            vl_tipotran_ini := pa_tipotran;
            vl_tipotran_fin := pa_tipotran;
        END IF;

        IF pa_fechainiciotran IS NOT NULL AND pa_fechafintran IS NOT NULL
        THEN
            vl_fecha_ini := TO_DATE (pa_fechainiciotran, 'DD/MM/YYYY');
            vl_fecha_fin := TO_DATE (pa_fechafintran, 'DD/MM/YYYY');
        ELSE
            vl_fecha_ini := TO_DATE ('01/01/1901', 'DD/MM/YYYY');
            vl_fecha_fin := SYSDATE;
        END IF;

        SELECT COUNT (ROWID)
          INTO vl_totalregistros
          FROM scactualizadorvt.tatrncrcb
         WHERE     fipaisid BETWEEN vl_pais_ini AND vl_pais_fin
               AND ficanal BETWEEN vl_canal_ini AND vl_canal_fin
               AND fisucursal BETWEEN vl_sucursal_ini AND vl_sucursal_fin
               AND fitrantipo BETWEEN vl_tipotran_ini AND vl_tipotran_fin
               AND TRUNC (fdtransfechr) BETWEEN TRUNC (vl_fecha_ini)
                                            AND TRUNC (vl_fecha_fin);

        pa_totalpaginas := CEIL (vl_totalregistros / csg_regxpag);
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_totalpaginas := 0;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje :=
                   SQLCODE
                || '-'
                || SQLERRM
                || '-'
                || DBMS_UTILITY.format_error_backtrace ();
    END spobtienetotcabe;

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
        pa_detallemensaje       OUT VARCHAR2)
    AS
        csl_paginauno      NUMBER (1) := 1; -- identifica la pagina numero uno.
        csl_maxregpagina   NUMBER (2) := 20; -- numero de registros maximos por pagina
        vl_regini          NUMBER (5) := 0; -- almacena registros inicial de la pagina n
        vl_regfin          NUMBER (5) := 0; -- almacena registros final de la pagina n
        vl_pais_ini        scactualizadorvt.tatrncrcb.fipaisid%TYPE;
        vl_pais_fin        scactualizadorvt.tatrncrcb.fipaisid%TYPE;
        vl_canal_ini       scactualizadorvt.tatrncrcb.ficanal%TYPE;
        vl_canal_fin       scactualizadorvt.tatrncrcb.ficanal%TYPE;
        vl_sucursal_ini    scactualizadorvt.tatrncrcb.fisucursal%TYPE;
        vl_sucursal_fin    scactualizadorvt.tatrncrcb.fisucursal%TYPE;
        vl_tipotran_ini    scactualizadorvt.tatrncrcb.fitrantipo%TYPE;
        vl_tipotran_fin    scactualizadorvt.tatrncrcb.fitrantipo%TYPE;
        vl_fecha_ini       DATE;
        vl_fecha_fin       DATE;
    BEGIN
        IF pa_pais IS NULL
        THEN
            vl_pais_ini := 0;
            vl_pais_fin := 99999;
        ELSE
            vl_pais_ini := pa_pais;
            vl_pais_fin := pa_pais;
        END IF;

        IF pa_canal IS NULL
        THEN
            vl_canal_ini := 0;
            vl_canal_fin := 99999;
        ELSE
            vl_canal_ini := pa_canal;
            vl_canal_fin := pa_canal;
        END IF;

        IF pa_sucursal IS NULL
        THEN
            vl_sucursal_ini := 0;
            vl_sucursal_fin := 9999999999;
        ELSE
            vl_sucursal_ini := pa_sucursal;
            vl_sucursal_fin := pa_sucursal;
        END IF;

        IF pa_tipotran IS NULL
        THEN
            vl_tipotran_ini := 0;
            vl_tipotran_fin := 99999;
        ELSE
            vl_tipotran_ini := pa_tipotran;
            vl_tipotran_fin := pa_tipotran;
        END IF;

        IF pa_fechainiciotran IS NOT NULL AND pa_fechafintran IS NOT NULL
        THEN
            vl_fecha_ini := TO_DATE (pa_fechainiciotran, 'DD/MM/YYYY');
            vl_fecha_fin := TO_DATE (pa_fechafintran, 'DD/MM/YYYY');
        ELSE
            vl_fecha_ini := TO_DATE ('01/01/1901', 'DD/MM/YYYY');
            vl_fecha_fin := SYSDATE;
        END IF;

        IF pa_numpagina = csl_paginauno
        THEN
            vl_regini := 1;
            vl_regfin := csl_maxregpagina;
        ELSE
            vl_regini := ((pa_numpagina - 1) * csl_maxregpagina) + 1;
            vl_regfin := (pa_numpagina * csl_maxregpagina) + 1;
        END IF;

        OPEN pa_datos FOR
            SELECT fitranno,
                   fitrantipo,
                   fisucursal,
                   fdtransfechr,
                   fipaisid,
                   fctranws,
                   ficanal,
                   fctranusr,
                   fitrannoreg,
                   fitransmit,
                   ficonsectipo
              FROM (SELECT fitranno,
                           fitrantipo,
                           fisucursal,
                           fdtransfechr,
                           fipaisid,
                           fctranws,
                           ficanal,
                           fctranusr,
                           fitrannoreg,
                           fitransmit,
                           ficonsectipo,
                           ROWNUM idcolumn
                      FROM (  SELECT fitranno,
                                     fitrantipo,
                                     fisucursal,
                                     fdtransfechr,
                                     fipaisid,
                                     fctranws,
                                     ficanal,
                                     fctranusr,
                                     fitrannoreg,
                                     fitransmit,
                                     ficonsectipo
                                FROM scactualizadorvt.tatrncrcb
                               WHERE     fipaisid BETWEEN vl_pais_ini
                                                      AND vl_pais_fin
                                     AND ficanal BETWEEN vl_canal_ini
                                                     AND vl_canal_fin
                                     AND fisucursal BETWEEN vl_sucursal_ini
                                                        AND vl_sucursal_fin
                                     AND fitrantipo BETWEEN vl_tipotran_ini
                                                        AND vl_tipotran_fin
                                     AND TRUNC (fdtransfechr) BETWEEN TRUNC (
                                                                          vl_fecha_ini)
                                                                  AND TRUNC (
                                                                          vl_fecha_fin)
                            ORDER BY fipaisid,
                                     ficanal,
                                     fisucursal,
                                     fitranno) s1) s2
             WHERE idcolumn BETWEEN vl_regini AND vl_regfin;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_datos FOR SELECT NULL fitranno,
                                     NULL fitrantipo,
                                     NULL fisucursal,
                                     NULL fdtransfechr,
                                     NULL fipaisid,
                                     NULL fctranws,
                                     NULL ficanal,
                                     NULL fctranusr,
                                     NULL fitrannoreg,
                                     NULL fitransmit,
                                     NULL ficonsectipo
                                FROM DUAL;

            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spobtienecabe;

    PROCEDURE spobtienepais (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_datos FOR
              SELECT fipaisid, COUNT (ROWID) contador
                FROM scactualizadorvt.tactrlsuc
               WHERE     FIPAISID > csl_0
                     AND FICANAL > csl_0
                     AND FISUCURSAL > csl_0
            GROUP BY fipaisid
            ORDER BY fipaisid ASC;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_datos FOR SELECT NULL fipaisid, NULL contador
                                FROM DUAL;

            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spobtienepais;

    PROCEDURE spobtienecanal (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_datos FOR
              SELECT ficanal, COUNT (ROWID) contador
                FROM scactualizadorvt.tactrlsuc
               WHERE     FIPAISID > csl_0
                     AND FICANAL > csl_0
                     AND FISUCURSAL > csl_0
            GROUP BY ficanal
            ORDER BY ficanal ASC;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_datos FOR SELECT NULL ficanal, NULL contador
                                FROM DUAL;

            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spobtienecanal;

    PROCEDURE spobtienesuc (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_datos FOR
              SELECT fisucursal, COUNT (ROWID) contador
                FROM scactualizadorvt.tactrlsuc
               WHERE     FIPAISID > csl_0
                     AND FICANAL > csl_0
                     AND FISUCURSAL > csl_0
            GROUP BY fisucursal
            ORDER BY fisucursal ASC;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_datos FOR SELECT NULL fisucursal, NULL contador
                                FROM DUAL;

            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spobtienesuc;

    PROCEDURE spobtienetransac (
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_datos FOR
              SELECT fitrantipo, COUNT (ROWID) contador
                FROM scactualizadorvt.tacattransaccion
               WHERE     FITRANTIPO > csl_0
                     AND FIPAISID > csl_0
                     AND FICANAL > csl_0
            GROUP BY fitrantipo
            ORDER BY fitrantipo ASC;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            OPEN pa_datos FOR SELECT NULL fitrantipo, NULL contador
                                FROM DUAL;

            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spobtienetransac;

    PROCEDURE spupdatetransaction (
        pa_pais             IN     scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal            IN     scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno           IN     scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal         IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_consectipo       IN     scactualizadorvt.tatrncrcb.ficonsectipo%TYPE,
        pa_trannoreg        IN     scactualizadorvt.tatrncrcb.fitrannoreg%TYPE,
        pa_codigo              OUT NUMBER,
        pa_mensaje             OUT VARCHAR2,
        pa_detallemensaje      OUT VARCHAR2)
    AS
    BEGIN
        --- Actualizaci�n de cabecero de la Transacci�n
        UPDATE scactualizadorvt.tatrncrcb
           SET ficonsectipo = pa_consectipo, fitrannoreg = pa_trannoreg
         WHERE     fipaisid = pa_pais
               AND ficanal = pa_canal
               AND fisucursal = pa_sucursal
               AND fitranno = pa_tranno;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un erros al actualizar el registro';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spupdatetransaction;

    PROCEDURE spomitirtransac (
        pa_pais             IN     scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal            IN     scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno           IN     scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal         IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_codigo              OUT NUMBER,
        pa_mensaje             OUT VARCHAR2,
        pa_detallemensaje      OUT VARCHAR2)
    AS
    BEGIN
        -- inserta en TATRNCRCBH la transaccion seleccionada del TATRNCRCB
        INSERT INTO scactualizadorvt.tatrncrcbh
            SELECT fipaisid,
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
                   fdfecharecep,
                   SYSDATE,
                   fdcreacion,
                   fdmodifico,
                   fcusrmodifico
              FROM scactualizadorvt.tatrncrcb
             WHERE     fipaisid = pa_pais
                   AND ficanal = pa_canal
                   AND fitranno = pa_tranno
                   AND fisucursal = pa_sucursal;

        -- inserta en TATRNCRDTH la transaccion seleccionada del TATRNCRDT

        INSERT INTO scactualizadorvt.tatrncrdth
            SELECT fipaisid,
                   ficanal,
                   fisucursal,
                   fitranno,
                   ficonsdeta,
                   fitiporeg,
                   fcdatodeta,
                   SYSDATE,
                   SYSDATE,
                   fdmodifico,
                   fcusrmodifico
              FROM scactualizadorvt.tatrncrdt
             WHERE     fipaisid = pa_pais
                   AND ficanal = pa_canal
                   AND fitranno = pa_tranno
                   AND fisucursal = pa_sucursal;

        -- Borra Cabecero

        DELETE FROM scactualizadorvt.tatrncrdt
              WHERE     fipaisid = pa_pais
                    AND ficanal = pa_canal
                    AND fisucursal = pa_sucursal
                    AND fitranno = pa_tranno;

        -- Borra Detalle

        DELETE FROM scactualizadorvt.tatrncrcb
              WHERE     fipaisid = pa_pais
                    AND ficanal = pa_canal
                    AND fisucursal = pa_sucursal
                    AND fitranno = pa_tranno;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un erros al omitir la transacci�n';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spomitirtransac;

    PROCEDURE spdeletetran (
        pa_pais             IN     scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal            IN     scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno           IN     scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal         IN     scactualizadorvt.tatrncrcb.fisucursal%TYPE,
        pa_codigo              OUT NUMBER,
        pa_mensaje             OUT VARCHAR2,
        pa_detallemensaje      OUT VARCHAR2)
    AS
    BEGIN
        -- Borra Cabecero
        DELETE FROM scactualizadorvt.tatrncrdt
              WHERE     fipaisid = pa_pais
                    AND ficanal = pa_canal
                    AND fisucursal = pa_sucursal
                    AND fitranno = pa_tranno;

        -- Borra Detalle

        DELETE FROM scactualizadorvt.tatrncrcb
              WHERE     fipaisid = pa_pais
                    AND ficanal = pa_canal
                    AND fisucursal = pa_sucursal
                    AND fitranno = pa_tranno;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un erros al eliminar la transacci�n';
            pa_detallemensaje := DBMS_UTILITY.format_error_backtrace ();
    END spdeletetran;
END pamonitoreo0004;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0004" TO "USRACTVT";
