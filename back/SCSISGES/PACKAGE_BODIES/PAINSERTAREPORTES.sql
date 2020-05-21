--------------------------------------------------------
--  DDL for Package Body PAINSERTAREPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAINSERTAREPORTES" 
IS
    csl_01       CONSTANT PLS_INTEGER := -1;
    CSL_0        CONSTANT PLS_INTEGER := 0;
    CSL_1        CONSTANT PLS_INTEGER := 1;
    csl_2        CONSTANT PLS_INTEGER := 2;
    csl_3        CONSTANT PLS_INTEGER := 3;
    csl_4        CONSTANT PLS_INTEGER := 4;
    csl_5        CONSTANT PLS_INTEGER := 5;
    CSL_9        CONSTANT PLS_INTEGER := 9;
    CSL_7        CONSTANT PLS_INTEGER := 7;
    csl_23       CONSTANT PLS_INTEGER := 23;
    CSL_100000   CONSTANT PLS_INTEGER := 100000;
    vg_varSys             VARCHAR2 (5) := 'SYS';
    vg_USRFENIX           VARCHAR2 (10) := 'USRFENIX';
    vg_VarSemana          VARCHAR2 (5);
    vg_VarAnio            VARCHAR2 (5);

    PROCEDURE SPBORRATABLACAMPREP
    IS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAFXCAMPREPPF';
    END SPBORRATABLACAMPREP;

    PROCEDURE SPPENDXSURTIR (pa_mensaje    OUT VARCHAR2,
                             pa_coderror   OUT INTEGER,
                             pa_deserror   OUT VARCHAR2)
    IS
        --SE CREA UN TYPE DE TIPO CURSOR
        CURSOR CUR_RECCUOTAS
        IS
            SELECT DISTINCT vg_VarAnio || vg_VarSemana AS FITIEMPO,
                            csl_0                      AS FIIDCAMPANA,
                            C.FIPAISCU,
                            C.FICANALCU,
                            C.FISUCURSALCU,
                            C.FIFOLIO,
                            A.FISUCURSAL               AS FISUCGEST,
                            csl_23                     AS fiPLAZO,
                            csl_0                      AS FIIDPORTAFOLIO,
                            A.FCEMPNO,
                            csl_2                      AS FITIPOGESTIONID,
                            vg_VarAnio                 AS FIANIO,
                            vg_VarSemana               AS FISEMANA,
                            SYSDATE                    AS FDMODIFICO,
                            vg_USRFENIX                AS FCUSRMODIFICO
              FROM SCVENTASTIENDA.TAPREPARAME  A
                   INNER JOIN SCVENTASTIENDA.TAPEDIDOS B
                       ON A.FIFOLIOPARAM = B.FIFOLIOPARAM
                   LEFT JOIN SCVENTASTIENDA.TACENCTETIENDA C
                       ON     A.FINGCIOID = C.FINGCIOID
                          AND A.FINOTIENDA = C.FINOTIENDA
                          AND A.FICTEID = C.FICTEID
                          AND A.FIDIGITOVER = C.FIDIGITOVER
             WHERE     B.FIPEDSTAT = csl_0
                   AND B.FIFOLIOPARAM > CSL_0
                   AND a.finopedido > csl_01
                   AND A.FIPAIS > CSL_0
                   AND A.FICANAL > CSL_0
                   AND A.FISUCURSAL > CSL_0
                   AND A.FIFOLIOPARAM > CSL_0
                   AND A.FCEMPNO IS NOT NULL
                   AND C.FIPAISCU IS NOT NULL
                   AND C.FICANALCU > CSL_0
                   AND C.FISUCURSALCU > CSL_0
                   AND C.FIFOLIO > CSL_0
                   AND C.FINGCIOID > csl_0
                   AND C.FINOTIENDA > csl_0
                   AND C.FICTEID > csl_0
                   AND C.FIDIGITOVER > csl_0;

        --Declaracion del Type table del cursor CUR_RECCUOTAS
        TYPE typ_Cur_pagoCts IS TABLE OF CUR_RECCUOTAS%ROWTYPE
            INDEX BY PLS_INTEGER;

        --Variable de tipo tabla del cursor CUR_RECCUOTAS
        vlcur_pagoCtes   typ_Cur_pagoCts;
    --INICIO DE LA FUNCION
    BEGIN
        SELECT CASE
                   WHEN TRUNC (SYSDATE) >= FDFECHAM
                   THEN
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (SYSDATE))
                   ELSE
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (TK.FDFECHAM) - csl_3)
               END
                   FISEMANAACT,
               (SELECT FIANIO
                  FROM SCSISGES.TCCALENDARIOEKT T
                 WHERE T.FDFECHA = FDFECHAM)
                   AS ANIO
          INTO vg_VarSemana, vg_VarAnio
          FROM (SELECT MIN (FDFECHA) + csl_2 AS FDFECHAM /*obtener la fecha minima que es lunes y sumar dos para llegar a miercoles*/
                  FROM SCSISGES.TCCALENDARIOEKT CE
                 WHERE     CE.FIANIO = (SELECT FIANIO
                                          FROM SCSISGES.TCCALENDARIOEKT CE
                                         WHERE CE.FDFECHA = TRUNC (SYSDATE))
                       AND CE.FISEMANA =
                           (SELECT FISEMANA
                              FROM SCSISGES.TCCALENDARIOEKT CE
                             WHERE CE.FDFECHA = TRUNC (SYSDATE))) TK;


        IF LENGTH (vg_VarSemana) = CSL_1
        THEN
            vg_VarSemana := 0 || vg_VarSemana;
        END IF;



        --SE ABRE EL CURSOR
        OPEN CUR_RECCUOTAS;

        LOOP
            BEGIN
                FETCH CUR_RECCUOTAS BULK COLLECT INTO vlcur_pagoCtes;

                EXIT WHEN vlcur_pagoCtes.COUNT = CSL_0;

                FORALL vl_i IN vlcur_pagoCtes.FIRST .. vlcur_pagoCtes.COUNT
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.TAFXCAMPREPPF (fitiempo,
                                                        fiidcampana,
                                                        fipaiscu,
                                                        ficanalcu,
                                                        fisucursalcu,
                                                        fifoliocu,
                                                        fisucgest,
                                                        fiplazo,
                                                        fiidportafolio,
                                                        fiidempleado,
                                                        fitipogestionid,
                                                        fianio,
                                                        fisemana,
                                                        fdmodifico,
                                                        fcusrmodifico)
                         VALUES (vlcur_pagoCtes (vl_i).fitiempo,
                                 vlcur_pagoCtes (vl_i).fiidcampana,
                                 vlcur_pagoCtes (vl_i).fipaiscu,
                                 vlcur_pagoCtes (vl_i).ficanalcu,
                                 vlcur_pagoCtes (vl_i).fisucursalcu,
                                 vlcur_pagoCtes (vl_i).FIFOLIO,
                                 vlcur_pagoCtes (vl_i).fisucgest,
                                 vlcur_pagoCtes (vl_i).fiplazo,
                                 vlcur_pagoCtes (vl_i).fiidportafolio,
                                 vlcur_pagoCtes (vl_i).FCEMPNO,
                                 vlcur_pagoCtes (vl_i).fitipogestionid,
                                 vlcur_pagoCtes (vl_i).fianio,
                                 vlcur_pagoCtes (vl_i).fisemana,
                                 vlcur_pagoCtes (vl_i).fdmodifico,
                                 vlcur_pagoCtes (vl_i).fcusrmodifico);
            EXCEPTION
                WHEN OTHERS
                THEN
                    pa_coderror := SQLCODE;
                    pa_deserror := SUBSTR (SQLERRM, 0, 100);
                    pa_mensaje :=
                        'OCURRIO UN ERROR AL insertar en SPPENDXSURTIR';
            END;

            COMMIT;
            vlcur_pagoCtes.DELETE;
        END LOOP;

        CLOSE CUR_RECCUOTAS;
    END SPPENDXSURTIR;

    PROCEDURE SPSOLICITUDES (pa_mensaje    OUT VARCHAR2,
                             pa_coderror   OUT INTEGER,
                             pa_deserror   OUT VARCHAR2)
    IS
        CURSOR CUR_RECCUOTAS
        IS
            SELECT vg_VarAnio || vg_VarSemana AS FITIEMPO,
                   csl_0                      AS FIIDCAMPANA,
                   C.FIPAISCU,
                   C.FICANALCU,
                   C.FISUCURSALCU,
                   C.FIFOLIO,
                   A.FISUCURSAL               AS FISUCGEST,
                   csl_23                     AS fiPLAZO,
                   csl_0                      AS FIIDPORTAFOLIO,
                   A.FCEMPNO,
                   csl_3                      AS FITIPOGESTIONID,
                   vg_VarAnio                 AS FIANIO,
                   vg_VarSemana               AS FISEMANA,
                   SYSDATE                    AS FDMODIFICO,
                   vg_USRFENIX                AS FCUSRMODIFICO
              FROM SCVENTASTIENDA.tasolicitudes  a
                   INNER JOIN SCVENTASTIENDA.tacredctectes b
                       ON     a.fiidnegocio = b.fiidnegocio
                          AND a.fiidtienda = b.fiidtienda
                          AND a.fiidcliente = b.fiidcliente
                   INNER JOIN SCVENTASTIENDA.tacenctetienda c
                       ON     b.fingcioid = c.fingcioid
                          AND b.finotienda = c.finotienda
                          AND b.ficteid = c.ficteid
                          AND b.fidigitover = c.fidigitover
                   INNER JOIN SCVENTASTIENDA.taclientes tacl
                       ON     c.fingcioid = tacl.fingcioid
                          AND c.finotienda = tacl.finotienda
                          AND c.ficteid = tacl.ficteid
                          AND c.fidigitover = tacl.fidigitover
                   INNER JOIN SCVENTASTIENDA.tacredsolicitud tacr
                       ON (    tacr.fisolicitudid = a.fisolicitudid
                           AND b.fisucursal = tacr.fisucursal)
                   LEFT JOIN SCVENTASTIENDA.tapedidos ped
                       ON     c.fingcioid = ped.fingcioid
                          AND c.finotienda = ped.finotienda
                          AND c.ficteid = ped.ficteid
                          AND c.fidigitover = ped.fidigitover
             WHERE     ped.finopedido IS NULL
                   AND (   (    tacr.fistat = CSL_9
                            AND tacr.fdfecstat > SYSDATE - CSL_7)
                        OR tacr.fistat <> CSL_9)
                   AND TACR.FISUCURSAL > CSL_0
                   AND TACR.FISOLICITUDID > CSL_0
                   AND A.FCEMPNO IS NOT NULL
                   AND A.FCEMPNO <> vg_varSys
                   AND TACL.FIPAIS > CSL_0
                   AND TACL.FICANAL > CSL_0
                   AND TACL.FISUCURSAL > CSL_0
                   AND TACL.FINGCIOID > CSL_0
                   AND TACL.FINOTIENDA > CSL_0
                   AND TACL.FICTEID > CSL_0
                   AND TACL.FIDIGITOVER > CSL_0
                   AND B.FIIDNEGOCIO > CSL_0
                   AND B.FIIDTIENDA > CSL_0
                   AND B.FIIDCLIENTE > CSL_0;



        --Declaracion del Type table del cursor CUR_RECCUOTAS
        TYPE typ_Cur_pagoCts IS TABLE OF CUR_RECCUOTAS%ROWTYPE
            INDEX BY PLS_INTEGER;

        --Variable de tipo tabla del cursor CUR_RECCUOTAS
        vlcur_pagoCtes   typ_Cur_pagoCts;
    --INICIO DE LA FUNCION
    BEGIN
        SELECT CASE
                   WHEN TRUNC (SYSDATE) >= FDFECHAM
                   THEN
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (SYSDATE))
                   ELSE
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (TK.FDFECHAM) - csl_3)
               END
                   FISEMANAACT,
               (SELECT FIANIO
                  FROM SCSISGES.TCCALENDARIOEKT T
                 WHERE T.FDFECHA = FDFECHAM)
                   AS ANIO
          INTO vg_VarSemana, vg_VarAnio
          FROM (SELECT MIN (FDFECHA) + csl_2 AS FDFECHAM /*obtener la fecha minima que es lunes y sumar dos para llegar a miercoles*/
                  FROM SCSISGES.TCCALENDARIOEKT CE
                 WHERE     CE.FIANIO = (SELECT FIANIO
                                          FROM SCSISGES.TCCALENDARIOEKT CE
                                         WHERE CE.FDFECHA = TRUNC (SYSDATE))
                       AND CE.FISEMANA =
                           (SELECT FISEMANA
                              FROM SCSISGES.TCCALENDARIOEKT CE
                             WHERE CE.FDFECHA = TRUNC (SYSDATE))) TK;

        IF LENGTH (vg_VarSemana) = CSL_1
        THEN
            vg_VarSemana := 0 || vg_VarSemana;
        END IF;

        --SE ABRE EL CURSOR
        OPEN CUR_RECCUOTAS;

        LOOP
            BEGIN
                FETCH CUR_RECCUOTAS BULK COLLECT INTO vlcur_pagoCtes;

                EXIT WHEN vlcur_pagoCtes.COUNT = CSL_0;

                FORALL vl_i IN vlcur_pagoCtes.FIRST .. vlcur_pagoCtes.COUNT
                  SAVE EXCEPTIONS
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.TAFXCAMPREPPF (fitiempo,
                                                        fiidcampana,
                                                        fipaiscu,
                                                        ficanalcu,
                                                        fisucursalcu,
                                                        fifoliocu,
                                                        fisucgest,
                                                        fiplazo,
                                                        fiidportafolio,
                                                        fiidempleado,
                                                        fitipogestionid,
                                                        fianio,
                                                        fisemana,
                                                        fdmodifico,
                                                        fcusrmodifico)
                         VALUES (vlcur_pagoCtes (vl_i).fitiempo,
                                 vlcur_pagoCtes (vl_i).fiidcampana,
                                 vlcur_pagoCtes (vl_i).fipaiscu,
                                 vlcur_pagoCtes (vl_i).ficanalcu,
                                 vlcur_pagoCtes (vl_i).fisucursalcu,
                                 vlcur_pagoCtes (vl_i).FIFOLIO,
                                 vlcur_pagoCtes (vl_i).fisucgest,
                                 vlcur_pagoCtes (vl_i).fiplazo,
                                 vlcur_pagoCtes (vl_i).fiidportafolio,
                                 vlcur_pagoCtes (vl_i).FCEMPNO,
                                 vlcur_pagoCtes (vl_i).fitipogestionid,
                                 vlcur_pagoCtes (vl_i).fianio,
                                 vlcur_pagoCtes (vl_i).fisemana,
                                 vlcur_pagoCtes (vl_i).fdmodifico,
                                 vlcur_pagoCtes (vl_i).fcusrmodifico);
            EXCEPTION
                WHEN OTHERS
                THEN
                    pa_coderror := SQLCODE;
                    pa_deserror := SUBSTR (SQLERRM, 0, 100);
                    pa_mensaje :=
                        'OCURRIO UN ERROR AL insertar en SPSOLICITUDES';
            END;

            COMMIT;
            vlcur_pagoCtes.DELETE;
        END LOOP;

        CLOSE CUR_RECCUOTAS;
    END SPSOLICITUDES;

    PROCEDURE SPPRESUPUESTOS (pa_mensaje    OUT VARCHAR2,
                              pa_coderror   OUT INTEGER,
                              pa_deserror   OUT VARCHAR2)
    IS
        CURSOR CUR_RECCUOTAS
        IS
            SELECT DISTINCT vg_VarAnio || vg_VarSemana AS FITIEMPO,
                            csl_0                      AS FIIDCAMPANA,
                            C.FIPAISCU,
                            C.FICANALCU,
                            C.FISUCURSALCU,
                            C.FIFOLIO,
                            A.FISUCURSAL               AS FISUCGEST,
                            csl_23                     AS fiPLAZO,
                            csl_0                      AS FIIDPORTAFOLIO,
                            A.FCEMPNO,
                            csl_4                      AS FITIPOGESTIONID,
                            vg_VarAnio                 AS FIANIO,
                            vg_VarSemana               AS FISEMANA,
                            SYSDATE                    AS FDMODIFICO,
                            vg_USRFENIX                AS FCUSRMODIFICO
              FROM SCVENTASTIENDA.TAPREPARAME  A
                   LEFT JOIN SCVENTASTIENDA.TAPEDIDOS B
                       ON A.FIFOLIOPARAM = B.FIFOLIOPARAM
                   LEFT JOIN SCVENTASTIENDA.TACENCTETIENDA C
                       ON     A.FINGCIOID = C.FINGCIOID
                          AND A.FINOTIENDA = C.FINOTIENDA
                          AND A.FICTEID = C.FICTEID
                          AND A.FIDIGITOVER = C.FIDIGITOVER
             WHERE     B.FINOPEDIDO IS NULL
                   AND A.FICTEID <> CSL_100000
                   AND a.finopedido > csl_01
                   AND a.fipais > csl_0
                   AND a.ficanal > csl_0
                   AND a.fisucursal > csl_0
                   AND a.fifolioparam > csl_0
                   AND C.FIPAISCU IS NOT NULL
                   AND C.FINGCIOID > csl_0
                   AND C.FINOTIENDA > csl_0
                   AND C.FICTEID > csl_0
                   AND C.FIDIGITOVER > csl_0;

        --Declaracion del Type table del cursor CUR_RECCUOTAS
        TYPE typ_Cur_pagoCts IS TABLE OF CUR_RECCUOTAS%ROWTYPE
            INDEX BY PLS_INTEGER;

        --Variable de tipo tabla del cursor CUR_RECCUOTAS
        vlcur_pagoCtes   typ_Cur_pagoCts;
    --INICIO DE LA FUNCION
    BEGIN
        SELECT CASE
                   WHEN TRUNC (SYSDATE) >= FDFECHAM
                   THEN
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (SYSDATE))
                   ELSE
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (TK.FDFECHAM) - csl_3)
               END
                   FISEMANAACT,
               (SELECT FIANIO
                  FROM SCSISGES.TCCALENDARIOEKT T
                 WHERE T.FDFECHA = FDFECHAM)
                   AS ANIO
          INTO vg_VarSemana, vg_VarAnio
          FROM (SELECT MIN (FDFECHA) + csl_2 AS FDFECHAM /*obtener la fecha minima que es lunes y sumar dos para llegar a miercoles*/
                  FROM SCSISGES.TCCALENDARIOEKT CE
                 WHERE     CE.FIANIO = (SELECT FIANIO
                                          FROM SCSISGES.TCCALENDARIOEKT CE
                                         WHERE CE.FDFECHA = TRUNC (SYSDATE))
                       AND CE.FISEMANA =
                           (SELECT FISEMANA
                              FROM SCSISGES.TCCALENDARIOEKT CE
                             WHERE CE.FDFECHA = TRUNC (SYSDATE))) TK;

        IF LENGTH (vg_VarSemana) = CSL_1
        THEN
            vg_VarSemana := 0 || vg_VarSemana;
        END IF;

        --SE ABRE EL CURSOR
        OPEN CUR_RECCUOTAS;

        LOOP
            BEGIN
                FETCH CUR_RECCUOTAS BULK COLLECT INTO vlcur_pagoCtes;

                EXIT WHEN vlcur_pagoCtes.COUNT = CSL_0;

                FORALL vl_i IN vlcur_pagoCtes.FIRST .. vlcur_pagoCtes.COUNT
                  SAVE EXCEPTIONS
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.TAFXCAMPREPPF (fitiempo,
                                                        fiidcampana,
                                                        fipaiscu,
                                                        ficanalcu,
                                                        fisucursalcu,
                                                        fifoliocu,
                                                        fisucgest,
                                                        fiplazo,
                                                        fiidportafolio,
                                                        fiidempleado,
                                                        fitipogestionid,
                                                        fianio,
                                                        fisemana,
                                                        fdmodifico,
                                                        fcusrmodifico)
                         VALUES (vlcur_pagoCtes (vl_i).fitiempo,
                                 vlcur_pagoCtes (vl_i).fiidcampana,
                                 vlcur_pagoCtes (vl_i).fipaiscu,
                                 vlcur_pagoCtes (vl_i).ficanalcu,
                                 vlcur_pagoCtes (vl_i).fisucursalcu,
                                 vlcur_pagoCtes (vl_i).FIFOLIO,
                                 vlcur_pagoCtes (vl_i).fisucgest,
                                 vlcur_pagoCtes (vl_i).fiplazo,
                                 vlcur_pagoCtes (vl_i).fiidportafolio,
                                 vlcur_pagoCtes (vl_i).FCEMPNO,
                                 vlcur_pagoCtes (vl_i).fitipogestionid,
                                 vlcur_pagoCtes (vl_i).fianio,
                                 vlcur_pagoCtes (vl_i).fisemana,
                                 vlcur_pagoCtes (vl_i).fdmodifico,
                                 vlcur_pagoCtes (vl_i).fcusrmodifico);
            EXCEPTION
                WHEN OTHERS
                THEN
                    pa_coderror := SQLCODE;
                    pa_deserror := SUBSTR (SQLERRM, 0, 100);
                    pa_mensaje :=
                        'OCURRIO UN ERROR AL insertar en SPPRESUPUESTOS';
            END;

            COMMIT;

            vlcur_pagoCtes.DELETE;
        END LOOP;

        CLOSE CUR_RECCUOTAS;
    END SPPRESUPUESTOS;

    PROCEDURE SPPROMOCIONES (pa_mensaje    OUT VARCHAR2,
                             pa_coderror   OUT INTEGER,
                             pa_deserror   OUT VARCHAR2)
    IS
        CURSOR CUR_RECCUOTAS
        IS
            SELECT vg_VarAnio || vg_VarSemana AS FITIEMPO,
                   A.FIIDCAMPANA,
                   A.FIPAIS,
                   A.FICANAL,
                   A.FISUCURSAL,
                   A.FIFOLIO,
                   B.FIIDSUCURSAL,
                   B.FIIDPUESTO,
                   B.FIIDPORTAFOLIO,
                   B.FIIDEMPLEADO,
                   csl_5                      AS FITIPOGESTIONID,
                   vg_VarAnio                 AS FIANIO,
                   vg_VarSemana               AS FISEMANA,
                   SYSDATE                    AS FDMODIFICO,
                   vg_USRFENIX                AS FCUSRMODIFICO
              FROM SCSISGES.TACAMPANACTE  A
                   INNER JOIN SCSISGES.TAFXCARTERAPF B
                       ON     A.FIPAIS = B.FIPAIS
                          AND A.FICANAL = B.FICANAL
                          AND A.FISUCURSAL = B.FISUCURSAL
                          AND A.FIFOLIO = B.FIFOLIO
             WHERE     a.fiidcampana > csl_0
                   AND a.fipais > csl_0
                   AND A.FICANAL > csl_0
                   AND A.FISUCURSAL > csl_0
                   AND A.FIFOLIO > csl_0
                   AND b.fiidsucursal > csl_0;

        --Declaracion del Type table del cursor CUR_RECCUOTAS
        TYPE typ_Cur_pagoCts IS TABLE OF CUR_RECCUOTAS%ROWTYPE
            INDEX BY PLS_INTEGER;

        --Variable de tipo tabla del cursor CUR_RECCUOTAS
        vlcur_pagoCtes   typ_Cur_pagoCts;
    --INICIO DE LA FUNCION
    BEGIN
        SELECT CASE
                   WHEN TRUNC (SYSDATE) >= FDFECHAM
                   THEN
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (SYSDATE))
                   ELSE
                       (SELECT FISEMANA
                          FROM SCSISGES.TCCALENDARIOEKT
                         WHERE TRUNC (FDFECHA) = TRUNC (TK.FDFECHAM) - csl_3)
               END
                   FISEMANAACT,
               (SELECT FIANIO
                  FROM SCSISGES.TCCALENDARIOEKT T
                 WHERE T.FDFECHA = FDFECHAM)
                   AS ANIO
          INTO vg_VarSemana, vg_VarAnio
          FROM (SELECT MIN (FDFECHA) + csl_2 AS FDFECHAM /*obtener la fecha minima que es lunes y sumar dos para llegar a miercoles*/
                  FROM SCSISGES.TCCALENDARIOEKT CE
                 WHERE     CE.FIANIO = (SELECT FIANIO
                                          FROM SCSISGES.TCCALENDARIOEKT CE
                                         WHERE CE.FDFECHA = TRUNC (SYSDATE))
                       AND CE.FISEMANA =
                           (SELECT FISEMANA
                              FROM SCSISGES.TCCALENDARIOEKT CE
                             WHERE CE.FDFECHA = TRUNC (SYSDATE))) TK;

        IF LENGTH (vg_VarSemana) = CSL_1
        THEN
            vg_VarSemana := 0 || vg_VarSemana;
        END IF;

        --SE ABRE EL CURSOR
        OPEN CUR_RECCUOTAS;

        LOOP
            BEGIN
                FETCH CUR_RECCUOTAS BULK COLLECT INTO vlcur_pagoCtes;

                EXIT WHEN vlcur_pagoCtes.COUNT = CSL_0;

                FORALL vl_i IN vlcur_pagoCtes.FIRST .. vlcur_pagoCtes.COUNT
                  SAVE EXCEPTIONS
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.TAFXCAMPREPPF (fitiempo,
                                                        fiidcampana,
                                                        fipaiscu,
                                                        ficanalcu,
                                                        fisucursalcu,
                                                        fifoliocu,
                                                        fisucgest,
                                                        fiplazo,
                                                        fiidportafolio,
                                                        fiidempleado,
                                                        fitipogestionid,
                                                        fianio,
                                                        fisemana,
                                                        fdmodifico,
                                                        fcusrmodifico)
                         VALUES (vlcur_pagoCtes (vl_i).fitiempo,
                                 vlcur_pagoCtes (vl_i).fiidcampana,
                                 vlcur_pagoCtes (vl_i).fipais,
                                 vlcur_pagoCtes (vl_i).ficanal,
                                 vlcur_pagoCtes (vl_i).fisucursal,
                                 vlcur_pagoCtes (vl_i).FIFOLIO,
                                 vlcur_pagoCtes (vl_i).FIIDSUCURSAL,
                                 vlcur_pagoCtes (vl_i).FIIDPUESTO,
                                 vlcur_pagoCtes (vl_i).fiidportafolio,
                                 vlcur_pagoCtes (vl_i).FIIDEMPLEADO,
                                 vlcur_pagoCtes (vl_i).fitipogestionid,
                                 vlcur_pagoCtes (vl_i).fianio,
                                 vlcur_pagoCtes (vl_i).fisemana,
                                 vlcur_pagoCtes (vl_i).fdmodifico,
                                 vlcur_pagoCtes (vl_i).fcusrmodifico);
            EXCEPTION
                WHEN OTHERS
                THEN
                    pa_coderror := SQLCODE;
                    pa_deserror := SUBSTR (SQLERRM, 0, 100);
                    pa_mensaje :=
                        'OCURRIO UN ERROR AL insertar en SPPROMOCIONES';
            END;

            COMMIT;
            vlcur_pagoCtes.DELETE;
        END LOOP;

        CLOSE CUR_RECCUOTAS;
    END SPPROMOCIONES;
END PAINSERTAREPORTES;

/

  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRVENTAST";
