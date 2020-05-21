--------------------------------------------------------
--  DDL for Package Body PAVTASSEMANALES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAVTASSEMANALES" 
IS
   CLS_0        CONSTANT NUMBER := 0;
   CLS_1        CONSTANT NUMBER := 1;
   CLS_15       CONSTANT NUMBER := 15;
   CLS_16       CONSTANT NUMBER := 16;
   CLS_2018     CONSTANT NUMBER := 2018;
   CLS_8067     CONSTANT NUMBER := 8067;
   CLS_LIDSUB   CONSTANT CHAR (25) := 'LIDER/SUBLIDER';

   PROCEDURE SPPROCESAVTAS (PA_MENSAJE    OUT VARCHAR2,
                            PA_CODERROR   OUT INTEGER,
                            PA_DESERROR   OUT VARCHAR2)
   IS
   BEGIN
      INSERT INTO SCSISGES.TAVENTASEMANAL (FNEMPLEADO,
                                           FCNOMBREEMP,
                                           FIIDSUCURSAL,
                                           FCNOMBRESUC,
                                           FINUMCECOSUC,
                                           FIIDPAIS,
                                           FCPAIS,
                                           FICANAL,
                                           FCCANAL,
                                           FIIDREGION,
                                           FCDESCREGION,
                                           FIIDZONA,
                                           FCDESCZONAS,
                                           FIIDTERRITORIO,
                                           FNTIPOVENTA,
                                           FNLINEA,
                                           FNMONTOTOTAL,
                                           FISEMANA,
                                           FIANIO)
         SELECT DISTINCT VTA.FNEMPLEADO,
                         VTA.FCNOMBRE,
                         VTA.FIIDSUCURSAL,
                         TSUC.FCNOMBRESUC,
                         TSUC.FINUMCECOSUC,
                         TSUC.FIIDPAIS,
                         TGEO.FCPAIS,
                         TSUC.FIIDCANAL,
                         TGEO.FCCANAL,
                         TSUC.FIIDREGION,
                         TREG.FCDESCREGION,
                         TSUC.FIIDZONA,
                         ZON.FCDESCZONAS,
                         TSUC.FIIDTERRITORIO,
                         VTA.FNTIPOVENTA,
                         VTA.FNLINEA,
                         VTA.MONTOTAL,
                         VTA.FISEMANA,
                         VTA.FIANIO
           FROM (  SELECT VO.FNEMPLEADO,
                             EMP.FCNOMBRE
                          || ' '
                          || EMP.FCAPATERNO
                          || ' '
                          || EMP.FCAMATERNO
                             AS FCNOMBRE,
                          VO.FIIDSUCURSAL,
                          VO.FNTIPOVENTA,
                          VO.FNLINEA,
                          SUM (VO.FNMONTO) AS MONTOTAL,
                          TCC.FISEMANA,
                          TCC.FIANIO
                     FROM SCSISGES.TAEMPLEADOPF EMP,
                          SCSISGES.TAVENTASACUMOPE VO,
                          SCSISGES.TCCALENDARIOEKT TCC
                    WHERE     EMP.FNEMPLEADO = VO.FNEMPLEADO
                          AND TRUNC (TCC.FDFECHA) = TRUNC (VO.FDFECHAVENTA)
                          AND VO.FNEMPLEADO > CLS_0
                          AND VO.FIIDSUCURSAL > CLS_0
                          AND EMP.FNFUNCIONSAP = CLS_8067
                          AND EMP.FNCC > CLS_0
                          AND TCC.FISEMANA > CLS_0
                          AND TCC.FIANIO > CLS_0
                          AND TCC.FDFECHA > TO_DATE (CLS_2018, 'YYYY')
                 GROUP BY VO.FNEMPLEADO,
                          EMP.FCNOMBRE,
                          EMP.FCAPATERNO,
                          EMP.FCAMATERNO,
                          VO.FIIDSUCURSAL,
                          VO.FNTIPOVENTA,
                          VO.FNLINEA,
                          TCC.FISEMANA,
                          TCC.FIANIO) VTA
                INNER JOIN SCSISGES.TACECOGEOGRAFIA TGEO
                   ON VTA.FIIDSUCURSAL = TGEO.FINUMECO
                INNER JOIN SCSISGES.TCFXSUCURSAL TSUC
                   ON TSUC.FIIDSUCURSAL = VTA.FIIDSUCURSAL
                INNER JOIN SCSISGES.TAFXREGIONES TREG
                   ON TREG.FIIDREGION = TSUC.FIIDREGION
                INNER JOIN SCSISGES.TAFXZONAS ZON
                   ON ZON.FIIDZONA = TSUC.FIIDZONA
          WHERE     TREG.FIIDPAIS > CLS_0
                AND TREG.FIIDTERRITORIO > CLS_0
                AND TREG.FIIDZONA > CLS_0
                AND TREG.FIIDREGION > CLS_0
                AND TREG.FIESTATUS >= CLS_0
                AND TSUC.FIIDPAIS > CLS_0
                AND TSUC.FIIDTERRITORIO > CLS_0
                AND TSUC.FIIDZONA > CLS_0
                AND TSUC.FIIDREGION > CLS_0
                AND TSUC.FIIDSUCURSAL > CLS_0
                AND ZON.FIIDPAIS > CLS_0
                AND ZON.FIIDTERRITORIO > CLS_0
                AND ZON.FIIDZONA > CLS_0
                AND TGEO.FINUMECO > CLS_0
         UNION ALL
         SELECT DISTINCT VTA.FNEMPLEADO,
                         VTA.FCNOMBRE,
                         VTA.FIIDSUCURSAL,
                         TSUC.FCNOMBRESUC,
                         TSUC.FINUMCECOSUC,
                         TSUC.FIIDPAIS,
                         TGEO.FCPAIS,
                         TSUC.FIIDCANAL,
                         TGEO.FCCANAL,
                         TSUC.FIIDREGION,
                         TREG.FCDESCREGION,
                         TSUC.FIIDZONA,
                         ZON.FCDESCZONAS,
                         TSUC.FIIDTERRITORIO,
                         VTA.FNTIPOVENTA,
                         VTA.FNLINEA,
                         VTA.MONTOTAL,
                         VTA.FISEMANA,
                         VTA.FIANIO
           FROM (  SELECT CLS_0 AS FNEMPLEADO,
                          CLS_LIDSUB AS FCNOMBRE,
                          VO.FIIDSUCURSAL,
                          VO.FNTIPOVENTA,
                          VO.FNLINEA,
                          SUM (VO.FNMONTO) AS MONTOTAL,
                          TCC.FISEMANA,
                          TCC.FIANIO
                     FROM SCSISGES.TAVENTASACUMOPE VO,
                          SCSISGES.TAEMPLEADOPF EMP,
                          SCSISGES.TCCALENDARIOEKT TCC
                    WHERE     VO.FNEMPLEADO = EMP.FNEMPLEADO
                          AND TCC.FDFECHA = VO.FDFECHAVENTA
                          AND EMP.FNFUNCIONSAP <> CLS_8067
                          AND VO.FNEMPLEADO > CLS_0
                          AND VO.FIIDSUCURSAL > CLS_0
                          AND TCC.FISEMANA > CLS_0
                          AND TCC.FIANIO > CLS_0
                          AND TCC.FDFECHA > TO_DATE (CLS_2018, 'YYYY')
                 GROUP BY VO.FIIDSUCURSAL,
                          VO.FNTIPOVENTA,
                          VO.FNLINEA,
                          TCC.FISEMANA,
                          TCC.FIANIO) VTA
                INNER JOIN SCSISGES.TACECOGEOGRAFIA TGEO
                   ON VTA.FIIDSUCURSAL = TGEO.FINUMECO
                INNER JOIN SCSISGES.TCFXSUCURSAL TSUC
                   ON TSUC.FIIDSUCURSAL = VTA.FIIDSUCURSAL
                INNER JOIN SCSISGES.TAFXREGIONES TREG
                   ON TREG.FIIDREGION = TSUC.FIIDREGION
                INNER JOIN SCSISGES.TAFXZONAS ZON
                   ON ZON.FIIDZONA = TSUC.FIIDZONA
          WHERE     TREG.FIIDPAIS > CLS_0
                AND TREG.FIIDTERRITORIO > CLS_0
                AND TREG.FIIDZONA > CLS_0
                AND TREG.FIIDREGION > CLS_0
                AND TREG.FIESTATUS >= CLS_0
                AND TSUC.FIIDPAIS > CLS_0
                AND TSUC.FIIDTERRITORIO > CLS_0
                AND TSUC.FIIDZONA > CLS_0
                AND TSUC.FIIDREGION > CLS_0
                AND TSUC.FIIDSUCURSAL > CLS_0
                AND ZON.FIIDPAIS > CLS_0
                AND ZON.FIIDTERRITORIO > CLS_0
                AND ZON.FIIDZONA > CLS_0
                AND TGEO.FINUMECO > CLS_0;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, 0, 200);
         PA_MENSAJE := 'OCURRIO UN ERROR AL INSERTAR VENTAS SEMANALES';

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             pa_desError,
                             'PAVTASSEMANALES.SPPROCESAVTAS');
   END SPPROCESAVTAS;

   PROCEDURE SPPROCESAOPE (PA_MENSAJE    OUT VARCHAR2,
                           PA_CODERROR   OUT INTEGER,
                           PA_DESERROR   OUT VARCHAR2)
   IS
      VL_CNT   NUMBER (10);
   BEGIN
      SELECT COUNT (1) INTO VL_CNT FROM SCSISGES.TAVENTASACUMOPE;

      IF (VL_CNT) > CLS_0
      THEN
         INSERT INTO SCSISGES.TAVENTASACUMOPE (FNEMPLEADO,
                                               FCNOMBREEMP,
                                               FIIDSUCURSAL,
                                               FNTIPOVENTA,
                                               FNLINEA,
                                               FDFECHAVENTA,
                                               FNMONTO)
            SELECT TV.FNEMPLEADO,
                   TV.FCNOMBREEMP,
                   TV.FIIDSUCURSAL,
                   TV.FNTIPOVENTA,
                   TV.FNLINEA,
                   TV.FDFECHAVENTA,
                   TV.FNMONTO
              FROM SCSISGES.TCLINEA TL, SCSISGES.TAVENTASACUM TV
             WHERE     TRUNC (TV.FDFECHAVENTA) = TRUNC (SYSDATE) - CLS_1
                   AND TV.FNLINEA = TL.FNLINEA
                   AND TV.FNLINEA > CLS_0
                   AND TV.FNEMPLEADO > CLS_0
                   AND TV.FIIDSUCURSAL > CLS_0
                   AND NOT EXISTS
                              (SELECT TVOP.FNEMPLEADO,
                                      TVOP.FCNOMBREEMP,
                                      TVOP.FIIDSUCURSAL,
                                      TVOP.FNTIPOVENTA,
                                      TVOP.FNLINEA,
                                      TVOP.FDFECHAVENTA,
                                      TVOP.FNMONTO,
                                      TVOP.FCUSRCREACION,
                                      TVOP.FDCREACION,
                                      TVOP.FCUSRMODIFICO,
                                      TVOP.FDMODIFICO
                                 FROM SCSISGES.TAVENTASACUMOPE TVOP
                                WHERE TVOP.FDFECHAVENTA BETWEEN SYSDATE
                                                                - CLS_16
                                                            AND SYSDATE
                                                                - CLS_1);

         DELETE FROM SCSISGES.TAVENTASACUMOPE TOPE
               WHERE TRUNC (TOPE.FDFECHAVENTA) < TO_CHAR (SYSDATE - CLS_15);
      ELSE
         INSERT INTO SCSISGES.TAVENTASACUMOPE (FNEMPLEADO,
                                               FCNOMBREEMP,
                                               FIIDSUCURSAL,
                                               FNTIPOVENTA,
                                               FNLINEA,
                                               FDFECHAVENTA,
                                               FNMONTO)
            SELECT TV.FNEMPLEADO,
                   TV.FCNOMBREEMP,
                   TV.FIIDSUCURSAL,
                   TV.FNTIPOVENTA,
                   TV.FNLINEA,
                   TV.FDFECHAVENTA,
                   TV.FNMONTO
              FROM SCSISGES.TCLINEA TL, SCSISGES.TAVENTASACUM TV
             WHERE TV.FNLINEA = TL.FNLINEA
                   AND TRUNC (TV.FDFECHAVENTA) BETWEEN TO_CHAR (
                                                          TRUNC (SYSDATE)
                                                          - CLS_15)
                                                   AND TO_CHAR (
                                                          TRUNC (SYSDATE))
                   AND TV.FNLINEA > CLS_0
                   AND TV.FNEMPLEADO > CLS_0
                   AND TV.FIIDSUCURSAL > CLS_0;
      END IF;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, 0, 200);
         PA_MENSAJE := 'OCURRIO UN ERROR AL PROCESAR OPERATIVO';

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             pa_desError,
                             'PAVTASSEMANALES.SPPROCESAOPE');
   END SPPROCESAOPE;


   PROCEDURE SPPROCESAHIST (PA_MENSAJE    OUT VARCHAR2,
                            PA_CODERROR   OUT INTEGER,
                            PA_DESERROR   OUT VARCHAR2)
   IS
      VL_CNT   NUMBER (10);
   BEGIN
      SELECT COUNT (1) INTO VL_CNT FROM SCSISGES.TAVENTASACUMHIST;

      IF VL_CNT > CLS_0
      THEN
         INSERT INTO SCSISGES.TAVENTASACUMHIST (FNEMPLEADO,
                                                FCNOMBREEMP,
                                                FIIDSUCURSAL,
                                                FNTIPOVENTA,
                                                FNLINEA,
                                                FDFECHAVENTA,
                                                FNMONTO)
            SELECT TV.FNEMPLEADO,
                   TV.FCNOMBREEMP,
                   TV.FIIDSUCURSAL,
                   TV.FNTIPOVENTA,
                   TV.FNLINEA,
                   TV.FDFECHAVENTA,
                   TV.FNMONTO
              FROM SCSISGES.TCLINEA TL, SCSISGES.TAVENTASACUM TV
             WHERE TV.FNLINEA = TL.FNLINEA
                   AND TRUNC (TV.FDFECHAVENTA) =
                          TO_CHAR (TRUNC (SYSDATE) - CLS_16)
                   AND TV.FNLINEA > CLS_0
                   AND TV.FNEMPLEADO > CLS_0
                   AND TV.FIIDSUCURSAL > CLS_0;
      ELSE
         INSERT INTO SCSISGES.TAVENTASACUMHIST (FNEMPLEADO,
                                                FCNOMBREEMP,
                                                FIIDSUCURSAL,
                                                FNTIPOVENTA,
                                                FNLINEA,
                                                FDFECHAVENTA,
                                                FNMONTO)
            SELECT TV.FNEMPLEADO,
                   TV.FCNOMBREEMP,
                   TV.FIIDSUCURSAL,
                   TV.FNTIPOVENTA,
                   TV.FNLINEA,
                   TV.FDFECHAVENTA,
                   TV.FNMONTO
              FROM SCSISGES.TCLINEA TL, SCSISGES.TAVENTASACUM TV
             WHERE TRUNC (TV.FDFECHAVENTA) BETWEEN (SELECT MIN (TCC.FDFECHA)
                                                      FROM SCSISGES.
                                                            TCCALENDARIOEKT TCC
                                                     WHERE TCC.FIANIO =
                                                              TO_CHAR (
                                                                 TRUNC (
                                                                    SYSDATE),
                                                                 'YYYY')
                                                              - CLS_1
                                                           AND TCC.FISEMANA >
                                                                  CLS_0
                                                           AND TCC.FIANIO >
                                                                  CLS_0)
                                               AND TRUNC (SYSDATE) - CLS_16
                   AND TV.FNLINEA = TL.FNLINEA
                   AND TV.FNLINEA > CLS_0
                   AND TV.FNEMPLEADO > CLS_0
                   AND TV.FIIDSUCURSAL > CLS_0;
      END IF;

      COMMIT;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, 0, 200);
         PA_MENSAJE := 'OCURRIO UN ERROR AL PROCESAR HISTORICO';

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             pa_desError,
                             'PAVTASSEMANALES.SPPROCESAHIST');
   END SPPROCESAHIST;
END PAVTASSEMANALES;

/

  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "USRSISGES";
