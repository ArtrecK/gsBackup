--------------------------------------------------------
--  DDL for Package Body PQSBGESTION0010
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."PQSBGESTION0010" 
IS
    csl_0             CONSTANT PLS_INTEGER := 0;
    csl_1             CONSTANT PLS_INTEGER := 1;
    csl_2             CONSTANT PLS_INTEGER := 2;
    csl_30            CONSTANT PLS_INTEGER := 30;
    csl_07            CONSTANT PLS_INTEGER := 07;
    csl_100           CONSTANT PLS_INTEGER := 100;
    csl_desconocido   CONSTANT VARCHAR2 (12) := 'DESCONOCIDO';
    csl_desconocida   CONSTANT VARCHAR2 (12) := 'DESCONOCIDA';

    FUNCTION fntbpresupuesto (pa_fcnoempleado     VARCHAR2,
                              pa_fisucursal       INTEGER,
                              pa_dias             INTEGER,
                              pa_fipais           INTEGER,
                              pa_ficanal          INTEGER,
                              pa_fisucursalcte    INTEGER,
                              pa_fifolio          INTEGER)
        RETURN scventastienda.tytbpresupuesto
    AS
        typ_presupuesto   scventastienda.tytbpresupuesto;
    BEGIN
        EXECUTE IMMEDIATE
            ('alter session set nls_date_format = ''DD/MM/YYYY''');

        typ_presupuesto := NEW scventastienda.tytbpresupuesto ();

        FOR cpre
            IN (SELECT tp.fipais,
                       tp.ficanal,
                       tp.fisucursal,
                       tp.fifolioparam
                           AS fipresupuestoid,
                       tp.fnpabo
                           AS fnultimoabono,
                       tp.fdfecprep
                           AS fecha,
                       scventastienda.pqsbgestion0010.fnproductomonto (
                           tp.fipais,
                           tp.ficanal,
                           tp.fisucursal,
                           tp.fifolioparam)
                           AS fnmonto,
                       tp.fiplazo,
                       CASE
                           WHEN tp.fiplazo <= csl_1 THEN t.fcunidad
                           WHEN tp.fiplazo > csl_1 THEN t.fcunidades
                           ELSE t.fcunidad
                       END
                           AS fcdesperiodo
                  FROM scventastienda.tapreparame      tp,
                       scventastienda.tcperiodosparam  t,
                       scventastienda.tacenctetienda   tcen
                 WHERE     tp.fisucursal = pa_fisucursal
                       AND TRIM (tp.fcempno) = pa_fcnoempleado
                       AND TRUNC (tp.fdfecprep) >= TRUNC (SYSDATE - pa_dias)
                       AND NVL (tp.finopedido, csl_0) = csl_0
                       AND tcen.fipaiscu = pa_fipais
                       AND tcen.ficanalcu = pa_ficanal
                       AND tcen.fisucursalcu = pa_fisucursalcte
                       AND tcen.fifolio = pa_fifolio
                       AND tp.ficteid = tcen.ficteid
                       AND tp.fidigitover = tcen.fidigitover
                       AND tp.finotienda = tcen.finotienda
                       AND tp.fingcioid = tcen.fingcioid
                       AND tp.fiperiodo = t.fiperiodoid
                       AND tp.fipais > csl_0
                       AND tp.ficanal > csl_0
                       AND tp.fisucursal > csl_0
                       AND tp.fifolioparam > csl_0
                       AND t.fiperiodoid > csl_0)
        LOOP
            typ_presupuesto.EXTEND;
            typ_presupuesto (typ_presupuesto.LAST) :=
                NEW scventastienda.tyobpresupuesto (
                        cpre.fipresupuestoid                /*ID PRESUPUESTO*/
                                            ,
                        cpre.fnmonto                                /* MONTO*/
                                    ,
                        cpre.fecha                  /* FECHA DEL PRESUPUESTO*/
                                  ,
                        cpre.fiplazo,
                        (cpre.fcdesperiodo)                   /* FECHA PLAZO*/
                                           ,
                        cpre.fnultimoabono                   /* ULTIMO ABONO*/
                                          ,
                        scventastienda.pqsbgestion0010.fntbproducto (
                            cpre.fipais,
                            cpre.ficanal,
                            cpre.fisucursal,
                            cpre.fipresupuestoid) /*COLLECTION CON LOS PRODUCTOS DEL PRESUPUESTO*/
                                                 );
        END LOOP;

        RETURN typ_presupuesto;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fntbpresupuesto;

    FUNCTION fntbproducto (pa_fipais          INTEGER,
                           pa_ficanal         INTEGER,
                           pa_fisucursal      INTEGER,
                           pa_fifolioparam    INTEGER)
        RETURN scventastienda.tytbproducto
    AS
        typ_productos   scventastienda.tytbproducto;
    BEGIN
        typ_productos := NEW scventastienda.tytbproducto ();



        --OBTENER TODOS LOS PRODUCTOS DEL PRESUPUESTO Y LLENAR COLLECTION
        FOR cpro
            IN (SELECT fiprodid
                           AS fisku,
                       NVL (tp.fcdescsku, csl_desconocido)
                           AS fcdesproducto,
                       ficant
                           AS fncantidad,
                       NVL (tp.fcdesclineasie, csl_desconocida)
                           AS fcdeslinea,
                       NVL (tp.fnlineasie, csl_0)
                           AS filineaid,
                       tp.fnprecio
                           AS fnprecioactual
                  FROM scventastienda.tadetpreparam  td,
                       scventastienda.tcproducto     tp
                 WHERE     td.ficanal = pa_ficanal
                       AND td.fipais = pa_fipais
                       AND td.fisucursal = pa_fisucursal
                       AND td.fifolioparam = pa_fifolioparam
                       AND td.fiprodid = tp.fnsku(+)
                       AND tp.fnsku(+) > csl_0)
        LOOP
            typ_productos.EXTEND;
            typ_productos (typ_productos.LAST) :=
                NEW scventastienda.tyobproducto (cpro.fisku /* SKU DEL PRODUCTO */
                                                           ,
                                                 cpro.fncantidad /* CANTIDAD */
                                                                ,
                                                 cpro.fcdesproducto /* PRODUCTO */
                                                                   ,
                                                 cpro.fcdeslinea /* DESCRIPCION LINEA */
                                                                ,
                                                 cpro.filineaid /* ID DE LA LINEA */
                                                               ,
                                                 cpro.fnprecioactual /* PRECIO ACTUAL DEL PRODUCTO */
                                                                    );
        END LOOP;

        RETURN typ_productos;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fntbproducto;

    PROCEDURE sppresupuestos (pa_fcnoempleado   IN     VARCHAR2,
                              pa_fisucursal     IN     INTEGER,
                              pa_dias           IN     INTEGER,
                              pa_curdatos          OUT SYS_REFCURSOR,
                              pa_mensaje           OUT VARCHAR2,
                              pa_coderror          OUT INTEGER,
                              pa_deserror          OUT VARCHAR2)
    IS
    BEGIN
        EXECUTE IMMEDIATE
            ('alter session set nls_date_format = ''DD/MM/YYYY''');

        OPEN pa_curdatos FOR
            SELECT cte.fipaiscu
                       AS fipais,
                   cte.ficanalcu
                       AS ficanal,
                   cte.fisucursalcu
                       AS fisucursal,
                   cte.fifolio,
                   XMLELEMENT ("PRESUPUESTOS",
                               scventastienda.pqsbgestion0010.fntbpresupuesto (
                                   pa_fcnoempleado,
                                   pa_fisucursal,
                                   NVL (csl_07, csl_07),
                                   cte.fipaiscu,
                                   cte.ficanalcu,
                                   cte.fisucursalcu,
                                   cte.fifolio)).getclobval ()
                       AS presupuesto
              FROM (  SELECT tcen.fipaiscu,
                             tcen.ficanalcu,
                             tcen.fisucursalcu,
                             tcen.fifolio
                        FROM scventastienda.tapreparame   tp,
                             scventastienda.tacenctetienda tcen
                       WHERE     TRIM (tp.fcempno) = pa_fcnoempleado
                             AND tp.fisucursal = pa_fisucursal
                             AND TRUNC (tp.fdfecprep) >=
                                 TRUNC (SYSDATE - NVL (csl_07, csl_07)) /*PRESUPUESTO CON FECHA MAYOR O IGUAL AL TOPE PA_DIAS*/
                             AND NVL (tp.finopedido, csl_0) = csl_0 /*SI FINOPEDIDO ES CERO SE TRATA DE UN PRESUPUESTO*/
                             AND tp.ficteid = tcen.ficteid
                             AND tp.fidigitover = tcen.fidigitover
                             AND tp.fingcioid = tcen.fingcioid
                             AND tp.finotienda = tcen.finotienda
                             AND tp.fipais > csl_0
                             AND tp.ficanal > csl_0
                             AND tp.fisucursal > csl_0
                             AND tp.fifolioparam > csl_0
                    GROUP BY tcen.fipaiscu,
                             tcen.ficanalcu,
                             tcen.fisucursalcu,
                             tcen.fifolio) cte
                   LEFT JOIN scsisges.taclientefinado finado
                       ON     cte.fipaiscu = finado.fipais
                          AND cte.ficanalcu = finado.ficanal
                          AND cte.fisucursalcu = finado.fisucursal
                          AND cte.fifolio = finado.fifolio
                          AND finado.fnstatus IN (csl_0, csl_1)
             WHERE     finado.fipais IS NULL
                   AND finado.ficanal IS NULL
                   AND finado.fisucursal IS NULL
                   AND finado.fifolio IS NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_coderror := SQLCODE;
            pa_deserror := SUBSTR (SQLERRM, csl_0, csl_100);
            pa_mensaje := 'OCURRIO UN ERROR AL CONSULTAR PRESUPUESTOS';
    END sppresupuestos;

    FUNCTION fnproductomonto (pa_fipais          INTEGER,
                              pa_ficanal         INTEGER,
                              pa_fisucursal      INTEGER,
                              pa_fifolioparam    INTEGER)
        RETURN NUMBER
    IS
        vl_monto   NUMBER (15, 2) := 0;
    BEGIN
        BEGIN
              SELECT SUM (
                           (  (  (  NVL (td.fnprodpreciod, csl_0)
                                  - NVL (td.fndescto, csl_0))
                               * NVL (td.ficant, csl_0))
                            - NVL (td.fndesctoesp, csl_0))
                         + NVL (td.fnsobreprecio, csl_0))
                INTO vl_monto
                FROM scventastienda.tadetpreparam td
               WHERE     td.ficanal = pa_ficanal
                     AND td.fipais = pa_fipais
                     AND td.fisucursal = pa_fisucursal
                     AND td.fifolioparam = pa_fifolioparam
            GROUP BY td.ficanal,
                     td.fipais,
                     td.fisucursal,
                     td.fifolioparam;
        EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                RETURN csl_0;
        END;

        RETURN vl_monto;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN csl_0;
    END fnproductomonto;

    PROCEDURE sppedidospendientes (pa_fcnoempleado   IN     VARCHAR2,
                                   pa_fisucursal     IN     INTEGER,
                                   pa_curpedidos        OUT SYS_REFCURSOR,
                                   pa_mensaje           OUT VARCHAR2,
                                   pa_coderror          OUT INTEGER,
                                   pa_deserror          OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_curpedidos FOR
            SELECT tcltes.fipais,
                   tcltes.ficanal,
                   tcltes.fisucursal,
                   tcltes.fifolio,
                   XMLELEMENT ("PEDIDO",
                               scventastienda.pqsbgestion0010.fntbpedpendiente (
                                   pa_fcnoempleado,
                                   pa_fisucursal,
                                   tcltes.fipais,
                                   tcltes.ficanal,
                                   tcltes.fisucursal,
                                   tcltes.fifolio)).getclobval ()
                       AS pedidos
              FROM (  SELECT tcen.fipais,
                             tcen.ficanal,
                             tcen.fisucursal,
                             tcen.fifolio
                        FROM scventastienda.tacenctetienda tcen
                             JOIN scventastienda.tapedidos tapedpen
                                 ON     tcen.fingcioid = tapedpen.fingcioid
                                    AND tcen.finotienda = tapedpen.finotienda
                                    AND tcen.ficteid = tapedpen.ficteid
                                    AND tcen.fidigitover = tapedpen.fidigitover
                                    AND TRIM (tapedpen.fcempnoventa) =
                                        pa_fcnoempleado
                                    AND tapedpen.fisucursal = pa_fisucursal
                                    AND tapedpen.fipedstat = csl_0
                                    AND tapedpen.fitipoventa IN (csl_2, csl_1)
                                    AND tcen.fipaiscu > csl_0
                                    AND tcen.ficanalcu > csl_0
                                    AND tcen.fisucursalcu > csl_0
                                    AND tcen.fifolio > csl_0
                                    AND tcen.fingcioid > csl_0
                                    AND tcen.finotienda > csl_0
                                    AND tcen.ficteid > csl_0
                                    AND tcen.fidigitover > csl_0
                                    AND tapedpen.fipais > csl_0
                                    AND tapedpen.ficanal > csl_0
                                    AND tapedpen.fisucursal > csl_0
                                    AND tapedpen.finopedido > csl_0
                    GROUP BY tcen.fipais,
                             tcen.ficanal,
                             tcen.fisucursal,
                             tcen.fifolio) tcltes
                   LEFT JOIN scsisges.taclientefinado finado
                       ON     tcltes.fipais = finado.fipais
                          AND tcltes.ficanal = finado.ficanal
                          AND tcltes.fisucursal = finado.fisucursal
                          AND tcltes.fifolio = finado.fifolio
                          AND finado.fnstatus IN (csl_0, csl_1)
             WHERE     finado.fipais IS NULL
                   AND finado.ficanal IS NULL
                   AND finado.fisucursal IS NULL
                   AND finado.fifolio IS NULL;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_mensaje :=
                'Ocurrio un error al consultar pendientes por surtir';
            pa_coderror := SQLCODE;
            pa_deserror := SUBSTR (SQLERRM, csl_0, csl_100);
    END sppedidospendientes;

    FUNCTION fntbpedpendiente (pa_fcnoempleado    VARCHAR2,
                               pa_fisucursal      INTEGER,
                               pa_fipais          INTEGER,
                               pa_ficanal         INTEGER,
                               pa_sucursalcte     INTEGER,
                               pa_folio           INTEGER)
        RETURN scventastienda.tytbpedpendient
    AS
        typ_pendientes   scventastienda.tytbpedpendient;
    BEGIN
        typ_pendientes := NEW scventastienda.tytbpedpendient ();

        FOR cpre
            IN (SELECT tped.fipais,
                       tped.ficanal,
                       tped.fisucursal,
                       tped.finopedido,
                       tped.fnpedtotal
                           AS monto,                             --MONTO TOTAL
                       tcre.fiplazo,
                       TO_DATE (tped.fdpedfec, 'dd/mm/yy')
                           AS fechapedido,
                       (SELECT CASE
                                   WHEN tcre.fiplazo <= csl_1 THEN fcunidad
                                   WHEN tcre.fiplazo > csl_1 THEN fcunidades
                                   ELSE fcunidad
                               END
                                   AS fcunidad
                          FROM scventastienda.tcperiodosparam tcperiodos
                         WHERE tcperiodos.fiperiodoid = tcre.fiperiodo) -- pendiente por validar
                           AS fcdescripperiodo,
                       tcre.fnpabo
                           AS abono
                  FROM scventastienda.tapedidos       tped,
                       scventastienda.tapreparame     tcre,
                       scventastienda.tacenctetienda  tcen
                 WHERE     tped.fisucursal = pa_fisucursal
                       AND TRIM (tped.fcempnoventa) = pa_fcnoempleado
                       AND tcen.fipais = pa_fipais
                       AND tcen.ficanal = pa_ficanal
                       AND tcen.fisucursal = pa_sucursalcte
                       AND tcen.fifolio = pa_folio
                       AND tped.fipedstat = csl_0
                       AND tped.fitipoventa = csl_2
                       AND tcen.ficteid = tped.ficteid
                       AND tcen.fidigitover = tped.fidigitover
                       AND tcen.fingcioid = tped.fingcioid
                       AND tcen.finotienda = tped.finotienda
                       AND tcre.finopedido(+) >= csl_0
                       AND tped.fipais = tcre.fipais
                       AND tped.ficanal = tcre.ficanal
                       AND tped.fisucursal = tcre.fisucursal
                       AND tped.fifolioparam = tcre.fifolioparam
                       AND tped.fipais > csl_0
                       AND tped.ficanal > csl_0
                       AND tped.fisucursal > csl_0
                       AND tped.finopedido > csl_0)
        LOOP
            typ_pendientes.EXTEND;
            typ_pendientes (typ_pendientes.LAST) :=
                NEW scventastienda.tyobpedpendient (cpre.finopedido /*ID PRESUPUESTO*/
                                                                   ,
                                                    cpre.monto      /* MONTO*/
                                                              ,
                                                    cpre.fechapedido /* FECHA DEL PRESUPUESTO*/
                                                                    ,
                                                    cpre.fiplazo,
                                                    cpre.fcdescripperiodo,
                                                    cpre.abono,
                                                    scventastienda.pqsbgestion0010.fntbproductoped (
                                                        cpre.fipais,
                                                        cpre.ficanal,
                                                        cpre.fisucursal,
                                                        cpre.finopedido) /*COLLECTION CON LOS PRODUCTOS DEL PRESUPUESTO*/
                                                                        );
        END LOOP;

        RETURN typ_pendientes;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fntbpedpendiente;

    FUNCTION fntbproductoped (pa_fipais        INTEGER,
                              pa_ficanal       INTEGER,
                              pa_fisucursal    INTEGER,
                              pa_finopedido    INTEGER)
        RETURN scventastienda.tytbproducto
    AS
        typ_productos   scventastienda.tytbproducto;
    BEGIN
        typ_productos := NEW scventastienda.tytbproducto ();



        --OBTENER TODOS LOS PRODUCTOS DEL PRESUPUESTO Y LLENAR COLLECTION
        FOR cpro
            IN (SELECT fiprodid
                           AS fisku,
                       NVL (tp.fcdescsku, csl_desconocido)
                           AS fcdesproducto,
                       tdet.ficantart
                           AS fncantidad,
                       NVL (tp.fcdesclineasie, csl_desconocida)
                           AS fcdeslinea,
                       NVL (tp.fnlineasie, csl_0)
                           AS filineaid,
                       tp.fnprecio
                           AS fnprecioactual
                  FROM scventastienda.tadetpedidos  tdet,
                       scventastienda.tcproducto    tp
                 WHERE     tdet.ficanal = pa_ficanal
                       AND tdet.fipais = pa_fipais
                       AND tdet.fisucursal = pa_fisucursal
                       AND tdet.finopedido = pa_finopedido
                       AND tdet.fiprodid = tp.fnsku(+)
                       AND tp.fnsku(+) > csl_0)
        LOOP
            typ_productos.EXTEND;
            typ_productos (typ_productos.LAST) :=
                NEW scventastienda.tyobproducto (cpro.fisku /* SKU DEL PRODUCTO */
                                                           ,
                                                 cpro.fncantidad /* CANTIDAD */
                                                                ,
                                                 cpro.fcdesproducto /* PRODUCTO */
                                                                   ,
                                                 cpro.fcdeslinea /* DESCRIPCION LINEA */
                                                                ,
                                                 cpro.filineaid /* ID DE LA LINEA */
                                                               ,
                                                 cpro.fnprecioactual /* PRECIO ACTUAL DEL PRODUCTO */
                                                                    );
        END LOOP;

        RETURN typ_productos;
    EXCEPTION
        WHEN OTHERS
        THEN
            RETURN NULL;
    END fntbproductoped;

    PROCEDURE spconteopresup (pa_fcnoempleado   IN     VARCHAR2,
                              pa_fisucursal     IN     INTEGER,
                              pa_dias           IN     INTEGER,
                              pa_curdatos          OUT SYS_REFCURSOR,
                              pa_conteo            OUT NUMBER,
                              pa_mensaje           OUT VARCHAR2,
                              pa_coderror          OUT INTEGER,
                              pa_deserror          OUT VARCHAR2)
    IS
    BEGIN
          --HACER CONTEO DE PRESUPUESTOS
          SELECT COUNT (COUNT (1))
            INTO pa_conteo
            FROM (SELECT c.fipais,
                         c.ficanal,
                         c.fisucursal,
                         c.fifolio
                    FROM scventastienda.tapreparame pp
                         INNER JOIN scventastienda.tacenctetienda c
                             ON     c.fingcioid = pp.fingcioid
                                AND c.finotienda = pp.finotienda
                                AND c.ficteid = pp.ficteid
                                AND c.fidigitover = pp.fidigitover
                         INNER JOIN scventastienda.tadetpreparam tp
                             ON     pp.fipais = tp.fipais
                                AND pp.ficanal = tp.ficanal
                                AND pp.fisucursal = tp.fisucursal
                                AND pp.fifolioparam = tp.fifolioparam
                         LEFT JOIN scventastienda.tcproducto t
                             ON tp.fiprodid = t.fnsku
                         INNER JOIN scventastienda.tclinea l
                             ON t.fnlineasie = l.fnlinea
                   WHERE     pp.fisucursal = pa_fisucursal
                         AND TRIM (pp.fcempno) = pa_fcnoempleado
                         AND TO_DATE (fdfecprep, 'DD/MM/YYYY') BETWEEN   TO_DATE (
                                                                             SYSDATE,
                                                                             'DD/MM/YYYY')
                                                                       - csl_07
                                                                   AND TO_DATE (
                                                                           SYSDATE,
                                                                           'DD/MM/YYYY')
                         AND pp.finopedido = csl_0
                         AND pp.fipais > csl_0
                         AND pp.ficanal > csl_0
                         AND pp.fisucursal > csl_0
                         AND pp.fifolioparam > csl_0
                         AND t.fnsku > csl_0) presupuestos
                 LEFT JOIN scsisges.taclientefinado finado
                     ON     presupuestos.fipais = finado.fipais
                        AND presupuestos.ficanal = finado.ficanal
                        AND presupuestos.fisucursal = finado.fisucursal
                        AND presupuestos.fifolio = finado.fifolio
                        AND finado.fnstatus IN (csl_0, csl_1)
           WHERE     finado.fipais IS NULL
                 AND finado.ficanal IS NULL
                 AND finado.fisucursal IS NULL
                 AND finado.fifolio IS NULL
        GROUP BY presupuestos.fipais,
                 presupuestos.ficanal,
                 presupuestos.fisucursal,
                 presupuestos.fifolio;



        --DEVOLVER EN CURSOR LOS SKU DE LOS PRESUPUESTOS DEL EMPLEADO

        OPEN pa_curdatos FOR
              SELECT presupuestos.fcprdlindesc, COUNT (1) AS ficontcltes
                FROM (  SELECT l.fcprdlindesc,
                               COUNT (1) AS ficontcltes,
                               c.fipais,
                               c.ficanal,
                               c.fisucursal,
                               c.fifolio
                          FROM scventastienda.tapreparame pp
                               INNER JOIN scventastienda.tacenctetienda c
                                   ON     c.fingcioid = pp.fingcioid
                                      AND c.finotienda = pp.finotienda
                                      AND c.ficteid = pp.ficteid
                                      AND c.fidigitover = pp.fidigitover
                               INNER JOIN scventastienda.tadetpreparam tp
                                   ON     pp.fipais = tp.fipais
                                      AND pp.ficanal = tp.ficanal
                                      AND pp.fisucursal = tp.fisucursal
                                      AND pp.fifolioparam = tp.fifolioparam
                               LEFT JOIN scventastienda.tcproducto t
                                   ON tp.fiprodid = t.fnsku
                               INNER JOIN scventastienda.tclinea l
                                   ON t.fnlineasie = l.fnlinea
                         WHERE     pp.fisucursal = pa_fisucursal
                               AND TRIM (pp.fcempno) = pa_fcnoempleado
                               AND TO_DATE (pp.fdfecprep, 'DD/MM/YYYY') BETWEEN   TO_DATE (
                                                                                      SYSDATE,
                                                                                      'DD/MM/YYYY')
                                                                                - csl_07
                                                                            AND TO_DATE (
                                                                                    SYSDATE,
                                                                                    'DD/MM/YYYY')
                               AND pp.finopedido = csl_0
                               AND pp.fipais > csl_0
                               AND pp.ficanal > csl_0
                               AND pp.fisucursal > csl_0
                               AND pp.fifolioparam > csl_0
                               AND t.fnsku > csl_0
                               AND t.fnlineasap > csl_0
                               AND l.fnlineaprod > csl_0
                      GROUP BY l.fcprdlindesc,
                               c.fipais,
                               c.ficanal,
                               c.fisucursal,
                               c.fifolio) presupuestos
                     LEFT JOIN scsisges.taclientefinado finado
                         ON     presupuestos.fipais = finado.fipais
                            AND presupuestos.ficanal = finado.ficanal
                            AND presupuestos.fisucursal = finado.fisucursal
                            AND presupuestos.fifolio = finado.fifolio
                            AND finado.fnstatus IN (csl_0, csl_1)
               WHERE     finado.fipais IS NULL
                     AND finado.ficanal IS NULL
                     AND finado.fisucursal IS NULL
                     AND finado.fifolio IS NULL
            GROUP BY presupuestos.fcprdlindesc;

        pa_coderror := csl_1;
        pa_mensaje := 'SE CONSULTO CORRECTAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_coderror := SQLCODE;
            pa_deserror := SUBSTR (SQLERRM, csl_0, csl_100);
            pa_mensaje :=
                'OCURRIO UN ERROR AL CONSULTAR NUMERO DE PRESUPUESTOS';
    END spconteopresup;

    PROCEDURE spconteopedidos (pa_fcnoempleado   IN     VARCHAR2,
                               pa_fisucursal     IN     INTEGER,
                               pa_curdatos          OUT SYS_REFCURSOR,
                               pa_conteo            OUT NUMBER,
                               pa_mensaje           OUT VARCHAR2,
                               pa_coderror          OUT INTEGER,
                               pa_deserror          OUT VARCHAR2)
    IS
    BEGIN
          --HACER CONTEO DE PEDIDOS PENDIENTES POR SURTIR
          SELECT COUNT (COUNT (1))
            INTO pa_conteo
            FROM (SELECT tcen.fipais,
                         tcen.ficanal,
                         tcen.fisucursal,
                         tcen.fifolio
                    FROM scventastienda.tacenctetienda tcen
                         JOIN scventastienda.tapedidos tapedpen
                             ON     tcen.fingcioid = tapedpen.fingcioid
                                AND tcen.finotienda = tapedpen.finotienda
                                AND tcen.ficteid = tapedpen.ficteid
                                AND tcen.fidigitover = tapedpen.fidigitover
                                AND TRIM (tapedpen.fcempnoventa) =
                                    pa_fcnoempleado
                                AND tapedpen.fisucursal = pa_fisucursal
                                AND tapedpen.fipedstat = csl_0
                                AND tapedpen.fitipoventa IN (csl_2, csl_1)
                                AND tcen.fipaiscu > csl_0
                                AND tcen.ficanalcu > csl_0
                                AND tcen.fisucursalcu > csl_0
                                AND tcen.fifolio > csl_0
                                AND tcen.fingcioid > csl_0
                                AND tcen.finotienda > csl_0
                                AND tcen.ficteid > csl_0
                                AND tcen.fidigitover > csl_0
                                AND tapedpen.fipais > csl_0
                                AND tapedpen.ficanal > csl_0
                                AND tapedpen.fisucursal > csl_0
                                AND tapedpen.finopedido > csl_0) pedidos
                 LEFT JOIN scsisges.taclientefinado finado
                     ON     pedidos.fipais = finado.fipais
                        AND pedidos.ficanal = finado.ficanal
                        AND pedidos.fisucursal = finado.fisucursal
                        AND pedidos.fifolio = finado.fifolio
                        AND finado.fnstatus IN (csl_0, csl_1)
           WHERE     finado.fipais IS NULL
                 AND finado.ficanal IS NULL
                 AND finado.fisucursal IS NULL
                 AND finado.fifolio IS NULL
        GROUP BY pedidos.fipais,
                 pedidos.ficanal,
                 pedidos.fisucursal,
                 pedidos.fifolio;



        --DEVOLVER EN CURSOR LOS SKU DE LOS PENDIENTES POR SURTIR DEL EMPLEADO

        OPEN pa_curdatos FOR
              SELECT pedidos.fcprdlindesc, COUNT (1) AS contpresupuesto
                FROM (  SELECT tcl.fcprdlindesc,
                               COUNT (tcprod.fnlineasie) AS contpresupuesto,
                               tcen.fipais,
                               tcen.ficanal,
                               tcen.fisucursal,
                               tcen.fifolio
                          FROM scventastienda.tacenctetienda tcen
                               JOIN scventastienda.tapedidos tapedpen
                                   ON     tcen.fingcioid = tapedpen.fingcioid
                                      AND tcen.finotienda = tapedpen.finotienda
                                      AND tcen.ficteid = tapedpen.ficteid
                                      AND tcen.fidigitover = tapedpen.fidigitover
                                      AND TRIM (tapedpen.fcempnoventa) =
                                          pa_fcnoempleado
                                      AND tapedpen.fisucursal = pa_fisucursal
                                      AND tapedpen.fipedstat = csl_0
                                      AND tapedpen.fitipoventa = csl_2
                               JOIN scventastienda.tadetpedidos tadpedido
                                   ON     tcen.fipaiscu = tadpedido.fipais
                                      AND tcen.ficanalcu = tadpedido.ficanal
                                      AND tcen.fisucursalcu =
                                          tadpedido.fisucursal
                                      AND tcen.fifolio > csl_0
                                      AND tapedpen.finopedido =
                                          tadpedido.finopedido
                               JOIN scventastienda.tcproducto tcprod
                                   ON     tcprod.fnsku = tadpedido.fiprodid
                                      AND tcprod.fnsku > csl_0
                               JOIN scventastienda.tclinea tcl
                                   ON     tcl.fnlinea = tcprod.fnlineasie
                                      AND tcl.fnlinea > csl_0
                         WHERE     tapedpen.fipais > csl_0
                               AND tapedpen.ficanal > csl_0
                               AND tapedpen.fisucursal > csl_0
                               AND tapedpen.finopedido > csl_0
                      GROUP BY tcl.fcprdlindesc,
                               tcl.fnlinea,
                               tcen.fipais,
                               tcen.ficanal,
                               tcen.fisucursal,
                               tcen.fifolio
                      ORDER BY tcl.fcprdlindesc) pedidos
                     LEFT JOIN scsisges.taclientefinado finado
                         ON     pedidos.fipais = finado.fipais
                            AND pedidos.ficanal = finado.ficanal
                            AND pedidos.fisucursal = finado.fisucursal
                            AND pedidos.fifolio = finado.fifolio
                            AND finado.fnstatus IN (csl_0, csl_1)
               WHERE     finado.fipais IS NULL
                     AND finado.ficanal IS NULL
                     AND finado.fisucursal IS NULL
                     AND finado.fifolio IS NULL
            GROUP BY pedidos.fcprdlindesc;

        pa_coderror := csl_1;
        pa_mensaje := 'SE CONSULTO CORRECTAMENTE';
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_coderror := SQLCODE;
            pa_deserror := SUBSTR (SQLERRM, csl_0, csl_100);
            pa_mensaje :=
                'OCURRIO UN ERROR AL CONSULTAR NUMERO DE PEDIDOS PENDIENTES POR SURTIR';
    END spconteopedidos;
END pqsbgestion0010;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PQSBGESTION0010" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PQSBGESTION0010" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PQSBGESTION0010" TO "USRVENTAST";
