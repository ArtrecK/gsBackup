--------------------------------------------------------
--  DDL for Package Body PAOBJETIVOSSEM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAOBJETIVOSSEM" 
AS
   csl_codigocontado   CONSTANT VARCHAR (10) := '4000000100';
   csl_codigocredito   CONSTANT VARCHAR (10) := '4000000101';
   csl_200             CONSTANT INTEGER := 200;
   csl_ok              CONSTANT VARCHAR (2) := 'OK';
   csl_0p00            CONSTANT NUMBER := 0.00;
   csl_0               CONSTANT INTEGER := 0;
   csl_1               CONSTANT INTEGER := 1;
   csl_2               CONSTANT INTEGER := 2;
   csl_4               CONSTANT INTEGER := 4;

   PROCEDURE SPOBJETIVOSEMEMP (
      PA_FNEMPLEADO        IN     SCSISGES.TAOBJETIVOEMP.FNEMPLEADO%TYPE,
      PA_FDFECHA           IN     SCSISGES.TAOBJETIVOEMP.FDFECHA%TYPE,
      CUR_OBJETIVOSEMEMP      OUT SYS_REFCURSOR,
      PA_CODIGO               OUT INTEGER,
      PA_MENSAJE              OUT VARCHAR2)
   AS
      vl_semana   INTEGER;
   BEGIN
      VL_SEMANA := SCSISGES.FNOBTIENESEMANA (PA_FDFECHA);

      OPEN cur_objetivosememp FOR
         SELECT DISTINCT
                fnempleado AS id,
                fcnombreemp AS descripcion,
                (SELECT XMLELEMENT (
                           "OBJETIVOS",
                           XMLAGG (
                              XMLELEMENT (
                                 "LINEA",
                                 XMLFOREST (
                                    a.id_linea AS "ID_LINEA",
                                    a.desc_linea AS "DESC_LINEA",
                                    a.total_obj AS "TOTAL_OBJ",
                                    a.total_vta AS "TOTAL_VTA",
                                    a.total_falta AS "TOTAL_FALTA",
                                    a.credito_obj AS "CREDITO_OBJ",
                                    a.credito_vta AS "CREDITO_VTA",
                                    a.credito_falta AS "CREDITO_FALTA",
                                    a.contado_obj AS "CONTADO_OBJ",
                                    a.contado_vta AS "CONTADO_VTA",
                                    a.contado_falta AS "CONTADO_FALTA")))).
                         getstringval ()
                           AS "OBJETIVOS"
                   FROM (  SELECT id,
                                  id_linea,
                                  desc_linea,
                                  SUM (obj_credito) + SUM (obj_contado)
                                     total_obj,
                                  SUM (vta_credito) + SUM (vta_contado)
                                     total_vta,
                                  (SUM (obj_credito) + SUM (obj_contado))
                                  - (SUM (vta_credito) + SUM (vta_contado))
                                     total_falta,
                                  SUM (obj_credito) credito_obj,
                                  SUM (vta_credito) credito_vta,
                                  (SUM (obj_credito)) - (SUM (vta_credito))
                                     credito_falta,
                                  SUM (obj_contado) contado_obj,
                                  SUM (vta_contado) contado_vta,
                                  (SUM (obj_contado)) - (SUM (vta_contado))
                                     contado_falta
                             FROM (SELECT fnempleado AS id,
                                          fnlinea AS id_linea,
                                          fclineadesc AS desc_linea,
                                          NVL (fnmontocredito, csl_0p00)
                                             AS obj_credito,
                                          NVL (fnmontocontado, csl_0p00)
                                             AS obj_contado,
                                          csl_0p00 AS vta_credito,
                                          csl_0p00 AS vta_contado
                                     FROM scsisges.taobjetivoemp
                                    WHERE     fnempleado = pa_fnempleado
                                          AND fdfecha IS NULL
                                          AND fnsemana = VL_SEMANA
                                          AND fnanio =
                                                 TO_CHAR (
                                                    TO_DATE (pa_fdfecha,
                                                             'yyyymmdd'),
                                                    'YYYY')
                                   UNION ALL
                                     SELECT t.fnempleado AS id,
                                            t.fnlinea AS id_linea,
                                            l.fcprdlindesc AS desc_linea,
                                            csl_0p00 AS obj_credito,
                                            csl_0p00 AS obj_contado,
                                            (SELECT NVL (SUM (tt.fnmontototal),
                                                         csl_0p00)
                                               FROM    scsisges.taventasemanal tt
                                                    RIGHT JOIN
                                                       scsisges.tclinea l
                                                    ON l.fnlinea = tt.fnlinea
                                              WHERE tt.fnlinea = t.fnlinea
                                                    AND tt.fntipoventa = csl_2
                                                    AND tt.fnempleado =
                                                           pa_fnempleado
                                                    AND tt.fisemana = VL_SEMANA
                                                    AND tt.fianio =
                                                           TO_CHAR (
                                                              TO_DATE (
                                                                 pa_fdfecha,
                                                                 'yyyymmdd'),
                                                              'YYYY'))
                                               AS vta_credito,
                                            (SELECT NVL (SUM (tt.fnmontototal),
                                                         csl_0p00)
                                               FROM    scsisges.taventasemanal tt
                                                    RIGHT JOIN
                                                       scsisges.tclinea l
                                                    ON l.fnlinea = tt.fnlinea
                                              WHERE tt.fnlinea = t.fnlinea
                                                    AND tt.fntipoventa = csl_1
                                                    AND tt.fnempleado =
                                                           pa_fnempleado
                                                    AND tt.fisemana = VL_SEMANA
                                                    AND tt.fianio =
                                                           TO_CHAR (
                                                              TO_DATE (
                                                                 pa_fdfecha,
                                                                 'yyyymmdd'),
                                                              'YYYY'))
                                               AS vta_contado
                                       FROM    scsisges.taventasemanal t
                                            RIGHT JOIN
                                               scsisges.tclinea l
                                            ON t.fnlinea = l.fnlinea
                                      WHERE t.fnempleado = pa_fnempleado
                                            AND t.fisemana = VL_SEMANA
                                            AND t.fianio =
                                                   TO_CHAR (
                                                      TO_DATE (pa_fdfecha,
                                                               'yyyymmdd'),
                                                      'YYYY')
                                   GROUP BY t.fnempleado,
                                            t.fnlinea,
                                            l.fcprdlindesc)
                         GROUP BY id, id_linea, desc_linea
                         ORDER BY id_linea) a
                  WHERE id = b.fnempleado)
                   AS objetivo
           FROM scsisges.taobjetivoemp b
          WHERE     fnempleado = pa_fnempleado
                AND fdfecha IS NULL
                AND fnsemana = VL_SEMANA
                AND fnanio =
                       TO_CHAR (TO_DATE (pa_fdfecha, 'yyyymmdd'), 'YYYY');

      pa_codigo := csl_200;
      pa_mensaje := csl_ok;
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN cur_objetivosememp FOR
            SELECT NULL id, NULL descripcion, NULL objetivo FROM DUAL;

         pa_codigo := SQLCODE;
         pa_mensaje := SQLERRM;
         SCSISGES.
          SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAOBJETIVOS.SPOBJETIVOSEMEMP');
   END SPOBJETIVOSEMEMP;

   PROCEDURE SPOBJETIVOSEMSUC (
      PA_FIIDSUCURSAL      IN     SCSISGES.TAOBJETIVOSUC.FIIDSUCURSAL%TYPE,
      PA_FDFECHA           IN     SCSISGES.TAOBJETIVOSUC.FDFECHA%TYPE,
      CUR_OBJETIVOSEMSUC      OUT SYS_REFCURSOR,
      PA_CODIGO               OUT INTEGER,
      PA_MENSAJE              OUT VARCHAR2)
   AS
      vl_semana   INTEGER;
   BEGIN
      VL_SEMANA := SCSISGES.FNOBTIENESEMANA (PA_FDFECHA);

      OPEN cur_objetivosemsuc FOR
         SELECT DISTINCT
                fnempleado AS id,
                fcnombreemp AS descripcion,
                (SELECT XMLELEMENT (
                           "OBJETIVOS",
                           XMLAGG (
                              XMLELEMENT (
                                 "LINEA",
                                 XMLFOREST (
                                    a.id_linea AS "ID_LINEA",
                                    a.desc_linea AS "DESC_LINEA",
                                    a.total_obj AS "TOTAL_OBJ",
                                    a.total_vta AS "TOTAL_VTA",
                                    a.total_falta AS "TOTAL_FALTA",
                                    a.credito_obj AS "CREDITO_OBJ",
                                    a.credito_vta AS "CREDITO_VTA",
                                    a.credito_falta AS "CREDITO_FALTA",
                                    a.contado_obj AS "CONTADO_OBJ",
                                    a.contado_vta AS "CONTADO_VTA",
                                    a.contado_falta AS "CONTADO_FALTA")))).
                         getstringval ()
                           AS "OBJETIVOS"
                   FROM (  SELECT id,
                                  id_linea,
                                  desc_linea,
                                  SUM (obj_credito) + SUM (obj_contado)
                                     total_obj,
                                  SUM (vta_credito) + SUM (vta_contado)
                                     total_vta,
                                  (SUM (obj_credito) + SUM (obj_contado))
                                  - (SUM (vta_credito) + SUM (vta_contado))
                                     total_falta,
                                  SUM (obj_credito) credito_obj,
                                  SUM (vta_credito) credito_vta,
                                  (SUM (obj_credito)) - (SUM (vta_credito))
                                     credito_falta,
                                  SUM (obj_contado) contado_obj,
                                  SUM (vta_contado) contado_vta,
                                  (SUM (obj_contado)) - (SUM (vta_contado))
                                     contado_falta
                             FROM (  SELECT fnempleado AS id,
                                            fnlinea AS id_linea,
                                            fclineadesc AS desc_linea,
                                            SUM (NVL (fnmontocredito, csl_0p00))
                                               AS obj_credito,
                                            SUM (NVL (fnmontocontado, csl_0p00))
                                               AS obj_contado,
                                            csl_0p00 AS vta_credito,
                                            csl_0p00 AS vta_contado
                                       FROM scsisges.taobjetivoemp
                                      WHERE     fdfecha IS NULL
                                            AND fiidsucursal = pa_fiidsucursal
                                            AND fnsemana = VL_SEMANA
                                            AND fnanio =
                                                   TO_CHAR (
                                                      TO_DATE (pa_fdfecha,
                                                               'yyyymmdd'),
                                                      'YYYY')
                                            AND fnsemana > csl_0
                                            AND fnanio > csl_0
                                   GROUP BY fnempleado, fnlinea, fclineadesc
                                   UNION ALL
                                     SELECT t.fnempleado AS id,
                                            t.fnlinea AS id_linea,
                                            l.fcprdlindesc AS desc_linea,
                                            csl_0p00 AS obj_credito,
                                            csl_0p00 AS obj_contado,
                                            (SELECT NVL (SUM (tt.fnmontototal),
                                                         csl_0p00)
                                               FROM    scsisges.taventasemanal tt
                                                    RIGHT JOIN
                                                       scsisges.tclinea l
                                                    ON l.fnlinea = tt.fnlinea
                                              WHERE     tt.fnlinea = t.fnlinea
                                                    AND l.fnestatus = csl_1
                                                    AND tt.fntipoventa = csl_2
                                                    AND tt.fiidsucursal =
                                                           pa_fiidsucursal
                                                    AND tt.fisemana = VL_SEMANA
                                                    AND tt.fianio =
                                                           TO_CHAR (
                                                              TO_DATE (
                                                                 pa_fdfecha,
                                                                 'yyyymmdd'),
                                                              'YYYY'))
                                               AS vta_credito,
                                            (SELECT NVL (SUM (tt.fnmontototal),
                                                         csl_0p00)
                                               FROM    scsisges.taventasemanal tt
                                                    RIGHT JOIN
                                                       scsisges.tclinea l
                                                    ON l.fnlinea = tt.fnlinea
                                              WHERE tt.fnlinea = t.fnlinea
                                                    AND tt.fntipoventa = csl_1
                                                    AND tt.fiidsucursal =
                                                           pa_fiidsucursal
                                                    AND tt.fisemana = VL_SEMANA
                                                    AND tt.fianio =
                                                           TO_CHAR (
                                                              TO_DATE (
                                                                 pa_fdfecha,
                                                                 'yyyymmdd'),
                                                              'YYYY'))
                                               AS vta_contado
                                       FROM    scsisges.taventasemanal t
                                            RIGHT JOIN
                                               scsisges.tclinea l
                                            ON t.fnlinea = l.fnlinea
                                      WHERE     l.fnlinea > csl_0
                                            AND t.fiidsucursal = pa_fiidsucursal
                                            AND t.fisemana = VL_SEMANA
                                            AND t.fianio =
                                                   TO_CHAR (
                                                      TO_DATE (pa_fdfecha,
                                                               'yyyymmdd'),
                                                      'YYYY')
                                   GROUP BY t.fnempleado,
                                            t.fnlinea,
                                            l.fcprdlindesc)
                         GROUP BY id, id_linea, desc_linea
                         ORDER BY id_linea) a
                  WHERE id = b.fnempleado)
                   AS objetivo
           FROM scsisges.taobjetivoemp b
          WHERE     fdfecha IS NULL
                AND fiidsucursal = pa_fiidsucursal
                AND fnsemana = VL_SEMANA
                AND fnanio =
                       TO_CHAR (TO_DATE (pa_fdfecha, 'yyyymmdd'), 'YYYY')
                AND fnsemana > csl_0
                AND fnanio > csl_0;

      pa_codigo := csl_200;
      pa_mensaje := csl_ok;
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN cur_objetivosemsuc FOR
            SELECT NULL id, NULL descripcion, NULL objetivo FROM DUAL;

         pa_codigo := SQLCODE;
         pa_mensaje := SQLERRM;
         SCSISGES.
          SPERRORES (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
            'SCSISGES.PAOBJETIVOS.SPOBJETIVOSEMSUC');
   END SPOBJETIVOSEMSUC;
END PAOBJETIVOSSEM;

/

  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRVENTAST";
