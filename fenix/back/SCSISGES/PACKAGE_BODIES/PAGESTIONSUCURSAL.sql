--------------------------------------------------------
--  DDL for Package Body PAGESTIONSUCURSAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAGESTIONSUCURSAL" 
IS
   CSL_0      CONSTANT INTEGER := 0;
   CSL_1      CONSTANT INTEGER := 1;
   CSL_2      CONSTANT INTEGER := 2;
   CSL_3      CONSTANT INTEGER := 3;
   CSL_4      CONSTANT INTEGER := 4;
   CSL_5      CONSTANT INTEGER := 5;
   CSL_6      CONSTANT INTEGER := 6;
   CSL_8067   CONSTANT INTEGER := 8067;
   CSL_1778   CONSTANT INTEGER := 1778;
   CSL_EKT    CONSTANT VARCHAR2 (3) := 'EKT';

   PROCEDURE SPGESTIONSUCURSAL (pa_sucursal        IN     INTEGER,
                                pa_cursupervisor      OUT SYS_REFCURSOR,
                                pa_codmsg             OUT INTEGER,
                                pa_msg                OUT VARCHAR2,
                                pa_msgerror           OUT VARCHAR2)
   IS
      CURSOR CUR_SELLERS
      IS
         SELECT E.FNEMPLEADO,
                E.FCNOMBRE,
                E.FCAPATERNO,
                E.FCAMATERNO
           FROM SCSISGES.TAEMPLEADO E
          WHERE E.FNCC =
                   (SELECT DISTINCT T.FINUMCECOSUC
                      FROM SCSISGES.TCFXSUCURSAL T
                     WHERE T.FIIDSUCURSAL = pa_sucursal
                           AND T.FIIDTERRITORIO IN
                                  (SELECT TER.FIIDTERRITORIO
                                     FROM SCSISGES.
                                           TAFXTERRITORIOS TER
                                    WHERE TER.FITIPOGEO = CSL_2
                                          AND TER.FIESTATUS = CSL_1))
                AND E.fcnegocio = CSL_EKT
                AND FISITUACION = CSL_1
                AND FNFUNCION IN (CSL_8067, CSL_1778);

      -- declaracion de un type table y coleccion para memoria
      TYPE tb_sellers IS TABLE OF CUR_SELLERS%ROWTYPE
                            INDEX BY PLS_INTEGER;

      vlcoll_sellers   tb_sellers;
      vltab_datos      SCSISGES.TYTBGESTIONBRANCH;
   BEGIN
      vltab_datos := NEW SCSISGES.TYTBGESTIONBRANCH ();

      --llenar collection con datos de los empleados de las sucursales
      OPEN CUR_SELLERS;

      LOOP
         FETCH CUR_SELLERS
         BULK COLLECT INTO vlcoll_sellers;

         EXIT WHEN vlcoll_sellers.COUNT = 0;

         FOR vl_i IN vlcoll_sellers.FIRST .. vlcoll_sellers.LAST
         LOOP
            vltab_datos.EXTEND;
            vltab_datos (vltab_datos.LAST) :=
               NEW SCSISGES.
                    TYOBGESTIONBRANCH (
                      vlcoll_sellers (vl_i).FNEMPLEADO,
                         vlcoll_sellers (vl_i).FCNOMBRE
                      || ' '
                      || vlcoll_sellers (vl_i).FCAPATERNO
                      || ' '
                      || vlcoll_sellers (vl_i).FCAMATERNO,
                      pa_sucursal,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL);
         END LOOP;
      END LOOP;

      CLOSE CUR_SELLERS;

      OPEN pa_cursupervisor FOR
           SELECT QPRINCIPAL.FNEMPLEADO,
                  QPRINCIPAL.FCNOMBRECOM,
                  QGPXS.TDAYPXSGES AS FIPENSURGES,
                  QTPXS.TDAYPXS AS FIPENSURTIR,
                  QGSOL.TDAYSOLGES AS FISOLGESTIO,
                  QTSOL.TDAYSOL AS FISOLICITUD,
                  QGPRE.TDAYPREGES AS FIPREGESTIO,
                  QTPRE.TDAYPRE AS FIPRESUPUES,
                  QGPRO.TDAYPROGES AS FIPROGESTIO,
                  QTPRO.TDAYPRO AS FIPROMOCION,
                  QGREA.TDAYREAGES AS FIREAGESTIO,
                  QTREA.TDAYREA AS FIREACTIVAC,
                  QTCAL.TDAYCAL AS FILLAMADAGE,
                  QTVIS.TDAYVIS AS FIVISITAGES,
                  QTCAM.TDAYCAM AS FICAMBACEGE,
                  QTEVE.TDAYEVE AS FIEVENTODIA,
                  QTALE.TDAYALE AS FIALERTASSL
             FROM (SELECT DATOS.FNEMPLEADO, DATOS.FCNOMBRECOM
                     FROM TABLE (vltab_datos) DATOS) QPRINCIPAL,
                  (SELECT GPXS.FIGESTIONES AS TDAYPXSGES, GPXS.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTIONES (vltab_datos, CSL_2)) GPXS) QGPXS,
                  (SELECT TPXS.FIPENSURTIR AS TDAYPXS, TPXS.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.FNGETPENDXSURTIR (vltab_datos, CSL_2)) TPXS) QTPXS,
                  (SELECT GPRE.FIGESTIONES AS TDAYPREGES, GPRE.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTIONES (vltab_datos, CSL_4)) GPRE) QGPRE,
                  (SELECT TPRE.FIPRESUPUES AS TDAYPRE, TPRE.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.FNGETPRESUPUESTOS (vltab_datos, CSL_2)) TPRE) QTPRE,
                  (SELECT GPRO.FIGESTIONES AS TDAYPROGES, GPRO.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTIONES (vltab_datos, CSL_5)) GPRO) QGPRO,
                  (SELECT TPRO.FIPROMOCION AS TDAYPRO, TPRO.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.FNGETPROMOCIONES (vltab_datos, CSL_2)) TPRO) QTPRO,
                  (SELECT GREA.FIGESTIONES AS TDAYREAGES, GREA.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTIONES (vltab_datos, CSL_6)) GREA) QGREA,
                  (SELECT TREA.FIREACTIVAC AS TDAYREA, TREA.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.FNGETREACTIVACIONES (vltab_datos, CSL_2)) TREA) QTREA,
                  (SELECT GSOL.FIGESTIONES AS TDAYSOLGES, GSOL.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTIONES (vltab_datos, CSL_3)) GSOL) QGSOL,
                  (SELECT TSOL.FISOLICITUD AS TDAYSOL, TSOL.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.FNGETSOLICITUDES (vltab_datos, CSL_2)) TSOL) QTSOL,
                  (SELECT TCAL.FIGESTIONES AS TDAYCAL, TCAL.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTDIARIO (vltab_datos, CSL_1)) TCAL) QTCAL,
                  (SELECT TCAM.FIGESTIONES AS TDAYCAM, TCAM.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTDIARIO (vltab_datos, CSL_2)) TCAM) QTCAM,
                  (SELECT TVIS.FIGESTIONES AS TDAYVIS, TVIS.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTDIARIO (vltab_datos, CSL_3)) TVIS) QTVIS,
                  (SELECT TEVE.FIGESTIONES AS TDAYEVE, TEVE.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTDIARIO (vltab_datos, CSL_4)) TEVE) QTEVE,
                  (SELECT TALE.FIGESTIONES AS TDAYALE, TALE.FNEMPLEADO
                     FROM TABLE (SCSISGES.FNGETGESTDIARIO (vltab_datos, CSL_5)) TALE) QTALE
            WHERE     QPRINCIPAL.FNEMPLEADO = QGPXS.FNEMPLEADO
                  AND QGPXS.FNEMPLEADO = QTPXS.FNEMPLEADO
                  AND QTPXS.FNEMPLEADO = QGPRE.FNEMPLEADO
                  AND QGPRE.FNEMPLEADO = QTPRE.FNEMPLEADO
                  AND QTPRE.FNEMPLEADO = QGPRO.FNEMPLEADO
                  AND QGPRO.FNEMPLEADO = QTPRO.FNEMPLEADO
                  AND QTPRO.FNEMPLEADO = QGREA.FNEMPLEADO
                  AND QGREA.FNEMPLEADO = QTREA.FNEMPLEADO
                  AND QTREA.FNEMPLEADO = QGSOL.FNEMPLEADO
                  AND QGSOL.FNEMPLEADO = QTSOL.FNEMPLEADO
                  AND QTSOL.FNEMPLEADO = QTCAL.FNEMPLEADO
                  AND QTCAL.FNEMPLEADO = QTCAM.FNEMPLEADO
                  AND QTCAM.FNEMPLEADO = QTVIS.FNEMPLEADO
                  AND QTVIS.FNEMPLEADO = QTEVE.FNEMPLEADO
                  AND QTEVE.FNEMPLEADO = QTALE.FNEMPLEADO
         ORDER BY QPRINCIPAL.FNEMPLEADO;

      vltab_datos.DELETE;

      pa_codmsg := 0;
      pa_msg := 'OK';
      pa_msgerror := '';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         pa_codmsg := 0;
         pa_msg := 'No existen datos de gestiones supervision';
         pa_msgerror := '';
      WHEN OTHERS
      THEN
         pa_codmsg := SQLCODE;
         pa_msg := 'Error al consultar gestiones supervision';
         pa_msgerror := SUBSTR (SQLERRM, 0, 200);
         SCSISGES.SPERRORES (SYSDATE,
                             pa_codmsg,
                             pa_msgerror,
                             'PAGESTIONSUCURSAL.SPGESTIONSUCURSAL');
   END SPGESTIONSUCURSAL;
END PAGESTIONSUCURSAL;

/

  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRINFVENTAST";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRVENTAST";
