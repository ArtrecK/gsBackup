--------------------------------------------------------
--  DDL for Package PQSBGESTION0010
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PQSBGESTION0010" 
IS
    FUNCTION fntbpresupuesto (pa_fcnoempleado     VARCHAR2,
                              pa_fisucursal       INTEGER,
                              pa_dias             INTEGER,
                              pa_fipais           INTEGER,
                              pa_ficanal          INTEGER,
                              pa_fisucursalcte    INTEGER,
                              pa_fifolio          INTEGER)
        RETURN scventastienda.tytbpresupuesto;

    FUNCTION fntbproducto (pa_fipais          INTEGER,
                           pa_ficanal         INTEGER,
                           pa_fisucursal      INTEGER,
                           pa_fifolioparam    INTEGER)
        RETURN scventastienda.tytbproducto;

    PROCEDURE sppresupuestos (pa_fcnoempleado   IN     VARCHAR2,
                              pa_fisucursal     IN     INTEGER,
                              pa_dias           IN     INTEGER,
                              pa_curdatos          OUT SYS_REFCURSOR,
                              pa_mensaje           OUT VARCHAR2,
                              pa_coderror          OUT INTEGER,
                              pa_deserror          OUT VARCHAR2);

    FUNCTION fnproductomonto (pa_fipais          INTEGER,
                              pa_ficanal         INTEGER,
                              pa_fisucursal      INTEGER,
                              pa_fifolioparam    INTEGER)
        RETURN NUMBER;

    PROCEDURE sppedidospendientes (pa_fcnoempleado   IN     VARCHAR2,
                                   pa_fisucursal     IN     INTEGER,
                                   pa_curpedidos        OUT SYS_REFCURSOR,
                                   pa_mensaje           OUT VARCHAR2,
                                   pa_coderror          OUT INTEGER,
                                   pa_deserror          OUT VARCHAR2);

    FUNCTION fntbpedpendiente (pa_fcnoempleado    VARCHAR2,
                               pa_fisucursal      INTEGER,
                               pa_fipais          INTEGER,
                               pa_ficanal         INTEGER,
                               pa_sucursalcte     INTEGER,
                               pa_folio           INTEGER)
        RETURN scventastienda.tytbpedpendient;

    FUNCTION fntbproductoped (pa_fipais        INTEGER,
                              pa_ficanal       INTEGER,
                              pa_fisucursal    INTEGER,
                              pa_finopedido    INTEGER)
        RETURN scventastienda.tytbproducto;

    PROCEDURE spconteopresup (pa_fcnoempleado   IN     VARCHAR2,
                              pa_fisucursal     IN     INTEGER,
                              pa_dias           IN     INTEGER,
                              pa_curdatos          OUT SYS_REFCURSOR,
                              pa_conteo            OUT NUMBER,
                              pa_mensaje           OUT VARCHAR2,
                              pa_coderror          OUT INTEGER,
                              pa_deserror          OUT VARCHAR2);

    PROCEDURE spconteopedidos (pa_fcnoempleado   IN     VARCHAR2,
                               pa_fisucursal     IN     INTEGER,
                               pa_curdatos          OUT SYS_REFCURSOR,
                               pa_conteo            OUT NUMBER,
                               pa_mensaje           OUT VARCHAR2,
                               pa_coderror          OUT INTEGER,
                               pa_deserror          OUT VARCHAR2);
END pqsbgestion0010;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PQSBGESTION0010" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PQSBGESTION0010" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PQSBGESTION0010" TO "USRVENTAST";
