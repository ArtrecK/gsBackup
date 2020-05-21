--------------------------------------------------------
--  DDL for Package Body PAFXGESTIONDIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAFXGESTIONDIA" 
AS
    -- Consultas para contar gestiones por sucursal, regional, zonal, nacional
    -- Author  : 909511 - MJGM

    CSL_0     CONSTANT INTEGER := 0;
    CSL_1     CONSTANT INTEGER := 1;
    CSL_2     CONSTANT INTEGER := 2;
    CSL_3     CONSTANT INTEGER := 3;
    CSL_4     CONSTANT INTEGER := 4;
    CSL_5     CONSTANT INTEGER := 5;
    CSL_6     CONSTANT INTEGER := 6;
    CSL_7     CONSTANT INTEGER := 7;
    CSL_9     CONSTANT INTEGER := 9;
    CSL_78    CONSTANT INTEGER := 78;
    CSL_EKT   CONSTANT VARCHAR2 (3) := 'EKT';

    PROCEDURE SPNUMGESTIONESXNIV (PA_NIVEL        IN     NUMBER,
                                  PA_IDCONSULTA   IN     NUMBER,
                                  PA_CURDATOS        OUT SYS_REFCURSOR,
                                  PA_OCODIGO         OUT INTEGER,
                                  PA_OMENSAJE        OUT VARCHAR2,
                                  PA_ODETALLE        OUT VARCHAR2)
    AS
    -- Consultas para contar gestiones por nivel
    -- Author  : 909511 - MJGM
    -- Parameter:  ID nivel 1.-Vendedor, 2.- Sucursal, 3.-Regional, 4.-Zonal, 5.- Pais.
    --             ID Consulta, identificador del  CECO
    -- Return: Cursor con acumulados
    BEGIN
        CASE PA_NIVEL
            WHEN CSL_1
            THEN
                PA_CURDATOS := FNGETGESTIONEMP (PA_IDCONSULTA);
            WHEN CSL_2
            THEN
                PA_CURDATOS := FNGETGESTIONSUC (PA_IDCONSULTA);
            WHEN CSL_3
            THEN
                PA_CURDATOS := FNGETGESTIONREGI (PA_IDCONSULTA);
            WHEN CSL_4
            THEN
                PA_CURDATOS := FNGETGESTIONZONA (PA_IDCONSULTA);
            WHEN CSL_5
            THEN
                PA_CURDATOS := FNGETGESTIONPAIS (PA_IDCONSULTA);
            ELSE
                PA_CURDATOS := FNGETCURDATOSVAC ();
        END CASE;


        PA_OCODIGO := CSL_0;
        PA_OMENSAJE := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            PA_CURDATOS := FNGETCURDATOSVAC ();
            PA_OCODIGO := SQLCODE;
            PA_OMENSAJE := SQLERRM;
            PA_ODETALLE := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    END SPNUMGESTIONESXNIV;

    FUNCTION FNGETGESTIONEMP (PA_IDCONSULTA NUMBER)
        RETURN SYS_REFCURSOR
    IS
        -- Consultas para contar gestiones acumuladas por empleado
        -- Author  : 909511 - MJGM
        -- parameter: ID del empleado
        -- return:   Cursor con el empleado consultado.
        PA_DATA           SYS_REFCURSOR;

        CURSOR CUR_EMPLEADOS
        IS
            SELECT TE.FNEMPLEADO,
                   TS.FIIDSUCURSAL,
                      TE.FCNOMBRE
                   || ' '
                   || TE.FCAPATERNO
                   || ' '
                   || TE.FCAMATERNO
                       AS EMPLEADO,
                   TS.FINUMCECOSUC
                       AS FIIDCECO,
                   TS.FIIDREGION
                       AS IDREGION,
                   TS.FIIDZONA
                       AS IDZONA,
                   TS.FIIDPAIS
                       AS IDPAIS
              FROM SCSISGES.TCFXSUCURSAL TS, SCSISGES.TAEMPLEADOPF TE
             WHERE     TE.FNEMPLEADO = PA_IDCONSULTA
                   AND TS.FINUMCECOSUC = TE.FNCC + CSL_0
                   AND TS.FIIDPAIS > CSL_0
                   AND TS.FIIDTERRITORIO > CSL_0
                   AND TS.FIIDSUCURSAL > CSL_0
                   AND TS.FIIDZONA > CSL_0
                   AND TE.FISITUACION = CSL_1
                   AND TE.FNEMPLEADO > CSL_0
                   AND TE.FCNEGOCIO = CSL_EKT
                   AND TE.FIIDPERFIL = CSL_1;

        TYPE typ_datosEmp IS TABLE OF CUR_EMPLEADOS%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcoll_datosEmp   typ_datosEmp;
        vltab_datos       SCSISGES.TYTBGESTIONACUM;
        vl_curtest        SYS_REFCURSOR;
    BEGIN
        -- Inicializacion tabla para datos de salida
        vltab_datos := NEW SCSISGES.TYTBGESTIONACUM ();

        OPEN CUR_EMPLEADOS;

        LOOP
            FETCH CUR_EMPLEADOS BULK COLLECT INTO vlcoll_datosEmp;

            EXIT WHEN vlcoll_datosEmp.COUNT = 0;

            FOR vl_i IN vlcoll_datosEmp.FIRST .. vlcoll_datosEmp.LAST
            LOOP
                vltab_datos.EXTEND;
                vltab_datos (vltab_datos.LAST) :=
                    NEW SCSISGES.TYOBGESTIONACUM (
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).EMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDCECO,
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                            vlcoll_datosEmp (vl_i).IDREGION,
                            vlcoll_datosEmp (vl_i).IDZONA,
                            vlcoll_datosEmp (vl_i).IDPAIS,
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),     --PENDIENTES POR SURTIR (EMPLEADO)
                            SCSISGES.FNCOPPXSTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),               --SOLICITUDES (EMPLEADO)
                            SCSISGES.FNCOSOLICTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_4),              --PRESUPUESTOS (EMPLEADO)
                            SCSISGES.FNCOPRESUTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_5),               --PROMOCIONES (EMPLEADO)
                            SCSISGES.FNCOPROMOCTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            CSL_0,
                            CSL_0,                     --CON PEDIDO (EMPLEADO)
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_6),                --SIN PEDIDO (EMPLEADO)
                            SCSISGES.FNCOSINPEDTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_1),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),
                            SCSISGES.FNCOEVENTOSDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOALERTASDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO));
            END LOOP;
        END LOOP;

        CLOSE CUR_EMPLEADOS;

        OPEN PA_DATA FOR                                            --EMPLEADO
            SELECT QPRINCIPAL.FNEMPLEADO
                       AS FIIDENTIFICADOR,
                   QPRINCIPAL.EMPLEADO
                       AS FCDESCRIPCION,
                   (SELECT FNPENDIENTESGES
                      FROM TABLE (vltab_datos) PG
                     WHERE PG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNPENDIENTESGES,
                   (SELECT FNPENDIENTESTOTAL
                      FROM TABLE (vltab_datos) QPT
                     WHERE QPT.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNPENDIENTESTOTAL,
                   (SELECT FNSOLICITUDESGES
                      FROM TABLE (vltab_datos) PRG
                     WHERE PRG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNSOLICITUDESGES,
                   (SELECT FNSOLICITUDESTOTAL
                      FROM TABLE (vltab_datos) ST
                     WHERE ST.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNSOLICITUDESTOTAL,
                   (SELECT FNPRESUPUESTOSGES
                      FROM TABLE (vltab_datos) PROMG
                     WHERE PROMG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNPRESUPUESTOSGES,
                   (SELECT FNPRESUPUESTOSTOTAL
                      FROM TABLE (vltab_datos) PRT
                     WHERE PRT.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNPRESUPUESTOSTOTAL,
                   (SELECT FNPROMOCIONESGES
                      FROM TABLE (vltab_datos) REACG
                     WHERE REACG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNPROMOCIONESGES,
                   (SELECT FNPROMOCIONESTOTAL
                      FROM TABLE (vltab_datos) PROMT
                     WHERE PROMT.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNPROMOCIONESTOTAL,
                   (SELECT FNCONPEDIDOGES
                      FROM TABLE (vltab_datos) CG
                     WHERE CG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNCONPEDIDOGES,
                   (SELECT FNCONPEDIDOTOTAL
                      FROM TABLE (vltab_datos) CONPED
                     WHERE CONPED.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNCONPEDIDOTOTAL,
                   (SELECT FNSINPEDIDOGES
                      FROM TABLE (vltab_datos) SG
                     WHERE SG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNSINPEDIDOGES,
                   (SELECT FNSINPEDIDOTOTAL
                      FROM TABLE (vltab_datos) SINPED
                     WHERE SINPED.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       AS FNSINPEDIDOTOTAL,
                   (SELECT FNLLAMADA
                      FROM TABLE (vltab_datos) QTEL
                     WHERE QTEL.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       FNLLAMADA,
                   (SELECT FNCAMBACEO
                      FROM TABLE (vltab_datos) QCAM
                     WHERE QCAM.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       FNCAMBACEO,
                   (SELECT FNVISITA
                      FROM TABLE (vltab_datos) QVIS
                     WHERE QVIS.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       FNVISITA,
                   (SELECT FNEVENTOS
                      FROM TABLE (vltab_datos) QEVE
                     WHERE QEVE.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       FNEVENTOS,
                   (SELECT FNALERTAS
                      FROM TABLE (vltab_datos) QALER
                     WHERE QALER.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                       FNALERTAS
              FROM (SELECT DISTINCT
                           FIIDENTIFICADOR AS FNEMPLEADO,
                           FCDESCRIPCION   AS EMPLEADO
                      FROM TABLE (vltab_datos)) QPRINCIPAL;

        RETURN PA_DATA;
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAFXGESTIONDIARIA.FNGETGESTIONEMP');
            RETURN NULL;
    END FNGETGESTIONEMP;

    FUNCTION FNGETGESTIONSUC (PA_IDCONSULTA NUMBER)
        RETURN SYS_REFCURSOR
    IS
        -- Consultas para contar gestiones acumuladas por sucursal
        -- Author  : 909511 - MJGM
        -- parameter: ID de sucursal
        -- return:   Cursor con empleados y totales de sucursal
        PA_DATA           SYS_REFCURSOR;

        CURSOR CUR_EMPLEADOS
        IS
            SELECT TE.FNEMPLEADO,
                   TS.FIIDSUCURSAL,
                      TE.FCNOMBRE
                   || ' '
                   || TE.FCAPATERNO
                   || ' '
                   || TE.FCAMATERNO
                       AS EMPLEADO,
                   TS.FINUMCECOSUC
                       AS FIIDCECO,
                   TS.FIIDREGION
                       AS IDREGION,
                   TS.FIIDZONA
                       AS IDZONA,
                   TS.FIIDPAIS
                       AS IDPAIS
              FROM SCSISGES.TCFXSUCURSAL TS, SCSISGES.TAEMPLEADOPF TE
             WHERE     TS.FIIDSUCURSAL = PA_IDCONSULTA
                   AND TS.FINUMCECOSUC = TE.FNCC + CSL_0
                   AND TS.FIIDPAIS > CSL_0
                   AND TS.FIIDTERRITORIO > CSL_0
                   AND TS.FIIDSUCURSAL > CSL_0
                   AND TS.FIIDZONA > CSL_0
                   AND TE.FISITUACION = CSL_1
                   AND TE.FNEMPLEADO > CSL_0
                   AND TE.FCNEGOCIO = CSL_EKT
                   AND TE.FIIDPERFIL = CSL_1;

        TYPE typ_datosEmp IS TABLE OF CUR_EMPLEADOS%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcoll_datosEmp   typ_datosEmp;
        vltab_datos       SCSISGES.TYTBGESTIONACUM;
        vl_curtest        SYS_REFCURSOR;
    BEGIN
        -- Inicializacion tabla para datos de salida
        vltab_datos := NEW SCSISGES.TYTBGESTIONACUM ();

        OPEN CUR_EMPLEADOS;

        LOOP
            FETCH CUR_EMPLEADOS BULK COLLECT INTO vlcoll_datosEmp;

            EXIT WHEN vlcoll_datosEmp.COUNT = 0;

            FOR vl_i IN vlcoll_datosEmp.FIRST .. vlcoll_datosEmp.LAST
            LOOP
                vltab_datos.EXTEND;
                vltab_datos (vltab_datos.LAST) :=
                    NEW SCSISGES.TYOBGESTIONACUM (
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).EMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDCECO,
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                            vlcoll_datosEmp (vl_i).IDREGION,
                            vlcoll_datosEmp (vl_i).IDZONA,
                            vlcoll_datosEmp (vl_i).IDPAIS,
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),     --PENDIENTES POR SURTIR (SUCURSAL)
                            SCSISGES.FNCOPPXSTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),               --SOLICITUDES (SUCURSAL)
                            SCSISGES.FNCOSOLICTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_4),              --PRESUPUESTOS (SUCURSAL)
                            SCSISGES.FNCOPRESUTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_5),               --PROMOCIONES (SUCURSAL)
                            SCSISGES.FNCOPROMOCTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            CSL_0,
                            CSL_0,                     --CON PEDIDO (SUCURSAL)
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_6),                --SIN PEDIDO (SUCURSAL)
                            SCSISGES.FNCOSINPEDTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_1),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),
                            SCSISGES.FNCOEVENTOSDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOALERTASDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO));
            END LOOP;
        END LOOP;

        CLOSE CUR_EMPLEADOS;

        OPEN PA_DATA FOR                                            --SUCURSAL
              SELECT FIIDENTIFICADOR,
                     FCDESCRIPCION,
                     FNPENDIENTESGES,
                     FNPENDIENTESTOTAL,
                     FNSOLICITUDESGES,
                     FNSOLICITUDESTOTAL,
                     FNPRESUPUESTOSGES,
                     FNPRESUPUESTOSTOTAL,
                     FNPROMOCIONESGES,
                     FNPROMOCIONESTOTAL,
                     FNCONPEDIDOGES,
                     FNCONPEDIDOTOTAL,
                     FNSINPEDIDOGES,
                     FNSINPEDIDOTOTAL,
                     FNLLAMADA,
                     FNCAMBACEO,
                     FNVISITA,
                     FNEVENTOS,
                     FNALERTAS
                FROM (SELECT QPRINCIPAL.FNEMPLEADO
                                 AS FIIDENTIFICADOR,
                             QPRINCIPAL.EMPLEADO
                                 AS FCDESCRIPCION,
                             (SELECT FNPENDIENTESGES
                                FROM TABLE (vltab_datos) PG
                               WHERE PG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNPENDIENTESGES,
                             (SELECT FNPENDIENTESTOTAL
                                FROM TABLE (vltab_datos) QPT
                               WHERE QPT.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT FNSOLICITUDESGES
                                FROM TABLE (vltab_datos) PRG
                               WHERE PRG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNSOLICITUDESGES,
                             (SELECT FNSOLICITUDESTOTAL
                                FROM TABLE (vltab_datos) ST
                               WHERE ST.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT FNPRESUPUESTOSGES
                                FROM TABLE (vltab_datos) PROMG
                               WHERE PROMG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT FNPRESUPUESTOSTOTAL
                                FROM TABLE (vltab_datos) PRT
                               WHERE PRT.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT FNPROMOCIONESGES
                                FROM TABLE (vltab_datos) REACG
                               WHERE REACG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNPROMOCIONESGES,
                             (SELECT FNPROMOCIONESTOTAL
                                FROM TABLE (vltab_datos) PROMT
                               WHERE PROMT.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT FNCONPEDIDOGES
                                FROM TABLE (vltab_datos) CG
                               WHERE CG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNCONPEDIDOGES,
                             (SELECT FNCONPEDIDOTOTAL
                                FROM TABLE (vltab_datos) CONPED
                               WHERE CONPED.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT FNSINPEDIDOGES
                                FROM TABLE (vltab_datos) SG
                               WHERE SG.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNSINPEDIDOGES,
                             (SELECT FNSINPEDIDOTOTAL
                                FROM TABLE (vltab_datos) SINPED
                               WHERE SINPED.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT FNLLAMADA
                                FROM TABLE (vltab_datos) QTEL
                               WHERE QTEL.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 FNLLAMADA,
                             (SELECT FNCAMBACEO
                                FROM TABLE (vltab_datos) QCAM
                               WHERE QCAM.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 FNCAMBACEO,
                             (SELECT FNVISITA
                                FROM TABLE (vltab_datos) QVIS
                               WHERE QVIS.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 FNVISITA,
                             (SELECT FNEVENTOS
                                FROM TABLE (vltab_datos) QEVE
                               WHERE QEVE.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 FNEVENTOS,
                             (SELECT FNALERTAS
                                FROM TABLE (vltab_datos) QALER
                               WHERE QALER.FNEMPLEADO = QPRINCIPAL.FNEMPLEADO)
                                 FNALERTAS,
                             CSL_0
                                 AS ORDENAR
                        FROM (SELECT DISTINCT
                                     FIIDENTIFICADOR AS FNEMPLEADO,
                                     FCDESCRIPCION AS EMPLEADO
                                FROM TABLE (vltab_datos)) QPRINCIPAL
                      UNION
                      SELECT FNSUCURSAL
                                 AS FIIDENTIFICADOR,
                             CONCAT (
                                 'TOTAL ',
                                 (SELECT FCNOMBRESUC
                                    FROM SCSISGES.TCFXSUCURSAL TS
                                   WHERE     TS.FIIDPAIS =
                                             QPRINCIPALTOTAL.FNPAIS
                                         AND TS.FIIDZONA =
                                             QPRINCIPALTOTAL.FNZONA
                                         AND TS.FIIDREGION =
                                             QPRINCIPALTOTAL.FNREGION
                                         AND TS.FIIDSUCURSAL =
                                             QPRINCIPALTOTAL.FNSUCURSAL))
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER)
                                 FNALERTAS,
                             CSL_1
                                 AS ORDENAR
                        FROM (SELECT DISTINCT FNPAIS,
                                              FNZONA,
                                              FNREGION,
                                              FNSUCURSAL
                                FROM TABLE (vltab_datos)) QPRINCIPALTOTAL)
            ORDER BY ORDENAR;

        RETURN PA_DATA;
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAFXGESTIONDIARIA.FNGETGESTIONSUC');
            RETURN NULL;
    END FNGETGESTIONSUC;

    FUNCTION FNGETGESTIONREGI (PA_IDCONSULTA NUMBER)
        RETURN SYS_REFCURSOR
    IS
        -- Consultas para contar gestiones acumuladas por regi�n
        -- Author  : 909511 - MJGM
        -- parameter: ID de regi�n
        -- return:   Cursor con sucursales y totales de regi�n
        PA_DATA           SYS_REFCURSOR;

        CURSOR CUR_EMPLEADOS
        IS
            SELECT TE.FNEMPLEADO,
                   TS.FIIDSUCURSAL,
                   TS.FCNOMBRESUC,
                   TS.FINUMCECOSUC AS FIIDCECO,
                   TS.FIIDREGION   AS IDREGION,
                   TS.FIIDZONA     AS IDZONA,
                   TS.FIIDPAIS     AS IDPAIS
              FROM SCSISGES.TCFXSUCURSAL TS, SCSISGES.TAEMPLEADOPF TE
             WHERE     TS.FIIDREGION = PA_IDCONSULTA
                   AND TS.FINUMCECOSUC = TE.FNCC + CSL_0
                   AND TS.FIIDPAIS > CSL_0
                   AND TS.FIIDTERRITORIO > CSL_0
                   AND TS.FIIDSUCURSAL > CSL_0
                   AND TS.FIIDZONA > CSL_0
                   AND TE.FISITUACION = CSL_1
                   AND TE.FNEMPLEADO > CSL_0
                   AND TE.FCNEGOCIO = CSL_EKT
                   AND TE.FIIDPERFIL = CSL_1;

        TYPE typ_datosEmp IS TABLE OF CUR_EMPLEADOS%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcoll_datosEmp   typ_datosEmp;
        vltab_datos       SCSISGES.TYTBGESTIONACUM;
        vl_curtest        SYS_REFCURSOR;
    BEGIN
        -- Inicializacion tabla para datos de salida
        vltab_datos := NEW SCSISGES.TYTBGESTIONACUM ();

        OPEN CUR_EMPLEADOS;

        LOOP
            FETCH CUR_EMPLEADOS BULK COLLECT INTO vlcoll_datosEmp;

            EXIT WHEN vlcoll_datosEmp.COUNT = 0;

            FOR vl_i IN vlcoll_datosEmp.FIRST .. vlcoll_datosEmp.LAST
            LOOP
                vltab_datos.EXTEND;
                vltab_datos (vltab_datos.LAST) :=
                    NEW SCSISGES.TYOBGESTIONACUM (
                            vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                            vlcoll_datosEmp (vl_i).FCNOMBRESUC,
                            vlcoll_datosEmp (vl_i).FIIDCECO,
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                            vlcoll_datosEmp (vl_i).IDREGION,
                            vlcoll_datosEmp (vl_i).IDZONA,
                            vlcoll_datosEmp (vl_i).IDPAIS,
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),     --PENDIENTES POR SURTIR (REGIONAL)
                            SCSISGES.FNCOPPXSTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),               --SOLICITUDES (REGIONAL)
                            SCSISGES.FNCOSOLICTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_4),              --PRESUPUESTOS (REGIONAL)
                            SCSISGES.FNCOPRESUTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_5),               --PROMOCIONES (REGIONAL)
                            SCSISGES.FNCOPROMOCTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            CSL_0,
                            CSL_0,                     --CON PEDIDO (REGIONAL)
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_6),                --SIN PEDIDO (REGIONAL)
                            SCSISGES.FNCOSINPEDTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_1),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),
                            SCSISGES.FNCOEVENTOSDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOALERTASDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO));
            END LOOP;
        END LOOP;

        CLOSE CUR_EMPLEADOS;

        OPEN PA_DATA FOR                                            --REGIONAL
              SELECT FIIDENTIFICADOR,
                     FCDESCRIPCION,
                     FNPENDIENTESGES,
                     FNPENDIENTESTOTAL,
                     FNSOLICITUDESGES,
                     FNSOLICITUDESTOTAL,
                     FNPRESUPUESTOSGES,
                     FNPRESUPUESTOSTOTAL,
                     FNPROMOCIONESGES,
                     FNPROMOCIONESTOTAL,
                     FNCONPEDIDOGES,
                     FNCONPEDIDOTOTAL,
                     FNSINPEDIDOGES,
                     FNSINPEDIDOTOTAL,
                     FNLLAMADA,
                     FNCAMBACEO,
                     FNVISITA,
                     FNEVENTOS,
                     FNALERTAS
                FROM (SELECT QPRINCIPAL.FIIDSUCURSAL
                                 AS FIIDENTIFICADOR,
                             QPRINCIPAL.FCNOMBRESUC
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG
                               WHERE PG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT
                               WHERE QPT.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG
                               WHERE PRG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST
                               WHERE ST.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG
                               WHERE PROMG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT
                               WHERE PRT.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG
                               WHERE REACG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT
                               WHERE PROMT.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG
                               WHERE CG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED
                               WHERE CONPED.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG
                               WHERE SG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED
                               WHERE SINPED.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL
                               WHERE QTEL.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM
                               WHERE QCAM.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS
                               WHERE QVIS.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE
                               WHERE QEVE.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER
                               WHERE QALER.FIIDENTIFICADOR =
                                     QPRINCIPAL.FIIDSUCURSAL)
                                 FNALERTAS,
                             CSL_0
                                 AS ORDENAR
                        FROM (SELECT DISTINCT
                                     FIIDENTIFICADOR AS FIIDSUCURSAL,
                                     FCDESCRIPCION AS FCNOMBRESUC
                                FROM TABLE (vltab_datos)) QPRINCIPAL
                      UNION
                      SELECT FNREGION
                                 AS FIIDENTIFICADOR,
                             CONCAT (
                                 'TOTAL ',
                                 (SELECT FCDESCREGION
                                    FROM SCSISGES.TAFXREGIONES TR
                                   WHERE     TR.FIIDPAIS =
                                             QPRINCIPALTOTAL.FNPAIS
                                         AND TR.FIIDZONA =
                                             QPRINCIPALTOTAL.FNZONA
                                         AND TR.FIIDREGION =
                                             QPRINCIPALTOTAL.FNREGION))
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER)
                                 FNALERTAS,
                             CSL_1
                                 AS ORDENAR
                        FROM (SELECT DISTINCT FNPAIS, FNZONA, FNREGION
                                FROM TABLE (vltab_datos)) QPRINCIPALTOTAL)
            ORDER BY ORDENAR;

        RETURN PA_DATA;
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (
                SYSDATE,
                SQLCODE,
                SUBSTR (SQLERRM, 0, 200),
                'SCSISGES.PAFXGESTIONDIARIA.FNGETGESTIONREGI');
            RETURN NULL;
    END FNGETGESTIONREGI;

    FUNCTION FNGETGESTIONZONA (PA_IDCONSULTA NUMBER)
        RETURN SYS_REFCURSOR
    IS
        -- Consultas para contar gestiones acumuladas por zona
        -- Author  : 909511 - MJGM
        -- parameter: ID de zona
        -- return:   Cursor con regiones y totales de zona
        PA_DATA           SYS_REFCURSOR;

        CURSOR CUR_EMPLEADOS
        IS
            SELECT TE.FNEMPLEADO,
                   TS.FIIDSUCURSAL,
                   TR.FCDESCREGION,
                   TS.FINUMCECOSUC AS FIIDCECO,
                   TS.FIIDREGION   AS IDREGION,
                   TS.FIIDZONA     AS IDZONA,
                   TS.FIIDPAIS     AS IDPAIS
              FROM SCSISGES.TCFXSUCURSAL  TS,
                   SCSISGES.TAEMPLEADOPF  TE,
                   SCSISGES.TAFXREGIONES  TR
             WHERE     TS.FIIDZONA = PA_IDCONSULTA
                   AND TS.FINUMCECOSUC = TE.FNCC + CSL_0
                   AND TS.FIIDPAIS > CSL_0
                   AND TS.FIIDTERRITORIO > CSL_0
                   AND TS.FIIDSUCURSAL > CSL_0
                   AND TS.FIIDZONA > CSL_0
                   AND TE.FISITUACION = CSL_1
                   AND TE.FNEMPLEADO > CSL_0
                   AND TE.FCNEGOCIO = CSL_EKT
                   AND TE.FIIDPERFIL = CSL_1
                   AND TS.FIIDPAIS = TR.FIIDPAIS
                   AND TS.FIIDTERRITORIO = TR.FIIDTERRITORIO
                   AND TS.FIIDZONA = TR.FIIDZONA
                   AND TS.FIIDREGION = TR.FIIDREGION;

        TYPE typ_datosEmp IS TABLE OF CUR_EMPLEADOS%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcoll_datosEmp   typ_datosEmp;
        vltab_datos       SCSISGES.TYTBGESTIONACUM;
        vl_curtest        SYS_REFCURSOR;
    BEGIN
        -- Inicializacion tabla para datos de salida
        vltab_datos := NEW SCSISGES.TYTBGESTIONACUM ();

        OPEN CUR_EMPLEADOS;

        LOOP
            FETCH CUR_EMPLEADOS BULK COLLECT INTO vlcoll_datosEmp;

            EXIT WHEN vlcoll_datosEmp.COUNT = 0;

            FOR vl_i IN vlcoll_datosEmp.FIRST .. vlcoll_datosEmp.LAST
            LOOP
                vltab_datos.EXTEND;
                vltab_datos (vltab_datos.LAST) :=
                    NEW SCSISGES.TYOBGESTIONACUM (
                            vlcoll_datosEmp (vl_i).IDREGION,
                            vlcoll_datosEmp (vl_i).FCDESCREGION,
                            vlcoll_datosEmp (vl_i).FIIDCECO,
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                            vlcoll_datosEmp (vl_i).IDREGION,
                            vlcoll_datosEmp (vl_i).IDZONA,
                            vlcoll_datosEmp (vl_i).IDPAIS,
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),         --PENDIENTES POR SURTIR (ZONA)
                            SCSISGES.FNCOPPXSTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),                   --SOLICITUDES (ZONA)
                            SCSISGES.FNCOSOLICTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_4),                  --PRESUPUESTOS (ZONA)
                            SCSISGES.FNCOPRESUTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_5),                   --PROMOCIONES (ZONA)
                            SCSISGES.FNCOPROMOCTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            CSL_0,
                            CSL_0,                         --CON PEDIDO (ZONA)
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_6),                    --SIN PEDIDO (ZONA)
                            SCSISGES.FNCOSINPEDTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_1),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),
                            SCSISGES.FNCOEVENTOSDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOALERTASDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO));
            END LOOP;
        END LOOP;

        CLOSE CUR_EMPLEADOS;

        OPEN PA_DATA FOR                                                --ZONA
              SELECT FIIDENTIFICADOR,
                     FCDESCRIPCION,
                     FNPENDIENTESGES,
                     FNPENDIENTESTOTAL,
                     FNSOLICITUDESGES,
                     FNSOLICITUDESTOTAL,
                     FNPRESUPUESTOSGES,
                     FNPRESUPUESTOSTOTAL,
                     FNPROMOCIONESGES,
                     FNPROMOCIONESTOTAL,
                     FNCONPEDIDOGES,
                     FNCONPEDIDOTOTAL,
                     FNSINPEDIDOGES,
                     FNSINPEDIDOTOTAL,
                     FNLLAMADA,
                     FNCAMBACEO,
                     FNVISITA,
                     FNEVENTOS,
                     FNALERTAS
                FROM (SELECT QPRINCIPAL.FNREGION
                                 AS FIIDENTIFICADOR,
                             QPRINCIPAL.FCDESCREGION
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG
                               WHERE PG.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT
                               WHERE QPT.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG
                               WHERE PRG.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST
                               WHERE ST.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG
                               WHERE PROMG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FNREGION)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT
                               WHERE PRT.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG
                               WHERE REACG.FIIDENTIFICADOR =
                                     QPRINCIPAL.FNREGION)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT
                               WHERE PROMT.FIIDENTIFICADOR =
                                     QPRINCIPAL.FNREGION)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG
                               WHERE CG.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED
                               WHERE CONPED.FIIDENTIFICADOR =
                                     QPRINCIPAL.FNREGION)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG
                               WHERE SG.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED
                               WHERE SINPED.FIIDENTIFICADOR =
                                     QPRINCIPAL.FNREGION)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL
                               WHERE QTEL.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM
                               WHERE QCAM.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS
                               WHERE QVIS.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE
                               WHERE QEVE.FIIDENTIFICADOR = QPRINCIPAL.FNREGION)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER
                               WHERE QALER.FIIDENTIFICADOR =
                                     QPRINCIPAL.FNREGION)
                                 FNALERTAS,
                             CSL_0
                                 AS ORDENAR
                        FROM (SELECT DISTINCT
                                     FIIDENTIFICADOR AS FNREGION,
                                     FCDESCRIPCION AS FCDESCREGION
                                FROM TABLE (vltab_datos)) QPRINCIPAL
                      UNION
                      SELECT FNZONA
                                 AS FIIDENTIFICADOR,
                             CONCAT (
                                 'TOTAL ',
                                 (SELECT FCDESCZONAS
                                    FROM SCSISGES.TAFXZONAS TZ
                                   WHERE     TZ.FIIDPAIS =
                                             QPRINCIPALTOTAL.FNPAIS
                                         AND TZ.FIIDZONA =
                                             QPRINCIPALTOTAL.FNZONA))
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER)
                                 FNALERTAS,
                             CSL_1
                                 AS ORDENAR
                        FROM (SELECT DISTINCT FNPAIS, FNZONA
                                FROM TABLE (vltab_datos)) QPRINCIPALTOTAL)
            ORDER BY ORDENAR;

        RETURN PA_DATA;
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (
                SYSDATE,
                SQLCODE,
                SUBSTR (SQLERRM, 0, 200),
                'SCSISGES.PAFXGESTIONDIARIA.FNGETGESTIONZONA');
            RETURN NULL;
    END FNGETGESTIONZONA;

    FUNCTION FNGETGESTIONPAIS (PA_IDCONSULTA NUMBER)
        RETURN SYS_REFCURSOR
    IS
        -- Consultas para contar gestiones acumuladas por pais
        -- Author  : 909511 - MJGM
        -- parameter: ID de pais
        -- return:   Cursor con zonas y totales de pais.
        PA_DATA           SYS_REFCURSOR;

        CURSOR CUR_EMPLEADOS
        IS
            SELECT TE.FNEMPLEADO,
                   TS.FIIDSUCURSAL,
                   TZ.FCDESCZONAS,
                   TS.FINUMCECOSUC AS FIIDCECO,
                   TS.FIIDREGION   AS IDREGION,
                   TS.FIIDZONA     AS IDZONA,
                   TS.FIIDPAIS     AS IDPAIS
              FROM SCSISGES.TCFXSUCURSAL  TS,
                   SCSISGES.TAEMPLEADOPF  TE,
                   SCSISGES.TAFXZONAS     TZ
             WHERE     TS.FIIDPAIS = PA_IDCONSULTA
                   AND TS.FINUMCECOSUC = TE.FNCC + CSL_0
                   AND TS.FIIDPAIS > CSL_0
                   AND TS.FIIDTERRITORIO > CSL_0
                   AND TS.FIIDSUCURSAL > CSL_0
                   AND TS.FIIDZONA > CSL_0
                   AND TE.FISITUACION = CSL_1
                   AND TE.FNEMPLEADO > CSL_0
                   AND TE.FCNEGOCIO = CSL_EKT
                   AND TE.FIIDPERFIL = CSL_1
                   AND TS.FIIDPAIS = TZ.FIIDPAIS
                   AND TS.FIIDTERRITORIO = TZ.FIIDTERRITORIO
                   AND TS.FIIDZONA = TZ.FIIDZONA;

        TYPE typ_datosEmp IS TABLE OF CUR_EMPLEADOS%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcoll_datosEmp   typ_datosEmp;
        vltab_datos       SCSISGES.TYTBGESTIONACUM;
        vl_curtest        SYS_REFCURSOR;
    BEGIN
        -- Inicializacion tabla para datos de salida
        vltab_datos := NEW SCSISGES.TYTBGESTIONACUM ();

        OPEN CUR_EMPLEADOS;

        LOOP
            FETCH CUR_EMPLEADOS BULK COLLECT INTO vlcoll_datosEmp;

            EXIT WHEN vlcoll_datosEmp.COUNT = 0;

            FOR vl_i IN vlcoll_datosEmp.FIRST .. vlcoll_datosEmp.LAST
            LOOP
                vltab_datos.EXTEND;
                vltab_datos (vltab_datos.LAST) :=
                    NEW SCSISGES.TYOBGESTIONACUM (
                            vlcoll_datosEmp (vl_i).IDZONA,
                            vlcoll_datosEmp (vl_i).FCDESCZONAS,
                            vlcoll_datosEmp (vl_i).FIIDCECO,
                            vlcoll_datosEmp (vl_i).FNEMPLEADO,
                            vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                            vlcoll_datosEmp (vl_i).IDREGION,
                            vlcoll_datosEmp (vl_i).IDZONA,
                            vlcoll_datosEmp (vl_i).IDPAIS,
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),         --PENDIENTES POR SURTIR (PAIS)
                            SCSISGES.FNCOPPXSTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),                   --SOLICITUDES (PAIS)
                            SCSISGES.FNCOSOLICTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_4),                  --PRESUPUESTOS (PAIS)
                            SCSISGES.FNCOPRESUTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_5),                   --PROMOCIONES (PAIS)
                            SCSISGES.FNCOPROMOCTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            CSL_0,
                            CSL_0,                         --CON PEDIDO (PAIS)
                            SCSISGES.FNCOGESTIONDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_6),                    --SIN PEDIDO (PAIS)
                            SCSISGES.FNCOSINPEDTDIA (
                                vlcoll_datosEmp (vl_i).FIIDSUCURSAL,
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_1),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_2),
                            SCSISGES.FNCOAGENDADIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO,
                                csl_3),
                            SCSISGES.FNCOEVENTOSDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO),
                            SCSISGES.FNCOALERTASDIA (
                                vlcoll_datosEmp (vl_i).FNEMPLEADO));
            END LOOP;
        END LOOP;

        CLOSE CUR_EMPLEADOS;

        OPEN PA_DATA FOR                                                --PAIS
              SELECT FIIDENTIFICADOR,
                     FCDESCRIPCION,
                     FNPENDIENTESGES,
                     FNPENDIENTESTOTAL,
                     FNSOLICITUDESGES,
                     FNSOLICITUDESTOTAL,
                     FNPRESUPUESTOSGES,
                     FNPRESUPUESTOSTOTAL,
                     FNPROMOCIONESGES,
                     FNPROMOCIONESTOTAL,
                     FNCONPEDIDOGES,
                     FNCONPEDIDOTOTAL,
                     FNSINPEDIDOGES,
                     FNSINPEDIDOTOTAL,
                     FNLLAMADA,
                     FNCAMBACEO,
                     FNVISITA,
                     FNEVENTOS,
                     FNALERTAS
                FROM (SELECT QPRINCIPAL.FNZONA
                                 AS FIIDENTIFICADOR,
                             QPRINCIPAL.FCDESCZONAS
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG
                               WHERE PG.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT
                               WHERE QPT.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG
                               WHERE PRG.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST
                               WHERE ST.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG
                               WHERE PROMG.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT
                               WHERE PRT.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG
                               WHERE REACG.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT
                               WHERE PROMT.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG
                               WHERE CG.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED
                               WHERE CONPED.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG
                               WHERE SG.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED
                               WHERE SINPED.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL
                               WHERE QTEL.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM
                               WHERE QCAM.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS
                               WHERE QVIS.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE
                               WHERE QEVE.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER
                               WHERE QALER.FIIDENTIFICADOR = QPRINCIPAL.FNZONA)
                                 FNALERTAS,
                             CSL_0
                                 AS ORDENAR
                        FROM (SELECT DISTINCT
                                     FIIDENTIFICADOR AS FNZONA,
                                     FCDESCRIPCION AS FCDESCZONAS
                                FROM TABLE (vltab_datos)) QPRINCIPAL
                      UNION
                      SELECT FNPAIS
                                 AS FIIDENTIFICADOR,
                             CONCAT (
                                 'TOTAL ',
                                 (SELECT FCNOMPAIS
                                    FROM SCSISGES.TCPAIS TP
                                   WHERE TP.FIIDPAIS = QPRINCIPALTOTAL.FNPAIS))
                                 AS FCDESCRIPCION,
                             (SELECT SUM (FNPENDIENTESGES)
                                FROM TABLE (vltab_datos) PG)
                                 AS FNPENDIENTESGES,
                             (SELECT SUM (FNPENDIENTESTOTAL)
                                FROM TABLE (vltab_datos) QPT)
                                 AS FNPENDIENTESTOTAL,
                             (SELECT SUM (FNSOLICITUDESGES)
                                FROM TABLE (vltab_datos) PRG)
                                 AS FNSOLICITUDESGES,
                             (SELECT SUM (FNSOLICITUDESTOTAL)
                                FROM TABLE (vltab_datos) ST)
                                 AS FNSOLICITUDESTOTAL,
                             (SELECT SUM (FNPRESUPUESTOSGES)
                                FROM TABLE (vltab_datos) PROMG)
                                 AS FNPRESUPUESTOSGES,
                             (SELECT SUM (FNPRESUPUESTOSTOTAL)
                                FROM TABLE (vltab_datos) PRT)
                                 AS FNPRESUPUESTOSTOTAL,
                             (SELECT SUM (FNPROMOCIONESGES)
                                FROM TABLE (vltab_datos) REACG)
                                 AS FNPROMOCIONESGES,
                             (SELECT SUM (FNPROMOCIONESTOTAL)
                                FROM TABLE (vltab_datos) PROMT)
                                 AS FNPROMOCIONESTOTAL,
                             (SELECT SUM (FNCONPEDIDOGES)
                                FROM TABLE (vltab_datos) CG)
                                 AS FNCONPEDIDOGES,
                             (SELECT SUM (FNCONPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) CONPED)
                                 AS FNCONPEDIDOTOTAL,
                             (SELECT SUM (FNSINPEDIDOGES)
                                FROM TABLE (vltab_datos) SG)
                                 AS FNSINPEDIDOGES,
                             (SELECT SUM (FNSINPEDIDOTOTAL)
                                FROM TABLE (vltab_datos) SINPED)
                                 AS FNSINPEDIDOTOTAL,
                             (SELECT SUM (FNLLAMADA)
                                FROM TABLE (vltab_datos) QTEL)
                                 FNLLAMADA,
                             (SELECT SUM (FNCAMBACEO)
                                FROM TABLE (vltab_datos) QCAM)
                                 FNCAMBACEO,
                             (SELECT SUM (FNVISITA)
                                FROM TABLE (vltab_datos) QVIS)
                                 FNVISITA,
                             (SELECT SUM (FNEVENTOS)
                                FROM TABLE (vltab_datos) QEVE)
                                 FNEVENTOS,
                             (SELECT SUM (FNALERTAS)
                                FROM TABLE (vltab_datos) QALER)
                                 FNALERTAS,
                             CSL_1
                                 AS ORDENAR
                        FROM (SELECT DISTINCT FNPAIS
                                FROM TABLE (vltab_datos)) QPRINCIPALTOTAL)
            ORDER BY ORDENAR;

        RETURN PA_DATA;
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (
                SYSDATE,
                SQLCODE,
                SUBSTR (SQLERRM, 0, 200),
                'SCSISGES.PAFXGESTIONDIARIA.FNGETGESTIONPAIS');
            RETURN NULL;
    END FNGETGESTIONPAIS;

    FUNCTION FNGETCURDATOSVAC
        RETURN SYS_REFCURSOR
    IS
        PA_DATA   SYS_REFCURSOR;
    BEGIN
        OPEN PA_DATA FOR SELECT NULL FIIDENTIFICADOR,
                                NULL FCDESCRIPCION,
                                NULL FNPENDIENTESGES,
                                NULL FNPENDIENTESTOTAL,
                                NULL FNSOLICITUDESGES,
                                NULL FNSOLICITUDESTOTAL,
                                NULL FNPRESUPUESTOSGES,
                                NULL FNPRESUPUESTOSTOTAL,
                                NULL FNPROMOCIONESGES,
                                NULL FNPROMOCIONESTOTAL,
                                NULL FNCONPEDIDOGES,
                                NULL FNCONPEDIDOTOTAL,
                                NULL FNSINPEDIDOGES,
                                NULL FNSINPEDIDOTOTAL,
                                NULL FNLLAMADA,
                                NULL FNCAMBACEO,
                                NULL FNVISITA,
                                NULL FNEVENTOS,
                                NULL FNALERTAS
                           FROM DUAL;

        RETURN PA_DATA;
    END FNGETCURDATOSVAC;

    FUNCTION FNGERENTESUC (PA_FIIDCECOSUC    IN NUMBER,
                           PA_FIIDSUCURSAL   IN NUMBER)
        RETURN VARCHAR2
    IS
        -- Consultas el nombre del gerente de la sucursal.
        -- Author  : 909511 - MJGM
        -- parameter: ID cecosuc, ID sucursal.
        -- return:   Nombre del gerente de la sucursal
        VL_NOMBREGERENTE   VARCHAR2 (200);
    BEGIN
        SELECT    PA_FIIDSUCURSAL
               || '/'
               || T.FCNOMBRE
               || ' '
               || T.FCAPATERNO
               || ' '
               || T.FCAMATERNO
               || '-'
               || T.FNEMPLEADO
          INTO VL_NOMBREGERENTE
          FROM SCSISGES.TAEMPLEADOPF T
         WHERE     T.FNCC = PA_FIIDCECOSUC
               AND T.FIIDPERFIL = CSL_3
               AND ROWNUM <= CSL_1;

        RETURN VL_NOMBREGERENTE;
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAFXGESTIONDIARIA.FNGERENTESUC');
            RETURN NULL;
    END FNGERENTESUC;
END PAFXGESTIONDIA;

/

  GRANT EXECUTE ON "SCSISGES"."PAFXGESTIONDIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAFXGESTIONDIA" TO "USRSISGES";
