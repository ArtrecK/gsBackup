--------------------------------------------------------
--  DDL for Package Body PAMONITOREO0005
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAMONITOREO0005" AS 

 --Constantes Globales 

    csg_cero             NUMBER(1) := 0;  -- Valor de CERO para Asignaciones y comparaciones 
    csg_uno              NUMBER(1) := 1;  -- Valor de UNO  para Asignaciones y comparaciones 
    csg_dos              NUMBER(1) := 2;  -- Valor de DOS  para Asignaciones y comparaciones 
    csg_regxpag          NUMBER(2) := 25; -- Indica Total de Registros por P�gina a leer
    csg_tipoaplicacion   scactualizadorvt.tactrlerrores.fitipoaplicacion%TYPE := 78000; -- Identificador de error. para el modulo de transacciones.

    FUNCTION fngetproctransac RETURN scactualizadorvt.pautil.rcg_tipocursor IS

        curlocal        scactualizadorvt.pautil.rcg_tipocursor;

   -- Constantes 
        csl_uno         NUMBER(1) := 1; -- Indica Solo Un Registro    
        csl_noproceso   NUMBER(1) := 0; -- Indica Transacciones Sin Procesar  
        csl_ranfec      NUMBER(3) := 150; -- Indica 150 D�as Anteriores a la Fecha del Sistema      
    BEGIN
        OPEN curlocal FOR SELECT
            TO_CHAR(fdtransfechr,'YYYY-MM-DD'),
            fitrantipo,
            COUNT(ROWID)
                          FROM
            scactualizadorvt.tatrncrcb
                          WHERE
            fdtransfechr >= SYSDATE - csl_ranfec
            AND fitransmit = csl_noproceso
                          GROUP BY
            TO_CHAR(fdtransfechr,'YYYY-MM-DD'),
            fitrantipo
        ORDER BY
            TO_CHAR(fdtransfechr,'YYYY-MM-DD') DESC;

        RETURN curlocal;
    END fngetproctransac;

    FUNCTION fngettotpagetactrlerrores RETURN NUMBER IS

   -- Constantes 

        csl_estatus         NUMBER(1) := 0; -- Status para Error
        csg_regxpag         NUMBER(2) := 20; -- registros por pagina 
        vl_totpagina        NUMBER(10) := 0;-- numero total de paginas
        vl_totalregistros   NUMBER(10) := 0;-- total de registros
    BEGIN
        SELECT
            COUNT(ROWID)
        INTO vl_totalregistros
        FROM
            scactualizadorvt.tactrlerrores
        WHERE
            fistatus = csl_estatus
        ORDER BY
            TO_CHAR(fdfechasurgio,'YYYY-MM-DD HH24:MI:SS') DESC;

        vl_totpagina := ceil(vl_totalregistros / csg_regxpag);
        RETURN vl_totpagina;
    END fngettotpagetactrlerrores;

    FUNCTION fngettactrlerrores (
        pa_numeropag IN NUMBER
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor IS

   -- Constantes 

        csl_estatus        NUMBER(1) := 0; -- Status para Error 
        curcursorsalida    scactualizadorvt.pautil.rcg_tipocursor;
        csl_distran        NUMBER(5) := 77000; -- Indica Distribuci�n de Transacciones      
        csl_conmon         NUMBER(5) := 81000; -- Indica Consultas de Monitoreo  
        csl_paginauno      NUMBER(1) := 1; -- pagina uno  
        vl_regini          NUMBER(10) := 0; -- pagina inicial
        vl_regfin          NUMBER(10) := 0; -- pagina final
        csl_maxregpagina   NUMBER(2) := 20; -- maximo de registros x pagina
    BEGIN
        IF
            pa_numeropag = csl_paginauno
        THEN
            vl_regini := 1;
            vl_regfin := csl_maxregpagina;
        ELSE
            vl_regini := ( ( pa_numeropag - 1 ) * csl_maxregpagina ) + 1;
            vl_regfin := ( vl_regini + csl_maxregpagina ) - 1;
        END IF;

        OPEN curcursorsalida FOR SELECT
            descapl "TIPO APLICACION SURGIO ",
            iderr "CONSECUTIVO",
            fechaerr "FECHA ",
            origenerr "ORIGEN",
            numerr "NUMERO ",
            msgerr "DESCRIPCION ",
            causaerr "CAUSA",
            utl_i18n.string_to_raw(b.idrow) AS idrow --EL ROWID ESTA EN RAW
                                 FROM
            (
                SELECT
                    ROWNUM AS idcolumn,
                    fitipoaplicacion "IDAPL",
                    CASE ( fitipoaplicacion )
                            WHEN csl_distran   THEN 'DISTRIBUCION TRANSACCCIONES'
                            WHEN csl_conmon    THEN 'CONSULTAS MONITOREO'
                            ELSE 'DESCONOCIDO'
                        END
                    "DESCAPL",
                    ficonsec "IDERR",
                    TO_CHAR(fdfechasurgio,'YYYY-MM-DD HH24:MI:SS') "FECHAERR",
                    fcorigino "ORIGENERR",
                    finumero "NUMERR",
                    fcmensaje "MSGERR",
                    fccausa "CAUSAERR",
                    rowidtochar(ROWID) AS idrow
                FROM
                    scactualizadorvt.tactrlerrores
                WHERE
                    fistatus = csl_estatus
                ORDER BY
                    TO_CHAR(fdfechasurgio,'YYYY-MM-DD HH24:MI:SS') DESC
            ) b
                                 WHERE
            b.idcolumn BETWEEN vl_regini AND vl_regfin;

        RETURN curcursorsalida;
    END fngettactrlerrores;

    PROCEDURE spdepuraerror_transac (
        pa_pais       IN scactualizadorvt.tatrncrcbe.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrcbe.ficanal%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrcbe.fisucursal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrcbe.fitranno%TYPE
    )
        IS
    BEGIN

   --Actualiza el status = 1 y Fecha de Soluci�n de Error en Cabecero 
        UPDATE scactualizadorvt.tatrncrcbe
        SET
            fists_errsol = csg_uno,
            fdfecha_errsol = SYSDATE
        WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno;
   --Actualiza el Status = 1 y Fecha de Soluci�n de Error en Detalle 

        UPDATE scactualizadorvt.tatrncrdte
        SET
            fists_errsol = csg_uno,
            fdfecha_errsol = SYSDATE
        WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno;

        COMMIT;
    exception when others then
        rollback;
    END spdepuraerror_transac;

    FUNCTION fngettrandeta (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor IS
        cursalida   scactualizadorvt.pautil.rcg_tipocursor;  -- Consulta de Transacciones de Tipo Cursor 
    BEGIN

   -- Cursor del Detalle de Transacciones 
        OPEN cursalida FOR SELECT
            ficonsdeta,
            fitranno,
            fisucursal,
            ficanal,
            fipaisid,
            fitiporeg,
            fcdatodeta
                           FROM
            scactualizadorvt.tatrncrdt
                           WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno;

   -- Regresa la Consulta del Cabecero de la Transaci�n 

        RETURN cursalida;
    END fngettrandeta;

    FUNCTION fncosultran (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrcb.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrcb.fisucursal%TYPE
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor IS
        cursalida   scactualizadorvt.pautil.rcg_tipocursor;  -- Consulta de Transacciones de Tipo Cursor 
    BEGIN

   -- Cursor del Cabecero de la Transacci�n 
        OPEN cursalida FOR SELECT
            fipaisid,
            ficanal,
            fisucursal,
            fitranno,
            fitrantipo,
            ficonsectipo,
            fdtransfechr,
            fctranws,
            fctranusr,
            fitrannoreg,
            fitransmit
                           FROM
            scactualizadorvt.tatrncrcb
                           WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno;

   -- Regresa la Consulta del Cabecero de la Transaci�n 

        RETURN cursalida;
    END fncosultran;

    FUNCTION fndeletedeta (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE,
        pa_numedeta   IN NUMBER
    ) RETURN NUMBER IS
        csl_exito   NUMBER(5) :=-1; -- indica estatus de ejecucion exitosa
    BEGIN

   -- Borra Transaci�n Detalle 
        DELETE FROM scactualizadorvt.tatrncrdt
        WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno
            AND ficonsdeta = pa_numedeta;

        COMMIT;
        csl_exito := 0; --  termino corretamente
        RETURN csl_exito;
    exception when others then
        rollback;
        csl_exito := -1;
        RETURN csl_exito;
    END fndeletedeta;

    FUNCTION fncosultrandeta (
        pa_pais       IN scactualizadorvt.tatrncrdt.fipaisid%TYPE,
        pa_canal      IN scactualizadorvt.tatrncrdt.ficanal%TYPE,
        pa_tranno     IN scactualizadorvt.tatrncrdt.fitranno%TYPE,
        pa_sucursal   IN scactualizadorvt.tatrncrdt.fisucursal%TYPE,
        pa_numedeta   IN NUMBER
    ) RETURN scactualizadorvt.pautil.rcg_tipocursor IS
        cursalida   scactualizadorvt.pautil.rcg_tipocursor;  -- Cursor de Retorno de Tipo Cursor 
    BEGIN

   -- Cursor del Detalle de la Transacci�n 
        OPEN cursalida FOR SELECT
            fipaisid,
            ficanal,
            fisucursal,
            fitranno,
            ficonsdeta,
            fitiporeg,
            fcdatodeta
                           FROM
            scactualizadorvt.tatrncrdt
                           WHERE
            fipaisid = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fitranno = pa_tranno
            AND ficonsdeta = pa_numedeta;

   -- Regresa la Consulta del Detalle de la Transacci�n 

        RETURN cursalida;
    END fncosultrandeta;

    FUNCTION fnupdtactrlerrores (
        pa_erridrow IN VARCHAR2
    ) RETURN NUMBER IS

   -- Constantes 

        csl_estatus    NUMBER(1) := 1; -- Indica que es un Error ya Procesado     
        vl_stssalida   NUMBER(2) := 0; -- varaiable de salida
        csl_exito      NUMBER(2) := 1; -- actualizado ok
        vl_rowid       ROWID;    --Variable que contiene el ROWID en tipo caracter
    BEGIN
        vl_rowid := chartorowid(utl_raw.cast_to_varchar2(pa_erridrow) );
        UPDATE scactualizadorvt.tactrlerrores
        SET
            fistatus = csl_estatus,
            fderrorsol = SYSDATE
        WHERE
            ROWID = vl_rowid;

        IF
            SQL%rowcount = 1
        THEN
            COMMIT;
            vl_stssalida := csl_exito;
        END IF;
        RETURN vl_stssalida;
    EXCEPTION
        WHEN OTHERS THEN
        rollback;
            scactualizadorvt.pautil.spictrlerrores(csg_tipoaplicacion,'SCACTUALIZADORVT.pamonitoreo0005.SPUPDTACTRLERRORES',sqlcode,sqlerrm,'Hubo problemas al actualizar la bitacora TACTRLERRORES.'
);
            RETURN vl_stssalida;
    END fnupdtactrlerrores;

END pamonitoreo0005;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0005" TO "USRACTVT";
