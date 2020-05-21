--------------------------------------------------------
--  DDL for Package Body PAMONITOREO0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAMONITOREO0001" AS

    csg_tipoaplicacion   scactualizadorvt.tactrlerrores.fitipoaplicacion%TYPE := 78000; -- Identificador de error. para el modulo de transacciones.
    csl_0 constant integer :=0;
    PROCEDURE spgettotpagsucbloq (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) AS

        vl_stsadn           NUMBER(1) := 0; -- Status para Error
        vl_regxpag          NUMBER(2) := 20; -- registros por pagina 
        vl_totalregistros   NUMBER(10) := 0;-- total de registros
    BEGIN
        SELECT
            COUNT(a.rowid)
        INTO vl_totalregistros
        FROM
            scactualizadorvt.tactrlsuc a
            LEFT OUTER JOIN (
                SELECT
                    fipaisid,
                    ficanal,
                    fisucursal,
                    fitranno,
                    fitrantipo,
                    ficonsectipo,
                    TO_CHAR(fdtransfechr,'YYYY-MM-DD HH24:MI:SS') AS fdtransfechr,
                    fctranws,
                    fctranusr,
                    fitrannoreg
                FROM
                    scactualizadorvt.tatrncrcbe
                where ORA_ERR_ROWID is not null
                GROUP BY
                    fipaisid,
                    ficanal,
                    fisucursal,
                    fitranno,
                    fitrantipo,
                    ficonsectipo,
                    TO_CHAR(fdtransfechr,'YYYY-MM-DD HH24:MI:SS'),
                    fctranws,
                    fctranusr,
                    fitrannoreg
                ORDER BY
                    fipaisid,
                    ficanal,
                    fisucursal
            ) b ON a.fipaisid = b.fipaisid
                   AND a.ficanal = b.ficanal
                   AND a.fisucursal = b.fisucursal
                   AND a.fitranno = b.fitranno
        WHERE
            a.fistatadn = vl_stsadn and
            a.FIPAISID > csl_0 and
            a.FICANAL > csl_0 and 
            a.FISUCURSAL > csl_0;

        pa_totalpaginas := ceil(vl_totalregistros / vl_regxpag);
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            pa_totalpaginas := 0;
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spgettotpagsucbloq;

    PROCEDURE spgetsucbloq (
        pa_numeropag        IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) AS

        vl_stsadn         NUMBER(1) := 0; -- Status para Error 
        vl_paginauno      NUMBER(1) := 1; -- pagina uno  
        vl_regini         NUMBER(10) := 0; -- pagina inicial
        vl_regfin         NUMBER(10) := 0; -- pagina final
        vl_maxregpagina   NUMBER(2) := 20; -- maximo de registros x pagina
    BEGIN
        IF
            pa_numeropag = vl_paginauno
        THEN
            vl_regini := 1;
            vl_regfin := vl_maxregpagina;
        ELSE
            vl_regini := ( ( pa_numeropag - 1 ) * vl_maxregpagina ) + 1;
            vl_regfin := ( vl_regini + vl_maxregpagina ) - 1;
        END IF;

        OPEN pa_datos FOR SELECT
            c.pais "PAIS-BLOQUEADO",
            c.canal "CANAL-BLOQUEADO",
            c.suc "SUCURSAL-BLOQUEADA",
            c.stsadn "STATUS-ADN",
            c.ststda "STATUS-TIENDA",
            c.ulttrans "ULTIMA-TRANSACCION",
            c.fechaulttrans "FECHA-ULTIMA-TRANSACCION",
            c.fdultactcen "FECHA-DE-BLOQUEO",
            c.pais2 "PAIS-DE-BLOQUEO",
            c.canal2 "CANAL-DE-BLOQUEO",
            c.suc2 "SUCURSAL-DE-BLOQUEO",
            c.tranno "TRANSACCION-DE-BLOQUEO",
            c.trantipo "TIPO-TRANSACCION-DE-BLOQUEO",
            c.consectipo "CONSECUTIVO-TRANNO-DE-BLOQUEO",
            c.fdtransfechr "FECHA-TRANSACCION-DE-BLOQUEO",
            c.fctranws "ESTACION-DE-TRABAJO",
            c.fctranusr "EMPLEADO",
            c.fitrannoreg "REGISTRO-EN-TRANNO-DE-BLOQUEO",
            c.idrow AS idrow --EL ROWID ESTA EN RAW
                          FROM
            (
                SELECT
                    ROWNUM AS idcolumn,
                    a.fipaisid AS pais,
                    a.ficanal AS canal,
                    a.fisucursal AS suc,
                    a.fistatadn AS stsadn,
                    a.fistatustda AS ststda,
                    a.fiulttrans AS ulttrans,
                    TO_CHAR(a.fdulttrans,'YYYY-MM-DD HH24:MI:SS') AS fechaulttrans,
                    TO_CHAR(a.fdultactcen,'YYYY-MM-DD HH24:MI:SS') AS fdultactcen,
                    b.fipaisid AS pais2,
                    b.ficanal AS canal2,
                    b.fisucursal AS suc2,
                    b.fitranno AS tranno,
                    b.fitrantipo AS trantipo,
                    b.ficonsectipo AS consectipo,
                    b.fdtransfechr AS fdtransfechr,
                    b.fctranws AS fctranws,
                    b.fctranusr AS fctranusr,
                    b.fitrannoreg AS fitrannoreg,
                    rowidtochar(a.rowid) AS idrow
                FROM
                    scactualizadorvt.tactrlsuc a
                    LEFT OUTER JOIN (
                        SELECT
                            fipaisid,
                            ficanal,
                            fisucursal,
                            fitranno,
                            fitrantipo,
                            ficonsectipo,
                            TO_CHAR(fdtransfechr,'YYYY-MM-DD HH24:MI:SS') AS fdtransfechr,
                            fctranws,
                            fctranusr,
                            fitrannoreg
                        FROM
                            scactualizadorvt.tatrncrcbe
                        where ORA_ERR_ROWID is not null
                        GROUP BY
                            fipaisid,
                            ficanal,
                            fisucursal,
                            fitranno,
                            fitrantipo,
                            ficonsectipo,
                            TO_CHAR(fdtransfechr,'YYYY-MM-DD HH24:MI:SS'),
                            fctranws,
                            fctranusr,
                            fitrannoreg
                        ORDER BY
                            fipaisid,
                            ficanal,
                            fisucursal
                    ) b ON a.fipaisid = b.fipaisid
                           AND a.ficanal = b.ficanal
                           AND a.fisucursal = b.fisucursal
                           AND a.fitranno = b.fitranno
                WHERE
                    a.fistatadn = vl_stsadn and
            a.FIPAISID > csl_0 and
            a.FICANAL > csl_0 and 
            a.FISUCURSAL > csl_0
            ) c
                          WHERE
            c.idcolumn BETWEEN vl_regini AND vl_regfin
        ORDER BY
            c.pais,
            c.canal,
            c.suc;

        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            OPEN pa_datos FOR SELECT
                NULL "PAIS-BLOQUEADO",
                NULL "CANAL-BLOQUEADO",
                NULL "SUCURSAL-BLOQUEADA",
                NULL "STATUS-ADN",
                NULL "STATUS-TIENDA",
                NULL "ULTIMA-TRANSACCION",
                NULL "FECHA-ULTIMA TRANSACCION",
                NULL "FECHA-DE BLOQUEO",
                NULL "PAIS-DE-BLOQUEO",
                NULL "CANAL-DE-BLOQUEO",
                NULL "SUCURSAL-DE-BLOQUEO",
                NULL "TRANSACCION-DE-BLOQUEO",
                NULL "TIPO-TRANSACCION-DE-BLOQUEO",
                NULL "CONSECUTIVO-TRANNO-DE-BLOQUEO",
                NULL "FECHA-TRANSACCION-DE-BLOQUEO",
                NULL "ESTACION-DE-TRABAJO",
                NULL "EMPLEADO",
                NULL "REGISTRO-EN-TRANNO-DE-BLOQUEO",
                NULL idrow
                              FROM
                dual;

            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al realizar la consulta';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spgetsucbloq;

    PROCEDURE spdesbloquesuc (
        pa_erridrow         IN VARCHAR2,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    ) AS

        vl_stsadn      NUMBER(1) := 1; -- Status para ADN 
        vl_ststda      NUMBER(1) := 1; -- Status para Tienda 
        vl_cero        NUMBER(1) := 0; -- Constante con Valor Cero para Comparaci�n 
        vl_uno         NUMBER(1) := 1; -- Constante con Valor Uno para Comparaci�n
        vl_pais        scactualizadorvt.tactrlsuc.fipaisid%TYPE := 0;
        vl_canal       scactualizadorvt.tactrlsuc.ficanal%TYPE := 0;
        vl_suc         scactualizadorvt.tactrlsuc.fisucursal%TYPE := 0;
        vl_trannoerr   scactualizadorvt.tactrlsuc.fisucursal%TYPE := 0;
        vl_rowid       ROWID;    --Variable que contiene el ROWID en tipo caracter
    BEGIN
        vl_rowid := chartorowid(pa_erridrow);
        SELECT
            fipaisid,
            ficanal,
            fisucursal,
            fitranno
        INTO
            vl_pais,
            vl_canal,
            vl_suc,
            vl_trannoerr
        FROM
            scactualizadorvt.tactrlsuc
        WHERE
            ROWID = vl_rowid;

        UPDATE scactualizadorvt.tactrlsuc
        SET
            fistatadn = vl_stsadn,
            fistatustda = vl_ststda,
            fiulttrans = vl_cero,
            fitranno = vl_cero
        WHERE
            ROWID = vl_rowid;

        UPDATE scactualizadorvt.tactrltiptrans
        SET
            ficonsectipo = vl_cero
        WHERE
            fipaisid = vl_pais
            AND ficanal = vl_canal
            AND fisucursal = vl_suc;

        UPDATE scactualizadorvt.tatrncrcbe
        SET
            fists_errsol = vl_uno,
            fdfecha_errsol = SYSDATE
        WHERE
            fipaisid = vl_pais
            AND ficanal = vl_canal
            AND fisucursal = vl_suc
            AND fitranno = vl_trannoerr;

        COMMIT;
        pa_codigo := 0;
        pa_mensaje := 'OK';
        pa_detallemensaje := NULL;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            scactualizadorvt.pautil.spictrlerrores(csg_tipoaplicacion,'SCACTUALIZADORVT.pamonitoreo0001.SPDESBLOQUESUC',sqlcode,sqlerrm,'Hubo problema al desbloquear la sucursal: '
);
            pa_codigo := 1;
            pa_mensaje := 'Ocurri� un error al desbloquear la sucursal';
            pa_detallemensaje := dbms_utility.format_error_backtrace ();
    END spdesbloquesuc;

END pamonitoreo0001;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0001" TO "USRACTVT";
