--------------------------------------------------------
--  DDL for Package Body PAGOALS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."PAGOALS" 
AS
    csl_0p00   CONSTANT NUMBER := 0.00;
    csl_0      CONSTANT INTEGER := 0;
    csl_1      CONSTANT INTEGER := 1;
    csl_2      CONSTANT INTEGER := 2;
    csl_4      CONSTANT INTEGER := 4;


    PROCEDURE spgoalsdaily (pa_idsucursal   IN     INTEGER,
                            pa_empnosurte   IN     INTEGER,
                            pa_fecha        IN     INTEGER,
                            pa_curgoals        OUT SYS_REFCURSOR,
                            pa_coderror        OUT INTEGER,
                            pa_msgerror        OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_curgoals FOR
              --ULTIMO PROBADO
              SELECT d.fnlinea
                         AS iddepartamento,
                     d.fcprdlindesc
                         AS departamento,
                     (SELECT NVL (
                                 (SUM (
                                        (  (a.fnprcunit * a.ficantart)
                                         - a.fnpdctodescto)
                                      * (SELECT (csl_1 - fniva)
                                           FROM scventastienda.tcsucursal
                                          WHERE fidsucursal = pa_idsucursal))),
                                 csl_0p00)
                        FROM scventastienda.tadetpedidos a
                             INNER JOIN scventastienda.tapedidos b
                                 ON     a.fipais = b.fipais
                                    AND a.ficanal = b.ficanal
                                    AND a.fisucursal = b.fisucursal
                                    AND a.finopedido = b.finopedido
                             INNER JOIN scventastienda.tcproducto c
                                 ON a.fiprodid = c.fnsku
                             RIGHT JOIN scventastienda.tclinea dd
                                 ON c.fnlineasap = dd.fnlineaprod
                       WHERE     fitipoventa = csl_2
                             AND b.fipedstat = csl_1
                             AND a.fisucursal = pa_idsucursal
                             AND b.fcempnosurte =
                                 CAST (pa_empnosurte AS VARCHAR2 (10))
                             AND TO_DATE (b.fdfecsurt, 'dd/MM/yy') =
                                 TO_DATE (pa_fecha, 'yyyyMMdd')
                             AND dd.fnlinea = d.fnlinea)
                         AS "CREDITO",
                     (SELECT NVL (
                                 (SUM (
                                        (  (a.fnprcunit * a.ficantart)
                                         - a.fnpdctodescto)
                                      * (SELECT (csl_1 - fniva)
                                           FROM scventastienda.tcsucursal
                                          WHERE fidsucursal = pa_idsucursal))),
                                 csl_0p00)
                        FROM scventastienda.tadetpedidos a
                             INNER JOIN scventastienda.tapedidos b
                                 ON     a.fipais = b.fipais
                                    AND a.ficanal = b.ficanal
                                    AND a.fisucursal = b.fisucursal
                                    AND a.finopedido = b.finopedido
                             INNER JOIN scventastienda.tcproducto c
                                 ON a.fiprodid = c.fnsku
                             RIGHT JOIN scventastienda.tclinea dd
                                 ON c.fnlineasap = dd.fnlineaprod
                       WHERE     fitipoventa IN (csl_1, csl_4)
                             AND b.fipedstat = csl_1
                             AND a.fisucursal = pa_idsucursal
                             AND b.fcempnosurte =
                                 CAST (pa_empnosurte AS VARCHAR2 (10))
                             AND TO_DATE (b.fdfecsurt, 'dd/MM/yy') =
                                 TO_DATE (pa_fecha, 'yyyyMMdd')
                             AND dd.fnlinea = d.fnlinea)
                         AS "CONTADO"
                FROM scventastienda.tadetpedidos a
                     INNER JOIN scventastienda.tapedidos b
                         ON     a.fipais = b.fipais
                            AND a.ficanal = b.ficanal
                            AND a.fisucursal = b.fisucursal
                            AND a.finopedido = b.finopedido
                     INNER JOIN scventastienda.tcproducto c
                         ON a.fiprodid = c.fnsku
                     RIGHT JOIN scventastienda.tclinea d
                         ON c.fnlineasap = d.fnlineaprod
               WHERE     b.fipedstat = csl_1
                     AND a.fisucursal = pa_idsucursal
                     AND b.fcempnosurte = CAST (pa_empnosurte AS VARCHAR2 (10))
                     AND TO_DATE (b.fdfecsurt, 'dd/MM/yy') =
                         TO_DATE (pa_fecha, 'yyyyMMdd')
                     AND C.FNLINEASIE > csl_0
                     AND C.FNLINEASAP > csl_0
            GROUP BY d.fnlinea,
                     d.fcprdlindesc,
                     b.fisucursal,
                     b.fcempnosurte;

        pa_coderror := 200;
        pa_msgerror := 'OK';
    --SE OBTIENEN LOS OBJETIVOS
    EXCEPTION
        WHEN OTHERS
        THEN
            --Deshace los cambios
            ROLLBACK;
            pa_coderror := SQLCODE;     -- C�digo de error generado por Oracle
            pa_msgerror := SQLERRM;    -- Mensaje de error generado por Oracle
    END spgoalsdaily;

    PROCEDURE spgoalsweekly (pa_idsucursal   IN     INTEGER,
                             pa_empnosurte   IN     INTEGER,
                             pa_fecha        IN     INTEGER,
                             pa_curgoals        OUT SYS_REFCURSOR,
                             pa_coderror        OUT INTEGER,
                             pa_msgerror        OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_curgoals FOR
              SELECT d.fnlinea
                         AS iddepartamento,
                     d.fcprdlindesc
                         AS departamento,
                     CASE
                         WHEN a.fitipoventa = csl_2
                         THEN
                             CAST (
                                 SUM (  fnpedtotal
                                      * (SELECT (csl_1 - fniva)
                                           FROM scventastienda.tcsucursal
                                          WHERE fidsucursal = pa_idsucursal)) AS DECIMAL (10, 2))
                         ELSE
                             csl_0p00
                     END
                         AS "CREDITO",
                     CASE
                         WHEN a.fitipoventa = csl_1
                         THEN
                             CAST (
                                 SUM (  fnpedtotal
                                      * (SELECT (csl_1 - fniva)
                                           FROM scventastienda.tcsucursal
                                          WHERE fidsucursal = pa_idsucursal)) AS DECIMAL (10, 2))
                         ELSE
                             csl_0p00
                     END
                         AS "CONTADO"
                FROM scventastienda.tapedidos a
                     LEFT JOIN scventastienda.tadetpedidos b
                         ON     a.fipais = b.fipais
                            AND a.ficanal = b.ficanal
                            AND a.fisucursal = b.fisucursal
                            AND a.finopedido = b.finopedido
                     LEFT JOIN scventastienda.tcproducto c
                         ON b.fiprodid = c.fnsku
                     LEFT JOIN scventastienda.tclinea d
                         ON c.fnlineasie = d.fnlineaprod
               WHERE     a.fipedstat = csl_1
                     AND a.fisucursal = pa_idsucursal
                     AND a.fcempnosurte = pa_empnosurte
                     AND TO_CHAR (TO_DATE (a.fdfecsurt, 'dd/MM/yy'), 'WW') =
                         TO_CHAR (TO_DATE (pa_fecha, 'yyyyMMdd'), 'WW')
                     AND C.FNLINEASIE > csl_0
                     AND C.FNLINEASAP > csl_0
            GROUP BY a.fisucursal,
                     a.fdfecsurt,
                     a.fcempnosurte,
                     d.fnlinea,
                     d.fcprdlindesc,
                     a.fitipoventa;

        pa_coderror := 200;
        pa_msgerror := 'OK';
    --SE OBTIENEN LOS OBJETIVOS
    EXCEPTION
        WHEN OTHERS
        THEN
            --Deshace los cambios
            ROLLBACK;
            pa_coderror := SQLCODE;     -- C�digo de error generado por Oracle
            pa_msgerror := SQLERRM;    -- Mensaje de error generado por Oracle
    END spgoalsweekly;

    PROCEDURE splineas (cur_lineas    OUT SYS_REFCURSOR,
                        pa_mensaje    OUT VARCHAR2,
                        pa_coderror   OUT INTEGER,
                        pa_deserror   OUT VARCHAR2)
    IS
    BEGIN
        OPEN cur_lineas FOR   SELECT fnlinea, fcprdlindesc, fnlineaprod
                                FROM scventastienda.tclinea
                               WHERE FNLINEA > csl_0
                            ORDER BY fcprdlindesc;

        pa_coderror := 200;
        pa_mensaje := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_coderror := SQLCODE;
            pa_deserror := SQLERRM;
            pa_mensaje := 'OCURRIO UN ERROR AL CONSULTAR LAS LINEAS';
    END splineas;
END pagoals;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAGOALS" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAGOALS" TO "USRVENTAST";
