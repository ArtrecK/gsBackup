--------------------------------------------------------
--  DDL for Package Body PAPROCESAOBJETIVOS
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAPROCESAOBJETIVOS" 
AS
   csl_200      CONSTANT INTEGER := 200;
   csl_ok       CONSTANT VARCHAR (2) := 'OK';
   csl_0        CONSTANT INTEGER := 0;
   csl_1        CONSTANT INTEGER := 1;
   csl_2        CONSTANT INTEGER := 2;
   csl_3        CONSTANT INTEGER := 3;
   csl_limite   CONSTANT INTEGER := 250;

   PROCEDURE SPINSJERARQUIA (PA_CODIGO OUT INTEGER, PA_MENSAJE OUT VARCHAR2)
   AS
      vl_codigoSPSUC     INTEGER;
      vl_mensajeSPSUC    VARCHAR2 (200);
      vl_codigoSPREG     INTEGER;
      vl_mensajeSPREG    VARCHAR2 (200);
      vl_codigoSPZON     INTEGER;
      vl_mensajeSPZON    VARCHAR2 (200);
      vl_codigoSPTERR    INTEGER;
      vl_mensajeSPTERR   VARCHAR2 (200);
      vl_codigoSPSPAIS   INTEGER;
      vl_mensajeSPPAIS   VARCHAR2 (200);
   BEGIN
      --INSERTAR SUCURSAL
      SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSSUC (vl_codigoSPSUC,
                                                 vl_mensajeSPSUC);

      --INSERTAR REGION
      SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSREG (vl_codigoSPREG,
                                                 vl_mensajeSPREG);

      --INSERTAR ZONA
      SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSZON (vl_codigoSPZON,
                                                 vl_mensajeSPZON);

      --INSERTAR TERRITORIO
      SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSTERR (vl_codigoSPTERR,
                                                  vl_mensajeSPTERR);

      --INSERTAR PAIS
      SCSISGES.PAJERARQUIAOBJ.SPINSOBJETIVOSPAIS (vl_codigoSPSPAIS,
                                                  vl_mensajeSPPAIS);

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
            'SCSISGES.PAPROCESAOBJETIVOS.SPINSJERARQUIA');
   END SPINSJERARQUIA;

   PROCEDURE SPPROCESOSDIA (PA_CODIGO OUT INTEGER, PA_MENSAJE OUT VARCHAR2)
   AS
      vl_codigoSPJER       INTEGER;
      vl_mensajeSPJER      VARCHAR2 (200);
      vl_actualiza         INTEGER;
      vl_validaObjetivos   INTEGER;
      vl_codigoSPEMP       INTEGER;
      vl_mensajeSPEMP      VARCHAR2 (200);
      vl_bandera           NUMBER := 0;
   BEGIN
      BEGIN
         --REGISTRAR INICIO DE PROCESO
         vl_bandera :=
            SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                        'PKSPPROCESOSDIA',
                                        SYSDATE,          --FECHA DE EJECUCION
                                        NULL,          --DESCRIPCION DEL ERROR
                                        csl_0, --STATUS, INDICAR FINAL DE MAPA
                                        csl_0,                --ID DEL PROCESO
                                        csl_0 --indicamos el inicio de un mapa
                                             );

         SELECT COUNT (csl_1)
           INTO vl_actualiza
           FROM SCSISGES.TAOBJETIVOS
          WHERE     TO_CHAR (FDFECHAACTUALIZA, 'dd/MM/yyyy') =
                    TO_CHAR (SYSDATE - csl_1, 'dd/MM/yyyy')
                AND FNCCOSTO > csl_0;

         SELECT COUNT (csl_1)
           INTO vl_validaObjetivos
           FROM SCSISGES.TAOBJETIVOSUC TAOS
          WHERE     TAOS.FIIDPAIS > csl_0
                AND TAOS.FIIDTERRITORIO > csl_0
                AND TAOS.FIIDZONA > csl_0
                AND TAOS.FIIDREGION > csl_0;

         IF vl_actualiza > csl_0 OR vl_validaObjetivos = csl_0
         THEN
            --BORRADO DE LAS TABLAS
            EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAOBJETIVOSUC';

            EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAOBJETIVOREG';

            EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAOBJETIVOZON';

            EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAOBJETIVOTER';

            EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TAOBJETIVOPAIS';

            --INSERTAR JERARQUIA
            SCSISGES.PAPROCESAOBJETIVOS.SPINSJERARQUIA (vl_codigoSPJER,
                                                        vl_mensajeSPJER);
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            ROLLBACK;
      END;

      --INSERTAR OBJETIVOS DIARIOS
      SCSISGES.PAPROCESAOBJETIVOS.SPINSOBJETIVOSEMP (vl_codigoSPEMP,
                                                     vl_mensajeSPEMP);

      --REGISTRAR FIN DE PROCESO
      vl_bandera :=
         SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                     EXTRACT (MONTH FROM SYSDATE),
                                     EXTRACT (DAY FROM SYSDATE),
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                     'PKSPPROCESOSDIA',
                                     SYSDATE,             --FECHA DE EJECUCION
                                     NULL,             --DESCRIPCION DEL ERROR
                                     csl_0,    --STATUS, INDICAR FINAL DE MAPA
                                     csl_0,                   --ID DEL PROCESO
                                     csl_1    --indicamos el inicio de un mapa
                                          );

      PA_CODIGO := csl_200;
      PA_MENSAJE := csl_ok;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         --REGISTRAR FIN DE PROCESO
         vl_bandera :=
            SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                        'PKSPPROCESOSDIA',
                                        SYSDATE,          --FECHA DE EJECUCION
                                        NULL,          --DESCRIPCION DEL ERROR
                                        csl_0, --STATUS, INDICAR FINAL DE MAPA
                                        csl_0,                --ID DEL PROCESO
                                        csl_2 --indicamos el inicio de un mapa
                                             );

         PA_CODIGO := SQLCODE;
         PA_MENSAJE := SQLERRM;
         SCSISGES.SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAPROCESAOBJETIVOS.SPPROCESOSDIA');
   END SPPROCESOSDIA;

   PROCEDURE SPINSOBJETIVOSEMP (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2)
   AS
      CURSOR cur_sucursales IS
         SELECT DISTINCT TAOS.FIIDSUCURSAL
           FROM SCSISGES.TAOBJETIVOSUC TAOS
          WHERE     TAOS.FIIDPAIS > csl_0
                AND TAOS.FIIDTERRITORIO > csl_0
                AND TAOS.FIIDZONA > csl_0
                AND TAOS.FIIDREGION > csl_0;

      TYPE typ_curSucursales IS TABLE OF cur_sucursales%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_sucursales   typ_curSucursales;
   BEGIN
      --BORRADO DE OBJETIVOS DIARIOS
      DELETE SCSISGES.TAOBJETIVOEMP TAOE
       WHERE TAOE.FDFECHA = TO_CHAR (SYSDATE, 'yyyyMMdd');

      --CURSOR
      OPEN cur_sucursales;

      LOOP
         BEGIN
            FETCH cur_sucursales
               BULK COLLECT INTO vlcur_sucursales
               LIMIT csl_limite;

            EXIT WHEN vlcur_sucursales.COUNT = csl_0;

            FORALL vl_i IN vlcur_sucursales.FIRST .. vlcur_sucursales.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOEMP (FNEMPLEADO,
                                                   FCNOMBREEMP,
                                                   FIIDSUCURSAL,
                                                   FCNOMBRESUC,
                                                   FIIDPAIS,
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
                    SELECT TAE.FNEMPLEADO,
                              TAE.FCNOMBRE
                           || ' '
                           || TAE.FCAPATERNO
                           || ' '
                           || TAE.FCAMATERNO,
                           TAOS.FIIDSUCURSAL,
                           TAOS.FCNOMBRESUC,
                           TAOS.FIIDPAIS,
                           TAOS.FIIDTERRITORIO,
                           TAOS.FCDESCTERRITORIO,
                           TAOS.FIIDZONA,
                           TAOS.FCDESCZONA,
                           TAOS.FIIDREGION,
                           TAOS.FCDESCREGION,
                           TAOS.FDFECHA,
                           TAOS.FNLINEA,
                           TAOS.FCLINEADESC,
                           TAOS.FNSUBLINEA,
                           TAOS.FNCLASE,
                           TAOS.FNSEMANA,
                           TAOS.FNANIO,
                           TRUNC (
                                TAOS.FNMONTOCONTADO
                              / (SELECT COUNT (csl_1)
                                   FROM SCSISGES.TAEMPLEADOPF TAE
                                        INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                                           ON TAE.FNCC = TCS.FINUMCECOSUC
                                  WHERE     TCS.FIIDSUCURSAL =
                                            vlcur_sucursales (vl_i).FIIDSUCURSAL
                                        AND TAE.FIIDPERFIL = csl_1
                                        AND TAE.FIIDLABORA = csl_1
                                        AND TAE.FISITUACION = csl_1
                                        AND TAE.FNEMPLEADO > csl_0),
                              csl_2),
                           TRUNC (
                                TAOS.FNMONTOCREDITO
                              / (SELECT COUNT (csl_1)
                                   FROM SCSISGES.TAEMPLEADOPF TAE
                                        INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                                           ON TAE.FNCC = TCS.FINUMCECOSUC
                                  WHERE     TCS.FIIDSUCURSAL =
                                            vlcur_sucursales (vl_i).FIIDSUCURSAL
                                        AND TAE.FIIDPERFIL = csl_1
                                        AND TAE.FIIDLABORA = csl_1
                                        AND TAE.FISITUACION = csl_1
                                        AND TAE.FNEMPLEADO > csl_0),
                              csl_2)
                      FROM SCSISGES.TAOBJETIVOSUC TAOS
                           INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                              ON TAOS.FIIDSUCURSAL = TCS.FIIDSUCURSAL
                           INNER JOIN SCSISGES.TAEMPLEADOPF TAE
                              ON     TCS.FINUMCECOSUC = TAE.FNCC
                                 AND TAE.FIIDPERFIL = csl_1
                                 AND TAE.FIIDLABORA = csl_1
                                 AND FISITUACION = csl_1
                     WHERE     TAOS.FIIDSUCURSAL =
                               vlcur_sucursales (vl_i).FIIDSUCURSAL
                           AND TAOS.FDFECHA = TO_CHAR (SYSDATE, 'yyyyMMdd')
                           AND TCS.FINUMCECOSUC > csl_0
                  GROUP BY TAOS.FNLINEA,
                           TAOS.FCLINEADESC,
                           TAE.FNEMPLEADO,
                           TAOS.FIIDPAIS,
                           TAOS.FIIDTERRITORIO,
                           TAOS.FCDESCTERRITORIO,
                           TAOS.FIIDZONA,
                           TAOS.FCDESCZONA,
                           TAOS.FIIDREGION,
                           TAOS.FCDESCREGION,
                           TAOS.FIIDSUCURSAL,
                           TAOS.FCNOMBRESUC,
                           TAOS.FNSEMANA,
                           TAOS.FNANIO,
                           TAOS.FNSUBLINEA,
                           TAOS.FNCLASE,
                           TAE.FCNOMBRE,
                           TAE.FCAPATERNO,
                           TAE.FCAMATERNO,
                           TAOS.FDFECHA,
                           TAOS.FNMONTOCONTADO,
                           TAOS.FNMONTOCREDITO;

            COMMIT;
            vlcur_sucursales.DELETE;
         EXCEPTION
            WHEN OTHERS
            THEN
               CONTINUE;
         END;
      END LOOP;

      CLOSE cur_sucursales;

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
            'SCSISGES.PAPROCESAOBJETIVOS.SPINSOBJETIVOSEMP');
   END SPINSOBJETIVOSEMP;

   PROCEDURE SPPROCESOSSEM (PA_CODIGO OUT INTEGER, PA_MENSAJE OUT VARCHAR2)
   AS
      vl_codigoSPEMACSEM    INTEGER;
      vl_mensajeSPEMACSEM   VARCHAR2 (200);
      vl_codigoSPHIST       INTEGER;
      vl_mensajeSPHIST      VARCHAR2 (200);
      vl_codigoSPDEM        INTEGER;
      vl_mensajeSPDEM       VARCHAR2 (200);
      vl_semana             INTEGER;
      vl_bandera            NUMBER := 0;
   BEGIN
      --REGISTRAR INICIO DE PROCESO
      vl_bandera :=
         SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                     EXTRACT (MONTH FROM SYSDATE),
                                     EXTRACT (DAY FROM SYSDATE),
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                     'PKSPPROCESOSSEM',
                                     SYSDATE,             --FECHA DE EJECUCION
                                     NULL,             --DESCRIPCION DEL ERROR
                                     csl_0,    --STATUS, INDICAR FINAL DE MAPA
                                     csl_0,                   --ID DEL PROCESO
                                     csl_0    --indicamos el inicio de un mapa
                                          );

      SELECT FISEMANA
        INTO vl_semana
        FROM SCSISGES.TCCALENDARIOEKT TCC
       WHERE TRUNC (TCC.FDFECHA) = TRUNC (SYSDATE);

      --INSERTAR HISTORICA
      SCSISGES.PAPROCESAOBJETIVOS.SPINSOBJETIVOSHIST (vl_semana,
                                                      vl_codigoSPHIST,
                                                      vl_mensajeSPHIST);

      --ELIMINAR OBJETIVOS EMPLEADO
      SCSISGES.PAPROCESAOBJETIVOS.SPDELOBJETIVOSEMP (vl_semana,
                                                     vl_codigoSPDEM,
                                                     vl_mensajeSPDEM);

      --INSERTAR OBJETIVOS SEMANALES
      SCSISGES.PAPROCESAOBJETIVOS.SPINSOBJETIVOSEMEMP (vl_semana,
                                                       vl_codigoSPHIST,
                                                       vl_mensajeSPHIST);

      PA_CODIGO := csl_200;
      PA_MENSAJE := csl_ok;

      --REGISTRAR FIN DE PROCESO
      vl_bandera :=
         SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                     EXTRACT (MONTH FROM SYSDATE),
                                     EXTRACT (DAY FROM SYSDATE),
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                     'PKSPPROCESOSSEM',
                                     SYSDATE,             --FECHA DE EJECUCION
                                     NULL,             --DESCRIPCION DEL ERROR
                                     csl_0,    --STATUS, INDICAR FINAL DE MAPA
                                     csl_0,                   --ID DEL PROCESO
                                     csl_1    --indicamos el inicio de un mapa
                                          );
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;

         --REGISTRAR FIN DE PROCESO
         vl_bandera :=
            SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                        'PKSPPROCESOSSEM',
                                        SYSDATE,          --FECHA DE EJECUCION
                                        NULL,          --DESCRIPCION DEL ERROR
                                        csl_0, --STATUS, INDICAR FINAL DE MAPA
                                        csl_0,                --ID DEL PROCESO
                                        csl_2 --indicamos el inicio de un mapa
                                             );

         PA_CODIGO := SQLCODE;
         PA_MENSAJE := SQLERRM;
         SCSISGES.SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAPROCESAOBJETIVOS.SPPROCESOSSEM');
   END SPPROCESOSSEM;

   PROCEDURE SPINSOBJETIVOSHIST (PA_SEMANA    IN     INTEGER,
                                 PA_CODIGO       OUT INTEGER,
                                 PA_MENSAJE      OUT VARCHAR2)
   AS
   BEGIN
      INSERT INTO SCSISGES.THOBJETIVOEMP (FNEMPLEADO,
                                          FCNOMBREEMP,
                                          FIIDSUCURSAL,
                                          FCNOMBRESUC,
                                          FIIDPAIS,
                                          FIIDTERRITORIO,
                                          FCDESCTERRITORIO,
                                          FIIDZONA,
                                          FCDESCZONA,
                                          FIIDREGION,
                                          FCDESCREGION,
                                          FDFECHA,
                                          FNLINEA,
                                          FCLINEADESC,
                                          FNSEMANA,
                                          FNANIO,
                                          FNMONTOCONTADO,
                                          FNMONTOCREDITO)
         SELECT TAOE.FNEMPLEADO,
                TAOE.FCNOMBREEMP,
                TAOE.FIIDSUCURSAL,
                TAOE.FCNOMBRESUC,
                TAOE.FIIDPAIS,
                TAOE.FIIDTERRITORIO,
                TAOE.FCDESCTERRITORIO,
                TAOE.FIIDZONA,
                TAOE.FCDESCZONA,
                TAOE.FIIDREGION,
                TAOE.FCDESCREGION,
                TAOE.FDFECHA,
                TAOE.FNLINEA,
                TAOE.FCLINEADESC,
                TAOE.FNSEMANA,
                TAOE.FNANIO,
                TAOE.FNMONTOCONTADO,
                TAOE.FNMONTOCREDITO
           FROM SCSISGES.TAOBJETIVOEMP TAOE
          WHERE     TAOE.FNSEMANA = (PA_SEMANA - csl_1)
                AND TAOE.FDFECHA IS NULL
                AND FNEMPLEADO > csl_0;

      COMMIT;

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
            'SCSISGES.PAPROCESAOBJETIVOS.SPINSOBJETIVOSHIST');
   END SPINSOBJETIVOSHIST;

   PROCEDURE SPDELOBJETIVOSEMP (PA_SEMANA    IN     INTEGER,
                                PA_CODIGO       OUT INTEGER,
                                PA_MENSAJE      OUT VARCHAR2)
   AS
   BEGIN
      DELETE SCSISGES.TAOBJETIVOEMP TAOE
       WHERE TAOE.FNSEMANA = (PA_SEMANA - csl_1) AND TAOE.FNEMPLEADO > CSL_0;

      COMMIT;

      PA_CODIGO := csl_200;
      PA_MENSAJE := csl_ok;
   EXCEPTION
      WHEN OTHERS
      THEN
         PA_CODIGO := SQLCODE;
         PA_MENSAJE := SQLERRM;
         SCSISGES.SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAPROCESAOBJETIVOS.SPDELOBJETIVOSEMP');
   END SPDELOBJETIVOSEMP;

   PROCEDURE SPINSOBJETIVOSEMEMP (PA_SEMANA    IN     INTEGER,
                                  PA_CODIGO       OUT INTEGER,
                                  PA_MENSAJE      OUT VARCHAR2)
   AS
      CURSOR cur_sucursales IS
         SELECT DISTINCT TAOS.FIIDSUCURSAL
           FROM SCSISGES.TAOBJETIVOSUC TAOS
          WHERE     TAOS.FIIDPAIS > csl_0
                AND TAOS.FIIDTERRITORIO > csl_0
                AND TAOS.FIIDZONA > csl_0
                AND TAOS.FIIDREGION > csl_0;

      TYPE typ_curSucursales IS TABLE OF cur_sucursales%ROWTYPE
         INDEX BY PLS_INTEGER;

      vlcur_sucursales   typ_curSucursales;
   BEGIN
      --CURSOR
      OPEN cur_sucursales;

      LOOP
         BEGIN
            FETCH cur_sucursales
               BULK COLLECT INTO vlcur_sucursales
               LIMIT csl_limite;

            EXIT WHEN vlcur_sucursales.COUNT = csl_0;

            FORALL vl_i IN vlcur_sucursales.FIRST .. vlcur_sucursales.COUNT
               INSERT INTO SCSISGES.TAOBJETIVOEMP (FNEMPLEADO,
                                                   FCNOMBREEMP,
                                                   FIIDSUCURSAL,
                                                   FCNOMBRESUC,
                                                   FIIDPAIS,
                                                   FIIDTERRITORIO,
                                                   FCDESCTERRITORIO,
                                                   FIIDZONA,
                                                   FCDESCZONA,
                                                   FIIDREGION,
                                                   FCDESCREGION,
                                                   FNLINEA,
                                                   FCLINEADESC,
                                                   FNSUBLINEA,
                                                   FNCLASE,
                                                   FNSEMANA,
                                                   FNANIO,
                                                   FNMONTOCONTADO,
                                                   FNMONTOCREDITO)
                    SELECT TAE.FNEMPLEADO,
                              TAE.FCNOMBRE
                           || ' '
                           || TAE.FCAPATERNO
                           || ' '
                           || TAE.FCAMATERNO,
                           TAOS.FIIDSUCURSAL,
                           TAOS.FCNOMBRESUC,
                           TAOS.FIIDPAIS,
                           TAOS.FIIDTERRITORIO,
                           TAOS.FCDESCTERRITORIO,
                           TAOS.FIIDZONA,
                           TAOS.FCDESCZONA,
                           TAOS.FIIDREGION,
                           TAOS.FCDESCREGION,
                           TAOS.FNLINEA,
                           TAOS.FCLINEADESC,
                           TAOS.FNSUBLINEA,
                           TAOS.FNCLASE,
                           TAOS.FNSEMANA,
                           TAOS.FNANIO,
                           TRUNC (
                                SUM (TAOS.FNMONTOCONTADO)
                              / (SELECT COUNT (csl_1)
                                   FROM SCSISGES.TAEMPLEADOPF TAE
                                        INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                                           ON TAE.FNCC = TCS.FINUMCECOSUC
                                  WHERE     TCS.FIIDSUCURSAL =
                                            vlcur_sucursales (vl_i).FIIDSUCURSAL
                                        AND TAE.FIIDPERFIL = csl_1
                                        AND TAE.FIIDLABORA IN (csl_1, csl_3)
                                        AND TAE.FISITUACION = csl_1
                                        AND TAE.FNEMPLEADO > csl_0),
                              csl_2),
                           TRUNC (
                                SUM (TAOS.FNMONTOCREDITO)
                              / (SELECT COUNT (csl_1)
                                   FROM SCSISGES.TAEMPLEADOPF TAE
                                        INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                                           ON TAE.FNCC = TCS.FINUMCECOSUC
                                  WHERE     TCS.FIIDSUCURSAL =
                                            vlcur_sucursales (vl_i).FIIDSUCURSAL
                                        AND TAE.FIIDPERFIL = csl_1
                                        AND TAE.FIIDLABORA IN (csl_1, csl_3)
                                        AND TAE.FISITUACION = csl_1
                                        AND TAE.FNEMPLEADO > csl_0),
                              csl_2)
                      FROM SCSISGES.TAOBJETIVOSUC TAOS
                           INNER JOIN SCSISGES.TCFXSUCURSAL TCS
                              ON TAOS.FIIDSUCURSAL = TCS.FIIDSUCURSAL
                           INNER JOIN SCSISGES.TAEMPLEADOPF TAE
                              ON     TCS.FINUMCECOSUC = TAE.FNCC
                                 AND TAE.FIIDPERFIL = csl_1
                                 AND TAE.FIIDLABORA IN (csl_1, csl_3)
                                 AND FISITUACION = csl_1
                     WHERE     TAOS.FIIDSUCURSAL =
                               vlcur_sucursales (vl_i).FIIDSUCURSAL
                           AND TAOS.FNSEMANA = PA_SEMANA
                           AND TCS.FINUMCECOSUC > csl_0
                  GROUP BY TAOS.FNLINEA,
                           TAOS.FCLINEADESC,
                           TAE.FNEMPLEADO,
                           TAE.FCNOMBRE,
                           TAE.FCAPATERNO,
                           TAE.FCAMATERNO,
                           TAOS.FIIDPAIS,
                           TAOS.FIIDTERRITORIO,
                           TAOS.FCDESCTERRITORIO,
                           TAOS.FIIDZONA,
                           TAOS.FCDESCZONA,
                           TAOS.FIIDREGION,
                           TAOS.FCDESCREGION,
                           TAOS.FIIDSUCURSAL,
                           TAOS.FCNOMBRESUC,
                           TAOS.FNSEMANA,
                           TAOS.FNANIO,
                           TAOS.FNSUBLINEA,
                           TAOS.FNCLASE;

            COMMIT;
            vlcur_sucursales.DELETE;
         EXCEPTION
            WHEN OTHERS
            THEN
               CONTINUE;
         END;
      END LOOP;

      CLOSE cur_sucursales;

      PA_CODIGO := csl_200;
      PA_MENSAJE := csl_ok;
   EXCEPTION
      WHEN OTHERS
      THEN
         PA_CODIGO := SQLCODE;
         PA_MENSAJE := SQLERRM;
         SCSISGES.SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAPROCESAOBJETIVOS.SPINSOBJETIVOSEMEMP');
   END SPINSOBJETIVOSEMEMP;

   PROCEDURE SPDELOBJETIVOSHIST (PA_CODIGO    OUT INTEGER,
                                 PA_MENSAJE   OUT VARCHAR2)
   AS
      ANIO         INTEGER;
      vl_bandera   NUMBER := 0;
   BEGIN
      --REGISTRAR INICIO DE PROCESO
      vl_bandera :=
         SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                     EXTRACT (MONTH FROM SYSDATE),
                                     EXTRACT (DAY FROM SYSDATE),
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                     'PKSPDELOBJETIVOSHIST',
                                     SYSDATE,             --FECHA DE EJECUCION
                                     NULL,             --DESCRIPCION DEL ERROR
                                     csl_0,    --STATUS, INDICAR FINAL DE MAPA
                                     csl_0,                   --ID DEL PROCESO
                                     csl_0    --indicamos el inicio de un mapa
                                          );

      SELECT EXTRACT (YEAR FROM SYSDATE) INTO ANIO FROM DUAL;

      DELETE SCSISGES.THOBJETIVOEMP THOE
       WHERE THOE.FNANIO = (ANIO - csl_2);

      COMMIT;

      PA_CODIGO := csl_200;
      PA_MENSAJE := csl_ok;

      --REGISTRAR FIN DE PROCESO
      vl_bandera :=
         SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                     EXTRACT (MONTH FROM SYSDATE),
                                     EXTRACT (DAY FROM SYSDATE),
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                     TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                     'PKSPDELOBJETIVOSHIST',
                                     SYSDATE,             --FECHA DE EJECUCION
                                     NULL,             --DESCRIPCION DEL ERROR
                                     csl_0,    --STATUS, INDICAR FINAL DE MAPA
                                     csl_0,                   --ID DEL PROCESO
                                     csl_1    --indicamos el inicio de un mapa
                                          );
   EXCEPTION
      WHEN OTHERS
      THEN
         PA_CODIGO := SQLCODE;
         PA_MENSAJE := SQLERRM;

         --REGISTRAR FIN DE PROCESO
         vl_bandera :=
            SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                        'PKSPDELOBJETIVOSHIST',
                                        SYSDATE,          --FECHA DE EJECUCION
                                        NULL,          --DESCRIPCION DEL ERROR
                                        csl_0, --STATUS, INDICAR FINAL DE MAPA
                                        csl_0,                --ID DEL PROCESO
                                        csl_2 --indicamos el inicio de un mapa
                                             );

         SCSISGES.SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAPROCESAOBJETIVOS.SPDELOBJETIVOSHIST');
   END SPDELOBJETIVOSHIST;
END PAPROCESAOBJETIVOS;
/

GRANT EXECUTE
   ON SCSISGES.PAPROCESAOBJETIVOS
   TO USRINFFENIX, USRSISGES, USRINFSISGES;