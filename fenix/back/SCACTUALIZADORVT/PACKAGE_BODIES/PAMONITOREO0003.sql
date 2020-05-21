--------------------------------------------------------
--  DDL for Package Body PAMONITOREO0003
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAMONITOREO0003" AS

    csg_cero      NUMBER(1) := 0;  -- Valor de CERO para Asignaciones y comparaciones 
    csg_uno       NUMBER(1) := 1;  -- Valor de UNO  para Asignaciones y comparaciones 
    csg_dos       NUMBER(1) := 2;  -- Valor de DOS  para Asignaciones y comparaciones 
    csg_regxpag   NUMBER(2) := 25; -- Indica Total de Registros por P�gina a leer

    procedure spobtienetotalpagina_head (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) as
        vl_totalregistros   NUMBER(10) := 0; -- almacena el total de registros a mostrar.
    BEGIN
            SELECT
                COUNT(ROWID)
            INTO vl_totalregistros
            FROM
                scactualizadorvt.tatrncrcbe
            WHERE
                fists_errsol = csg_cero;

        pa_totalpaginas := ceil(vl_totalregistros / csg_regxpag);
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            pa_totalpaginas := 0;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spobtienetotalpagina_head;

    procedure spobtienetotalpagina_det (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) as
        vl_totalregistros   NUMBER(10) := 0; -- almacena el total de registros a mostrar.
    BEGIN
            SELECT
                COUNT(ROWID)
            INTO vl_totalregistros
            FROM
                scactualizadorvt.tatrncrdte
            WHERE
                fists_errsol = csg_cero;

        pa_totalpaginas := ceil(vl_totalregistros / csg_regxpag);
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            pa_totalpaginas := 0;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spobtienetotalpagina_det;

    procedure spobtieneerror_transac_head (
        pa_numpagina   IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) as
        vl_regini   NUMBER(5) := 0;  -- almacena registros inicial  de la pagina n 
        vl_regfin   NUMBER(5) := 0;  -- almacena registros final de la pagina n 
    BEGIN
        IF -- Si es la Primer P�gina a Mostrar, Mostrar� los Primeros 25 Registros
            pa_numpagina = csg_uno
        THEN
            vl_regini := csg_uno;
            vl_regfin := csg_regxpag;
        ELSE -- De ser P�gina 2 � m�s, toma la siguiente p�gina con los siguientes 25 Registros
            vl_regini := ( ( pa_numpagina - csg_uno ) * csg_regxpag ) + csg_uno;
            vl_regfin := ( vl_regini + csg_regxpag ) - csg_uno;
        END IF;

            OPEN pa_datos FOR SELECT
                fipaisid,
                ficanal,
                fisucursal,
                fitranno,
                fitrantipo,
                ficonsectipo,
                fecha,
                fctranws,
                fctranusr,
                fitrannoreg,
                fitransmit
                              FROM
                (
                    SELECT
                        ROWNUM AS idcolum,
                        fipaisid,
                        ficanal,
                        fisucursal,
                        fitranno,
                        fitrantipo,
                        ficonsectipo,
                        fecha,
                        fctranws,
                        fctranusr,
                        fitrannoreg,
                        fitransmit
                    FROM
                        (
                            SELECT
                                fipaisid,
                                ficanal,
                                fisucursal,
                                fitranno,
                                fitrantipo,
                                ficonsectipo,
                                TO_CHAR(fdtransfechr,'YYYY-MM-DD') AS fecha,
                                fctranws,
                                fctranusr,
                                fitrannoreg,
                                fitransmit
                            FROM
                                scactualizadorvt.tatrncrcbe
                            WHERE
                                fists_errsol = csg_cero
                            ORDER BY
                                fisucursal,
                                fitranno
                        )
                )
                              WHERE
                idcolum BETWEEN vl_regini AND vl_regfin;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN

            OPEN pa_datos FOR SELECT
                null fipaisid,
                null ficanal,
                null fisucursal,
                null fitranno,
                null fitrantipo,
                null ficonsectipo,
                null fecha,
                null fctranws,
                null fctranusr,
                null fitrannoreg,
                null fitransmit
                              FROM
                dual;
                pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace (); 
    END spobtieneerror_transac_head;

    procedure spobtieneerror_transac_det (
        pa_numpagina   IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) as
        vl_regini   NUMBER(5) := 0;  -- almacena registros inicial  de la pagina n 
        vl_regfin   NUMBER(5) := 0;  -- almacena registros final de la pagina n 
    BEGIN
        IF -- Si es la Primer P�gina a Mostrar, Mostrar� los Primeros 25 Registros
            pa_numpagina = csg_uno
        THEN
            vl_regini := csg_uno;
            vl_regfin := csg_regxpag;
        ELSE -- De ser P�gina 2 � m�s, toma la siguiente p�gina con los siguientes 25 Registros
            vl_regini := ( ( pa_numpagina - csg_uno ) * csg_regxpag ) + csg_uno;
            vl_regfin := ( vl_regini + csg_regxpag ) - csg_uno;
        END IF;
            OPEN pa_datos FOR SELECT
                fipaisid,
                ficanal,
                fisucursal,
                fitranno,
                ficonsdeta,
                fitiporeg,
                fcdatodeta
                              FROM
                (
                    SELECT
                        ROWNUM AS idcolum,
                        fipaisid,
                        ficanal,
                        fisucursal,
                        fitranno,
                        ficonsdeta,
                        fitiporeg,
                        fcdatodeta
                    FROM
                        (
                            SELECT
                                fipaisid,
                                ficanal,
                                fisucursal,
                                fitranno,
                                ficonsdeta,
                                fitiporeg,
                                fcdatodeta
                            FROM
                                scactualizadorvt.tatrncrdte
                            WHERE
                                fists_errsol = csg_cero
                            ORDER BY
                                fisucursal,
                                fitranno
                        )
                )
                              WHERE
                idcolum BETWEEN vl_regini AND vl_regfin;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN

            OPEN pa_datos FOR SELECT
                null fipaisid,
                null ficanal,
                null fisucursal,
                null fitranno,
                null ficonsdeta,
                null fitiporeg,
                null fcdatodeta
                              FROM
                dual;
        pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spobtieneerror_transac_det;

    PROCEDURE spdepuraerror_transac_head (
        pa_pais       IN scactualizadorvt.tatrncrcbe.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrcbe.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrcbe.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrcbe.fitranno%TYPE,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    )
        IS
    BEGIN

   --Actualiza el status = 1 y Fecha de Soluci�n de Error 
        UPDATE scactualizadorvt.tatrncrcbe
        SET
            fists_errsol = csg_uno,
            fdfecha_errsol = SYSDATE
        WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al depurar error cabecero transacci�n';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spdepuraerror_transac_head;

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
    )
        IS
    BEGIN
   --Actualiza el status = 1  y Fecha de soluci�n de Error 
        UPDATE scactualizadorvt.tatrncrdte
        SET
            fists_errsol = csg_uno,
            fdfecha_errsol = SYSDATE
        WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno
            AND ficonsdeta = pa_condet
            AND fitiporeg = pa_tiporeg;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al depurar error detalle transacci�n';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spdepuraerror_transac_det;

END pamonitoreo0003;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0003" TO "USRACTVT";
