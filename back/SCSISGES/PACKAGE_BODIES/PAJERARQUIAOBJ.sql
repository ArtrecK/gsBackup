--------------------------------------------------------
--  DDL for Package Body PAJERARQUIAOBJ
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAJERARQUIAOBJ" 
AS
   csl_200              CONSTANT INTEGER := 200;
   csl_ok               CONSTANT VARCHAR (2) := 'OK';
   csl_codigoContado    CONSTANT VARCHAR (10) := '4000000100';
   csl_codigoCredito    CONSTANT VARCHAR (10) := '4000000101';
   csl_0                CONSTANT INTEGER := 0;
   csl_1                CONSTANT INTEGER := 1;
   csl_2                CONSTANT INTEGER := 2;
   csl_3                CONSTANT INTEGER := 3;
   csl_4                CONSTANT INTEGER := 4;
   csl_6                CONSTANT INTEGER := 6;
   csl_7                CONSTANT INTEGER := 7;
   csl_limite_cienMil   CONSTANT INTEGER := 100000;
   csl_limite_diezMil   CONSTANT INTEGER := 10000;

   PROCEDURE SPINSOBJETIVOSSUC (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2)
   AS
      CURSOR CUR_OBJSUC IS
           SELECT OBJETIVOTIENDA.FIIDPAIS,
                  OBJETIVOTIENDA.FIIDTERRITORIO,
                  OBJETIVOTIENDA.FCDESCTERRIRORIO,
                  OBJETIVOTIENDA.FIIDZONA,
                  OBJETIVOTIENDA.FCDESCZONAS,
                  OBJETIVOTIENDA.FIIDREGION,
                  OBJETIVOTIENDA.FCDESCREGION,
                  OBJETIVOTIENDA.FIIDSUCURSAL,
                  OBJETIVOTIENDA.FCNOMBRESUC,
                  OBJETIVOTIENDA.FDFECHA,
                  OBJETIVOTIENDA.FNLINEA,
                  TCL.FCPRDLINDESC,
                  NVL (
                     SUBSTR (TO_CHAR (ABS (OBJETIVOTIENDA.FNPRODUCTO)),
                             csl_4,
                             csl_3),
                     csl_0)
                     AS FNSUBLINEA,
                  NVL (
                     SUBSTR (TO_CHAR (ABS (OBJETIVOTIENDA.FNPRODUCTO)),
                             csl_7,
                             csl_3),
                     csl_0)
                     AS FNCLASE,
                  OBJETIVOTIENDA.FISEMANA,
                  SUBSTR (OBJETIVOTIENDA.FDFECHA, csl_0, csl_4)
                     AS ANIO,
                  SUM (NVL (OBJETIVOTIENDA.MONTOCONTADO, csl_0))
                     AS MONTOCONTADO,
                  SUM (NVL (OBJETIVOTIENDA.MONTOCREDITO, csl_0))
                     AS MONTOCREDITO
             FROM (  SELECT TCS.FIIDPAIS,
                            TCS.FIIDTERRITORIO,
                            TAT.FCDESCTERRIRORIO,
                            TCS.FIIDZONA,
                            TAZ.FCDESCZONAS,
                            TCS.FIIDREGION,
                            TAR.FCDESCREGION,
                            TCS.FIIDSUCURSAL,
                            TCS.FCNOMBRESUC,
                            TAO.FDFECHA,
                            CASE
                               WHEN LENGTH (TAO.FNPRODUCTO) > csl_6
                               THEN
                                  SUBSTR (TO_CHAR (ABS (TAO.FNPRODUCTO)),
                                          csl_0,
                                          csl_3)
                               ELSE
                                  TO_CHAR (ABS (TAO.FNPRODUCTO))
                            END                                 AS FNLINEA,
                            TAO.FNPRODUCTO,
                            (SELECT FISEMANA
                               FROM SCSISGES.TCCALENDARIOEKT TCC
                              WHERE     TO_DATE (TAO.FDFECHA, 'yyyy-MM-dd') =
                                        TCC.FDFECHA
                                    AND TCC.FIANIO > csl_0
                                    AND TCC.FISEMANA > csl_0)   FISEMANA,
                            CASE
                               WHEN TAO.FCIDCONCEPTO = csl_codigoContado
                               THEN
                                  SUM (TAO.FNMONTOPESOS)
                            END                                 AS MONTOCONTADO,
                            CASE
                               WHEN TAO.FCIDCONCEPTO = csl_codigoCredito
                               THEN
                                  SUM (TAO.FNMONTOPESOS)
                            END                                 AS MONTOCREDITO
                       FROM SCSISGES.TAOBJETIVOS TAO
                            INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                               ON TAO.FNCCOSTO = TCS.FINUMCECOSUC
                            INNER JOIN SCSISGES.TAFXTERRITORIOS TAT
                               ON TCS.FIIDTERRITORIO = TAT.FIIDTERRITORIO
                            INNER JOIN SCSISGES.TAFXZONAS TAZ
                               ON TCS.FIIDZONA = TAZ.FIIDZONA
                            INNER JOIN SCSISGES.TAFXREGIONES TAR
                               ON TCS.FIIDREGION = TAR.FIIDREGION
                      WHERE     TCS.FINUMCECOSUC > csl_0
                            AND TAO.FNCCOSTO > csl_0
                            AND TAZ.FIESTATUS > csl_0
                            AND TAR.FIESTATUS > csl_0
                            AND TAT.FIESTATUS > csl_0
                   GROUP BY TCS.FIIDPAIS,
                            TCS.FIIDTERRITORIO,
                            TAT.FCDESCTERRIRORIO,
                            TCS.FIIDZONA,
                            TAZ.FCDESCZONAS,
                            TCS.FIIDREGION,
                            TAR.FCDESCREGION,
                            TCS.FIIDSUCURSAL,
                            TCS.FCNOMBRESUC,
                            TAO.FDFECHA,
                            TAO.FNPRODUCTO,
                            TAO.FCIDCONCEPTO) OBJETIVOTIENDA
                  INNER JOIN SCSISGES.TCLINEA TCL
                     ON OBJETIVOTIENDA.FNLINEA = TCL.FNLINEA
            WHERE TCL.FNLINEA > csl_0 AND TCL.FNESTATUS = csl_1
         GROUP BY OBJETIVOTIENDA.FIIDPAIS,
                  OBJETIVOTIENDA.FIIDTERRITORIO,
                  OBJETIVOTIENDA.FCDESCTERRIRORIO,
                  OBJETIVOTIENDA.FIIDZONA,
                  OBJETIVOTIENDA.FCDESCZONAS,
                  OBJETIVOTIENDA.FIIDREGION,
                  OBJETIVOTIENDA.FCDESCREGION,
                  OBJETIVOTIENDA.FIIDSUCURSAL,
                  OBJETIVOTIENDA.FCNOMBRESUC,
                  OBJETIVOTIENDA.FDFECHA,
                  OBJETIVOTIENDA.FNLINEA,
                  OBJETIVOTIENDA.FNPRODUCTO,
                  TCL.FCPRDLINDESC,
                  OBJETIVOTIENDA.FISEMANA;

      TYPE typ_Curobjsuc IS TABLE OF CUR_OBJSUC%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_objsuc   typ_Curobjsuc;
   --INICIA LA FUNCION
   BEGIN
      --CURSOR
      OPEN CUR_OBJSUC;

      LOOP
         BEGIN
            FETCH CUR_OBJSUC
               BULK COLLECT INTO vlcur_objsuc
               LIMIT csl_limite_cienMil;

            EXIT WHEN vlcur_objsuc.COUNT = csl_0;

            FORALL vl_i IN vlcur_objsuc.FIRST .. vlcur_objsuc.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOSUC (FIIDPAIS,
                                                   FIIDTERRITORIO,
                                                   FCDESCTERRITORIO,
                                                   FIIDZONA,
                                                   FCDESCZONA,
                                                   FIIDREGION,
                                                   FCDESCREGION,
                                                   FIIDSUCURSAL,
                                                   FCNOMBRESUC,
                                                   FDFECHA,
                                                   FNLINEA,
                                                   FCLINEADESC,
                                                   FNSUBLINEA,
                                                   FNCLASE,
                                                   FNSEMANA,
                                                   FNANIO,
                                                   FNMONTOCONTADO,
                                                   FNMONTOCREDITO)
                    VALUES (vlcur_objsuc (vl_i).FIIDPAIS,
                            vlcur_objsuc (vl_i).FIIDTERRITORIO,
                            vlcur_objsuc (vl_i).FCDESCTERRIRORIO,
                            vlcur_objsuc (vl_i).FIIDZONA,
                            vlcur_objsuc (vl_i).FCDESCZONAS,
                            vlcur_objsuc (vl_i).FIIDREGION,
                            vlcur_objsuc (vl_i).FCDESCREGION,
                            vlcur_objsuc (vl_i).FIIDSUCURSAL,
                            vlcur_objsuc (vl_i).FCNOMBRESUC,
                            vlcur_objsuc (vl_i).FDFECHA,
                            vlcur_objsuc (vl_i).FNLINEA,
                            vlcur_objsuc (vl_i).FCPRDLINDESC,
                            vlcur_objsuc (vl_i).FNSUBLINEA,
                            vlcur_objsuc (vl_i).FNCLASE,
                            vlcur_objsuc (vl_i).FISEMANA,
                            vlcur_objsuc (vl_i).ANIO,
                            vlcur_objsuc (vl_i).MONTOCONTADO,
                            vlcur_objsuc (vl_i).MONTOCREDITO);

            COMMIT;
            vlcur_objsuc.DELETE;

            PA_CODIGO := csl_200;
            PA_MENSAJE := csl_ok;
         EXCEPTION
            WHEN OTHERS
            THEN
               ROLLBACK;
               PA_CODIGO := SQLCODE;
               PA_MENSAJE := SQLERRM;
               SCSISGES.SPERRORES (
                  SYSDATE,
                  SQLCODE,
                  SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                  'SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSSUC');
         END;
      END LOOP;

      CLOSE cur_objsuc;
   END;

   PROCEDURE SPINSOBJETIVOSREG (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2)
   AS
      CURSOR CUR_OBJREG IS
           SELECT TAOS.FIIDREGION,
                  TAOS.FCDESCREGION,
                  TAOS.FIIDZONA,
                  TAOS.FCDESCZONA,
                  TAOS.FIIDTERRITORIO,
                  TAOS.FCDESCTERRITORIO,
                  TAOS.FIIDPAIS,
                  TAOS.FDFECHA,
                  TAOS.FNLINEA,
                  TAOS.FCLINEADESC,
                  TAOS.FNSUBLINEA,
                  TAOS.FNCLASE,
                  TAOS.FNSEMANA,
                  TAOS.FNANIO,
                  SUM (TAOS.FNMONTOCREDITO)    AS MONTOCREDITO,
                  SUM (TAOS.FNMONTOCONTADO)    AS MONTOCONTADO
             FROM SCSISGES.TAOBJETIVOSUC TAOS
            WHERE     TAOS.FIIDPAIS > csl_0
                  AND TAOS.FIIDTERRITORIO > csl_0
                  AND TAOS.FIIDZONA > csl_0
                  AND TAOS.FIIDREGION > csl_0
         GROUP BY TAOS.FIIDREGION,
                  TAOS.FCDESCREGION,
                  TAOS.FIIDZONA,
                  TAOS.FCDESCZONA,
                  TAOS.FIIDTERRITORIO,
                  TAOS.FCDESCTERRITORIO,
                  TAOS.FIIDPAIS,
                  TAOS.FDFECHA,
                  TAOS.FNLINEA,
                  TAOS.FCLINEADESC,
                  TAOS.FNSUBLINEA,
                  TAOS.FNCLASE,
                  TAOS.FNSEMANA,
                  TAOS.FNANIO;

      TYPE typ_OBJREG IS TABLE OF CUR_OBJREG%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_objreg   typ_OBJREG;
   --INICIA LA FUNCION
   BEGIN
      --CURSOR
      OPEN CUR_OBJREG;

      LOOP
         BEGIN
            FETCH CUR_OBJREG
               BULK COLLECT INTO vlcur_objreg
               LIMIT csl_limite_diezMil;

            EXIT WHEN vlcur_objreg.COUNT = csl_0;

            FORALL vl_i IN vlcur_objreg.FIRST .. vlcur_objreg.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOREG (FIIDPAIS,
                                                   FIIDTERRITORIO,
                                                   FCDESCTERRITORIO,
                                                   FIIDZONA,
                                                   FCDESCZONA,
                                                   FIIDREGION,
                                                   FCDESCREGION,
                                                   FDFECHA,
                                                   FNLINEA,
                                                   FCLINEADESC,
                                                   FNSUBLINEA,
                                                   FNCLASE,
                                                   FNSEMANA,
                                                   FNANIO,
                                                   FNMONTOCONTADO,
                                                   FNMONTOCREDITO)
                    VALUES (vlcur_objreg (vl_i).FIIDPAIS,
                            vlcur_objreg (vl_i).FIIDTERRITORIO,
                            vlcur_objreg (vl_i).FCDESCTERRITORIO,
                            vlcur_objreg (vl_i).FIIDZONA,
                            vlcur_objreg (vl_i).FCDESCZONA,
                            vlcur_objreg (vl_i).FIIDREGION,
                            vlcur_objreg (vl_i).FCDESCREGION,
                            vlcur_objreg (vl_i).FDFECHA,
                            vlcur_objreg (vl_i).FNLINEA,
                            vlcur_objreg (vl_i).FCLINEADESC,
                            vlcur_objreg (vl_i).FNSUBLINEA,
                            vlcur_objreg (vl_i).FNCLASE,
                            vlcur_objreg (vl_i).FNSEMANA,
                            vlcur_objreg (vl_i).FNANIO,
                            vlcur_objreg (vl_i).MONTOCONTADO,
                            vlcur_objreg (vl_i).MONTOCREDITO);

            COMMIT;
            vlcur_objreg.DELETE;

            PA_CODIGO := csl_200;
            PA_MENSAJE := csl_ok;
         EXCEPTION
            WHEN OTHERS
            THEN
               ROLLBACK;
               PA_CODIGO := SQLCODE;
               PA_MENSAJE := SQLERRM;
               SCSISGES.SPERRORES (
                  SYSDATE,
                  SQLCODE,
                  SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                  'SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSREG');
         END;
      END LOOP;

      CLOSE cur_objreg;
   END;

   PROCEDURE SPINSOBJETIVOSZON (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2)
   AS
      CURSOR CUR_OBJZON IS
           SELECT TAOR.FIIDZONA,
                  TAOR.FCDESCZONA,
                  TAOR.FIIDTERRITORIO,
                  TAOR.FCDESCTERRITORIO,
                  TAOR.FIIDPAIS,
                  TAOR.FDFECHA,
                  TAOR.FNLINEA,
                  TAOR.FCLINEADESC,
                  TAOR.FNSUBLINEA,
                  TAOR.FNCLASE,
                  TAOR.FNSEMANA,
                  TAOR.FNANIO,
                  SUM (TAOR.FNMONTOCREDITO)    AS MONTOCREDITO,
                  SUM (TAOR.FNMONTOCONTADO)    AS MONTOCONTADO
             FROM SCSISGES.TAOBJETIVOREG TAOR
            WHERE     TAOR.FIIDPAIS > csl_0
                  AND TAOR.FIIDTERRITORIO > csl_0
                  AND TAOR.FIIDZONA > csl_0
                  AND TAOR.FIIDREGION > csl_0
         GROUP BY TAOR.FIIDZONA,
                  TAOR.FCDESCZONA,
                  TAOR.FIIDTERRITORIO,
                  TAOR.FCDESCTERRITORIO,
                  TAOR.FIIDPAIS,
                  TAOR.FDFECHA,
                  TAOR.FNLINEA,
                  TAOR.FCLINEADESC,
                  TAOR.FNSUBLINEA,
                  TAOR.FNCLASE,
                  TAOR.FNSEMANA,
                  TAOR.FNANIO;

      TYPE typ_Curobjzon IS TABLE OF CUR_OBJZON%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_objzon   typ_Curobjzon;
   --INICIA LA FUNCION
   BEGIN
      --CURSOR
      OPEN CUR_OBJZON;

      LOOP
         BEGIN
            FETCH CUR_OBJZON
               BULK COLLECT INTO vlcur_objzon
               LIMIT csl_limite_diezMil;

            EXIT WHEN vlcur_objzon.COUNT = csl_0;

            FORALL vl_i IN vlcur_objzon.FIRST .. vlcur_objzon.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOZON (FIIDZONA,
                                                   FCDESCZONA,
                                                   FIIDTERRITORIO,
                                                   FCDESCTERRITORIO,
                                                   FIIDPAIS,
                                                   FDFECHA,
                                                   FNLINEA,
                                                   FCLINEADESC,
                                                   FNSUBLINEA,
                                                   FNCLASE,
                                                   FNSEMANA,
                                                   FNANIO,
                                                   FNMONTOCONTADO,
                                                   FNMONTOCREDITO)
                    VALUES (vlcur_objzon (vl_i).FIIDZONA,
                            vlcur_objzon (vl_i).FCDESCZONA,
                            vlcur_objzon (vl_i).FIIDTERRITORIO,
                            vlcur_objzon (vl_i).FCDESCTERRITORIO,
                            vlcur_objzon (vl_i).FIIDPAIS,
                            vlcur_objzon (vl_i).FDFECHA,
                            vlcur_objzon (vl_i).FNLINEA,
                            vlcur_objzon (vl_i).FCLINEADESC,
                            vlcur_objzon (vl_i).FNSUBLINEA,
                            vlcur_objzon (vl_i).FNCLASE,
                            vlcur_objzon (vl_i).FNSEMANA,
                            vlcur_objzon (vl_i).FNANIO,
                            vlcur_objzon (vl_i).MONTOCONTADO,
                            vlcur_objzon (vl_i).MONTOCREDITO);

            COMMIT;
            vlcur_objzon.DELETE;

            PA_CODIGO := csl_200;
            PA_MENSAJE := csl_ok;
         EXCEPTION
            WHEN OTHERS
            THEN
               ROLLBACK;
               PA_CODIGO := SQLCODE;
               PA_MENSAJE := SQLERRM;
               SCSISGES.SPERRORES (
                  SYSDATE,
                  SQLCODE,
                  SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                  'SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSZON');
         END;
      END LOOP;

      CLOSE cur_objzon;
   END;

   PROCEDURE SPINSOBJETIVOSTERR (PA_CODIGO    OUT INTEGER,
                                 PA_MENSAJE   OUT VARCHAR2)
   AS
      CURSOR CUR_OBJTERR IS
           SELECT TAOZ.FIIDTERRITORIO,
                  TAOZ.FCDESCTERRITORIO,
                  TAOZ.FIIDPAIS,
                  TAOZ.FDFECHA,
                  TAOZ.FNLINEA,
                  TAOZ.FCLINEADESC,
                  TAOZ.FNSUBLINEA,
                  TAOZ.FNCLASE,
                  TAOZ.FNSEMANA,
                  TAOZ.FNANIO,
                  SUM (TAOZ.FNMONTOCREDITO)    AS MONTOCREDITO,
                  SUM (TAOZ.FNMONTOCONTADO)    AS MONTOCONTADO
             FROM SCSISGES.TAOBJETIVOZON TAOZ
            WHERE     TAOZ.FIIDPAIS = csl_1
                  AND TAOZ.FIIDTERRITORIO > csl_0
                  AND TAOZ.FIIDZONA > csl_0
         GROUP BY TAOZ.FIIDTERRITORIO,
                  TAOZ.FCDESCTERRITORIO,
                  TAOZ.FIIDPAIS,
                  TAOZ.FDFECHA,
                  TAOZ.FNLINEA,
                  TAOZ.FCLINEADESC,
                  TAOZ.FNSUBLINEA,
                  TAOZ.FNCLASE,
                  TAOZ.FNSEMANA,
                  TAOZ.FNANIO;

      TYPE typ_Curobjterr IS TABLE OF CUR_OBJTERR%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_objterr   typ_Curobjterr;
   --INICIA LA FUNCION
   BEGIN
      --CURSOR
      OPEN CUR_OBJTERR;

      LOOP
         BEGIN
            FETCH CUR_OBJTERR
               BULK COLLECT INTO vlcur_objterr
               LIMIT csl_limite_diezMil;

            EXIT WHEN vlcur_objterr.COUNT = csl_0;

            FORALL vl_i IN vlcur_objterr.FIRST .. vlcur_objterr.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOTER (FIIDTERRITORIO,
                                                   FCDESCTERRITORIO,
                                                   FIIDPAIS,
                                                   FDFECHA,
                                                   FNLINEA,
                                                   FCLINEADESC,
                                                   FNSUBLINEA,
                                                   FNCLASE,
                                                   FNSEMANA,
                                                   FNANIO,
                                                   FNMONTOCONTADO,
                                                   FNMONTOCREDITO)
                    VALUES (vlcur_objterr (vl_i).FIIDTERRITORIO,
                            vlcur_objterr (vl_i).FCDESCTERRITORIO,
                            vlcur_objterr (vl_i).FIIDPAIS,
                            vlcur_objterr (vl_i).FDFECHA,
                            vlcur_objterr (vl_i).FNLINEA,
                            vlcur_objterr (vl_i).FCLINEADESC,
                            vlcur_objterr (vl_i).FNSUBLINEA,
                            vlcur_objterr (vl_i).FNCLASE,
                            vlcur_objterr (vl_i).FNSEMANA,
                            vlcur_objterr (vl_i).FNANIO,
                            vlcur_objterr (vl_i).MONTOCONTADO,
                            vlcur_objterr (vl_i).MONTOCREDITO);

            COMMIT;
            vlcur_objterr.DELETE;

            PA_CODIGO := csl_200;
            PA_MENSAJE := csl_ok;
         EXCEPTION
            WHEN OTHERS
            THEN
               ROLLBACK;
               PA_CODIGO := SQLCODE;
               PA_MENSAJE := SQLERRM;
               SCSISGES.SPERRORES (
                  SYSDATE,
                  SQLCODE,
                  SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                  'SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSPAIS');
         END;
      END LOOP;

      CLOSE CUR_OBJTERR;
   END;

   PROCEDURE SPINSOBJETIVOSPAIS (PA_CODIGO    OUT INTEGER,
                                 PA_MENSAJE   OUT VARCHAR2)
   AS
      CURSOR CUR_OBJPAIS IS
           SELECT TAOT.FIIDPAIS,
                  TAOT.FDFECHA,
                  TAOT.FNLINEA,
                  TAOT.FCLINEADESC,
                  TAOT.FNSUBLINEA,
                  TAOT.FNCLASE,
                  TAOT.FNSEMANA,
                  TAOT.FNANIO,
                  SUM (TAOT.FNMONTOCREDITO)    AS MONTOCREDITO,
                  SUM (TAOT.FNMONTOCONTADO)    AS MONTOCONTADO
             FROM SCSISGES.TAOBJETIVOTER TAOT
            WHERE     TAOT.FIIDPAIS > csl_0
                  AND TAOT.FIIDTERRITORIO > csl_0
                  AND TAOT.FDFECHA IS NOT NULL
                  AND TAOT.FNSEMANA > csl_0
                  AND TAOT.FNANIO > csl_0
         GROUP BY TAOT.FIIDPAIS,
                  TAOT.FDFECHA,
                  TAOT.FNLINEA,
                  TAOT.FCLINEADESC,
                  TAOT.FNSUBLINEA,
                  TAOT.FNCLASE,
                  TAOT.FNSEMANA,
                  TAOT.FNANIO;

      TYPE typ_Curobjpais IS TABLE OF CUR_OBJPAIS%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_objpais   typ_Curobjpais;
   --INICIA LA FUNCION
   BEGIN
      --CURSOR
      OPEN CUR_OBJPAIS;

      LOOP
         BEGIN
            FETCH CUR_OBJPAIS
               BULK COLLECT INTO vlcur_objpais
               LIMIT csl_limite_diezMil;

            EXIT WHEN vlcur_objpais.COUNT = csl_0;

            FORALL vl_i IN vlcur_objpais.FIRST .. vlcur_objpais.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOPAIS (FIIDPAIS,
                                                    FDFECHA,
                                                    FNLINEA,
                                                    FCLINEADESC,
                                                    FNSUBLINEA,
                                                    FNCLASE,
                                                    FNSEMANA,
                                                    FNANIO,
                                                    FNMONTOCONTADO,
                                                    FNMONTOCREDITO)
                    VALUES (vlcur_objpais (vl_i).FIIDPAIS,
                            vlcur_objpais (vl_i).FDFECHA,
                            vlcur_objpais (vl_i).FNLINEA,
                            vlcur_objpais (vl_i).FCLINEADESC,
                            vlcur_objpais (vl_i).FNSUBLINEA,
                            vlcur_objpais (vl_i).FNCLASE,
                            vlcur_objpais (vl_i).FNSEMANA,
                            vlcur_objpais (vl_i).FNANIO,
                            vlcur_objpais (vl_i).MONTOCONTADO,
                            vlcur_objpais (vl_i).MONTOCREDITO);

            COMMIT;
            vlcur_objpais.DELETE;

            PA_CODIGO := csl_200;
            PA_MENSAJE := csl_ok;
         EXCEPTION
            WHEN OTHERS
            THEN
               ROLLBACK;
               PA_CODIGO := SQLCODE;
               PA_MENSAJE := SQLERRM;
               SCSISGES.SPERRORES (
                  SYSDATE,
                  SQLCODE,
                  SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                  'SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSPAIS');
         END;
      END LOOP;

      CLOSE cur_objpais;
   END;
END PAJERARQUIAOBJ;
/

GRANT EXECUTE
   ON SCSISGES.PAJERARQUIAOBJ
   TO USRINFFENIX, USRSISGES, USRINFSISGES;