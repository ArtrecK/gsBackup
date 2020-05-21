--------------------------------------------------------
--  DDL for Package Body PAGESTACUMULADO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAGESTACUMULADO" 
IS
   CSL_1      CONSTANT INTEGER := 1;
   CSL_2      CONSTANT INTEGER := 2;
   CSL_78     CONSTANT INTEGER := 78;
   CSL_8067   CONSTANT INTEGER := 8067;
   CSL_EKT    CONSTANT VARCHAR2 (5) := 'EKT';

   PROCEDURE SPACUMULADOSUPERV (PA_SUCURSAL        IN     INTEGER,
                                PA_CURSUPERVACUM      OUT SYS_REFCURSOR,
                                PA_CODMSG             OUT INTEGER,
                                PA_MSG                OUT VARCHAR2,
                                PA_MSGERROR           OUT VARCHAR2)
   IS
      CURSOR cur_vendedores
      IS
         SELECT E.FNEMPLEADO,
                E.FCNOMBRE || ' ' || E.FCAPATERNO || ' ' || E.FCAMATERNO
                   AS FCNOMBRE
           FROM SCSISGES.TAEMPLEADO E
          WHERE E.FNCC =
                   (SELECT DISTINCT T.FINUMCECOSUC
                      FROM SCSISGES.TCFXSUCURSAL T
                     WHERE T.FIIDSUCURSAL = PA_SUCURSAL
                           AND T.FIIDTERRITORIO IN
                                  (SELECT TER.FIIDTERRITORIO
                                     FROM SCSISGES.
                                           TAFXTERRITORIOS TER
                                    WHERE TER.FITIPOGEO = CSL_2
                                          AND TER.FIESTATUS = CSL_1))
                AND E.fcnegocio = CSL_EKT
                AND E.FISITUACION = CSL_1
                AND E.FNFUNCION = CSL_8067;

      TYPE typ_sellers IS TABLE OF cur_vendedores%ROWTYPE
                             INDEX BY PLS_INTEGER;

      vlcoll_sellers        typ_sellers;
      vltbl_gestionbranch   SCSISGES.TYTBGESTIONBRANCH;
   BEGIN
      vltbl_gestionbranch := NEW SCSISGES.TYTBGESTIONBRANCH ();

      OPEN cur_vendedores;

      LOOP
         FETCH cur_vendedores
         BULK COLLECT INTO vlcoll_sellers;

         EXIT WHEN vlcoll_sellers.COUNT = 0;

         FOR vl_i IN vlcoll_sellers.FIRST .. vlcoll_sellers.LAST
         LOOP
            vltbl_gestionbranch.EXTEND;
            vltbl_gestionbranch (vltbl_gestionbranch.LAST) :=
               NEW SCSISGES.
                    TYOBGESTIONBRANCH (vlcoll_sellers (vl_i).FNEMPLEADO,
                                       vlcoll_sellers (vl_i).FCNOMBRE,
                                       PA_SUCURSAL,
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

      CLOSE cur_vendedores;

      OPEN PA_CURSUPERVACUM FOR
           SELECT QPRINCIPAL.FNEMPLEADO,
                  QPRINCIPAL.FCNOMBRECOM,
                  QPG.TOTALPEDGES AS FIPENSURGES,
                  QPT.TOTALPED AS FIPENSURTIR,
                  QSG.TOTALSOLGES AS FISOLGESTIO,
                  QST.TOTALSOL AS FISOLICITUD,
                  QPRG.TOTALPREGES AS FIPREGESTIO,
                  QPRT.TOTALPRE AS FIPRESUPUES,
                  QPROMG.TOTALPROMGES AS FIPROGESTIO,
                  QPROMT.TOTALPROM AS FIPROMOCION,
                  QREACG.TOTALREACGES AS FIREAGESTIO,
                  QREACT.TOTALREACTOTAL AS FIREACTIVAC
             FROM (SELECT DISTINCT FNEMPLEADO, FCNOMBRECOM
                     FROM TABLE (vltbl_gestionbranch)) QPRINCIPAL,
                  (SELECT PG.FIPENSURGES AS TOTALPEDGES, PG.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.
                              FNGETPENDXSURTIR (vltbl_gestionbranch, CSL_1)) PG) QPG,
                  (SELECT PT.FIPENSURTIR AS TOTALPED, PT.FNEMPLEADO
                     FROM TABLE (
                             SCSISGES.
                              FNGETPENDXSURTIR (vltbl_gestionbranch, CSL_2)) PT) QPT,
                  (SELECT SG.FNEMPLEADO, SG.FISOLGESTIO AS TOTALSOLGES
                     FROM TABLE (
                             SCSISGES.
                              FNGETSOLICITUDES (vltbl_gestionbranch, CSL_1)) SG) QSG,
                  (SELECT ST.FNEMPLEADO, ST.FISOLICITUD AS TOTALSOL
                     FROM TABLE (
                             SCSISGES.
                              FNGETSOLICITUDES (vltbl_gestionbranch, CSL_2)) ST) QST,
                  (SELECT PRG.FNEMPLEADO, FIPREGESTIO AS TOTALPREGES
                     FROM TABLE (
                             SCSISGES.
                              FNGETPRESUPUESTOS (vltbl_gestionbranch, CSL_1)) PRG) QPRG,
                  (SELECT PRT.FNEMPLEADO, FIPRESUPUES AS TOTALPRE
                     FROM TABLE (
                             SCSISGES.
                              FNGETPRESUPUESTOS (vltbl_gestionbranch, CSL_2)) PRT) QPRT,
                  (SELECT PROMG.FNEMPLEADO, PROMG.FIPROGESTIO AS TOTALPROMGES
                     FROM TABLE (
                             SCSISGES.
                              FNGETPROMOCIONES (vltbl_gestionbranch, CSL_1)) PROMG) QPROMG,
                  (SELECT PROMT.FNEMPLEADO, PROMT.FIPROMOCION AS TOTALPROM
                     FROM TABLE (
                             SCSISGES.
                              FNGETPROMOCIONES (vltbl_gestionbranch, CSL_2)) PROMT) QPROMT,
                  (SELECT REACG.FNEMPLEADO, REACG.FIREAGESTIO AS TOTALREACGES
                     FROM TABLE (
                             SCSISGES.
                              FNGETREACTIVACIONES (vltbl_gestionbranch, CSL_1)) REACG) QREACG,
                  (SELECT REACT.FNEMPLEADO, REACT.FIREACTIVAC AS TOTALREACTOTAL
                     FROM TABLE (
                             SCSISGES.
                              FNGETREACTIVACIONES (vltbl_gestionbranch, CSL_2)) REACT) QREACT
            WHERE     QPRINCIPAL.FNEMPLEADO = QPG.FNEMPLEADO
                  AND QPG.FNEMPLEADO = QPT.FNEMPLEADO
                  AND QPT.FNEMPLEADO = QPRG.FNEMPLEADO
                  AND QPRG.FNEMPLEADO = QPRT.FNEMPLEADO
                  AND QPRT.FNEMPLEADO = QPROMG.FNEMPLEADO
                  AND QPROMG.FNEMPLEADO = QPROMT.FNEMPLEADO
                  AND QPROMT.FNEMPLEADO = QREACG.FNEMPLEADO
                  AND QREACG.FNEMPLEADO = QREACT.FNEMPLEADO
                  AND QREACT.FNEMPLEADO = QSG.FNEMPLEADO
                  AND QSG.FNEMPLEADO = QST.FNEMPLEADO
         ORDER BY QPRINCIPAL.FNEMPLEADO;

      vlcoll_sellers.DELETE;

      pa_codmsg := 0;
      pa_msg := 'OK';
      pa_msgerror := '';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         pa_codmsg := 0;
         pa_msg := 'No se tiene datos para supervision del gerente de tienda';
         pa_msgerror := '';
      WHEN OTHERS
      THEN
         pa_codmsg := 1;
         pa_msg := 'Error al consultar para supervision del gerente de tienda';
         pa_msgerror := SQLCODE || '  ' || SQLERRM;
   END SPACUMULADOSUPERV;
END PAGESTACUMULADO;

/

  GRANT EXECUTE ON "SCSISGES"."PAGESTACUMULADO" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGESTACUMULADO" TO "USRSISGES";
