--------------------------------------------------------
--  DDL for Package Body PAESTRUCTURA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCACTUALIZADORVT"."PAESTRUCTURA" 
AS
   csl_sysdate      DATE := SYSDATE;
   csl_user         VARCHAR2 (100) := USER;
   csl_0   CONSTANT PLS_INTEGER := 0;
   csl_1   CONSTANT PLS_INTEGER := 1;

   PROCEDURE spiestructura (
      pa_fcest_nombre     IN     scactualizadorvt.tacatestructura.fcest_nombre%TYPE,
      pa_fcest_owner      IN     scactualizadorvt.tacatestructura.fcest_owner%TYPE,
      pa_fcsp_name        IN     scactualizadorvt.tacatestructura.fcsp_name%TYPE,
      pa_fiest_length     IN     scactualizadorvt.tacatestructura.fiest_length%TYPE,
      pa_fiest_pais       IN     scactualizadorvt.tacatestructura.fiest_pais%TYPE,
      pa_fiest_canal      IN     scactualizadorvt.tacatestructura.fiest_canal%TYPE,
      pa_fiest_tipo_reg   IN     scactualizadorvt.tacatestructura.
                                  fiest_tipo_reg%TYPE,
      pa_fcest_tipo_est   IN     scactualizadorvt.tacatestructura.
                                  fcest_tipo_est%TYPE,
      pa_farrestruc_tb    IN     scactualizadorvt.TB_STRUC_TAEST,
      pa_codigo              OUT INTEGER,
      pa_mensaje             OUT VARCHAR2,
      pa_mensajeerror        OUT VARCHAR2)
   AS
      pa_farrestruc_array   scactualizadorvt.ARR_ESTRUCTURA_TAEST;
   BEGIN
      pa_farrestruc_array := NEW scactualizadorvt.ARR_ESTRUCTURA_TAEST ();

      IF pa_farrestruc_tb IS NOT NULL
      THEN
         FOR i IN csl_1 .. pa_farrestruc_tb.COUNT
         LOOP
            pa_farrestruc_array.EXTEND;
            pa_farrestruc_array (pa_farrestruc_array.LAST) :=
               NEW scactualizadorvt.
                    TYP_ESTRUCTURA_TAEST (
                      pa_farrestruc_tb (i).column_name,
                      pa_farrestruc_tb (i).data_type,
                      pa_farrestruc_tb (i).data_length,
                      pa_farrestruc_tb (i).data_precision);
         END LOOP;

         INSERT INTO scactualizadorvt.tacatestructura (fcest_nombre,
                                                       fcest_owner,
                                                       fcsp_name,
                                                       fiest_length,
                                                       fiest_pais,
                                                       fiest_canal,
                                                       fiest_tipo_reg,
                                                       fcest_tipo_est,
                                                       farrestruc_array)
              VALUES (pa_fcest_nombre,
                      pa_fcest_owner,
                      pa_fcsp_name,
                      pa_fiest_length,
                      pa_fiest_pais,
                      pa_fiest_canal,
                      pa_fiest_tipo_reg,
                      pa_fcest_tipo_est,
                      pa_farrestruc_array);

         COMMIT;
      END IF;

      pa_codigo := 0;
      pa_mensaje := 'OK';
      pa_mensajeerror := NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codigo := 1;
         pa_mensaje := 'Ocurrio un problema al guardar estructura';
         pa_mensajeerror := DBMS_UTILITY.format_error_backtrace ();
   END;

   PROCEDURE spuestructura (
      pa_fcest_nombre     IN     scactualizadorvt.tacatestructura.fcest_nombre%TYPE,
      pa_fcest_owner      IN     scactualizadorvt.tacatestructura.fcest_owner%TYPE,
      pa_fcsp_name        IN     scactualizadorvt.tacatestructura.fcsp_name%TYPE,
      pa_fiest_length     IN     scactualizadorvt.tacatestructura.fiest_length%TYPE,
      pa_fiest_pais       IN     scactualizadorvt.tacatestructura.fiest_pais%TYPE,
      pa_fiest_canal      IN     scactualizadorvt.tacatestructura.fiest_canal%TYPE,
      pa_fiest_tipo_reg   IN     scactualizadorvt.tacatestructura.
                                  fiest_tipo_reg%TYPE,
      pa_fcest_tipo_est   IN     scactualizadorvt.tacatestructura.
                                  fcest_tipo_est%TYPE,
      pa_farrestruc_tb    IN     scactualizadorvt.TB_STRUC_TAEST,
      pa_codigo              OUT INTEGER,
      pa_mensaje             OUT VARCHAR2,
      pa_mensajeerror        OUT VARCHAR2)
   AS
      pa_farrestruc_array   scactualizadorvt.ARR_ESTRUCTURA_TAEST;
   BEGIN
      pa_farrestruc_array := NEW scactualizadorvt.ARR_ESTRUCTURA_TAEST ();

      IF pa_farrestruc_tb IS NOT NULL
      THEN
         FOR i IN csl_1 .. pa_farrestruc_tb.COUNT
         LOOP
            pa_farrestruc_array.EXTEND;
            pa_farrestruc_array (pa_farrestruc_array.LAST) :=
               NEW scactualizadorvt.
                    TYP_ESTRUCTURA_TAEST (
                      pa_farrestruc_tb (i).column_name,
                      pa_farrestruc_tb (i).data_type,
                      pa_farrestruc_tb (i).data_length,
                      pa_farrestruc_tb (i).data_precision);
         END LOOP;

         UPDATE scactualizadorvt.tacatestructura
            SET fcest_nombre = pa_fcest_nombre,
                fcest_owner = pa_fcest_owner,
                fcsp_name = pa_fcsp_name,
                fiest_length = pa_fiest_length,
                fcest_tipo_est = pa_fcest_tipo_est,
                farrestruc_array = pa_farrestruc_array
          WHERE     fiest_pais = pa_fiest_pais
                AND fiest_canal = pa_fiest_canal
                AND fiest_tipo_reg = pa_fiest_tipo_reg;

         COMMIT;
      END IF;

      pa_codigo := 0;
      pa_mensaje := 'OK';
      pa_mensajeerror := NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codigo := 1;
         pa_mensaje := 'Ocurrio un problema al actualizar estructura';
         pa_mensajeerror := DBMS_UTILITY.format_error_backtrace ();
   END;

   PROCEDURE spdestructura (
      pa_fiest_pais       IN     scactualizadorvt.tacatestructura.fiest_pais%TYPE,
      pa_fiest_canal      IN     scactualizadorvt.tacatestructura.fiest_canal%TYPE,
      pa_fiest_tipo_reg   IN     scactualizadorvt.tacatestructura.
                                  fiest_tipo_reg%TYPE,
      pa_codigo              OUT INTEGER,
      pa_mensaje             OUT VARCHAR2,
      pa_mensajeerror        OUT VARCHAR2)
   AS
   BEGIN
      DELETE FROM scactualizadorvt.tacatestructura
            WHERE     fiest_pais = pa_fiest_pais
                  AND fiest_canal = pa_fiest_canal
                  AND fiest_tipo_reg = pa_fiest_tipo_reg;

      COMMIT;
      pa_codigo := 0;
      pa_mensaje := 'OK';
      pa_mensajeerror := NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codigo := 1;
         pa_mensaje := 'Ocurrio un problema al eliminar estructura';
         pa_mensajeerror := DBMS_UTILITY.format_error_backtrace ();
   END;

   PROCEDURE spsestructura (
      pa_fiest_pais       IN     scactualizadorvt.tacatestructura.fiest_pais%TYPE,
      pa_fiest_canal      IN     scactualizadorvt.tacatestructura.fiest_canal%TYPE,
      pa_fiest_tipo_reg   IN     scactualizadorvt.tacatestructura.
                                  fiest_tipo_reg%TYPE,
      pa_estructuras         OUT scactualizadorvt.patypes.rcgcursor,
      pa_codigo              OUT INTEGER,
      pa_mensaje             OUT VARCHAR2,
      pa_mensajeerror        OUT VARCHAR2)
   AS
      vl_pais_ini    scactualizadorvt.tacatestructura.fiest_pais%TYPE;
      vl_pais_fin    scactualizadorvt.tacatestructura.fiest_pais%TYPE;
      vl_canal_ini   scactualizadorvt.tacatestructura.fiest_canal%TYPE;
      vl_canal_fin   scactualizadorvt.tacatestructura.fiest_canal%TYPE;
      vl_tipo_ini    scactualizadorvt.tacatestructura.fiest_tipo_reg%TYPE;
      vl_tipo_fin    scactualizadorvt.tacatestructura.fiest_tipo_reg%TYPE;
   BEGIN
      IF pa_fiest_pais IS NULL
      THEN
         vl_pais_ini := 0;
         vl_pais_fin := 99999;
      ELSE
         vl_pais_ini := pa_fiest_pais;
         vl_pais_fin := pa_fiest_pais;
      END IF;

      IF pa_fiest_canal IS NULL
      THEN
         vl_canal_ini := 0;
         vl_canal_fin := 99999;
      ELSE
         vl_canal_ini := pa_fiest_canal;
         vl_canal_fin := pa_fiest_canal;
      END IF;

      IF pa_fiest_tipo_reg IS NULL
      THEN
         vl_tipo_ini := 0;
         vl_tipo_fin := 99999;
      ELSE
         vl_tipo_ini := pa_fiest_tipo_reg;
         vl_tipo_fin := pa_fiest_tipo_reg;
      END IF;

      OPEN pa_estructuras FOR
         SELECT fcest_nombre,
                fcest_owner,
                fcsp_name,
                fiest_length,
                fiest_pais,
                fiest_canal,
                fiest_tipo_reg,
                fcest_tipo_est,
                farrestruc_array,
                TO_CHAR (fdcreacion, 'DD/MM/YYYY HH24:MI:SS') fdcreacion,
                TO_CHAR (fdmodifico, 'DD/MM/YYYY HH24:MI:SS') fdmodifico,
                fcusrmodifico
           FROM scactualizadorvt.tacatestructura
          WHERE     fiest_pais BETWEEN vl_pais_ini AND vl_pais_fin
                AND fiest_canal BETWEEN vl_canal_ini AND vl_canal_fin
                AND fiest_tipo_reg BETWEEN vl_tipo_ini AND vl_tipo_fin;

      pa_codigo := 0;
      pa_mensaje := 'OK';
      pa_mensajeerror := NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN pa_estructuras FOR
            SELECT NULL fcest_nombre,
                   NULL fcest_owner,
                   NULL fcsp_name,
                   NULL fiest_length,
                   NULL fiest_pais,
                   NULL fiest_canal,
                   NULL fiest_tipo_reg,
                   NULL fcest_tipo_est,
                   NULL farrestruc_array,
                   NULL fdcreacion,
                   NULL fdmodifico,
                   NULL fcusrmodifico
              FROM DUAL;

         pa_codigo := 1;
         pa_mensaje := 'Ocurrio un problema al consultar estructura';
         pa_mensajeerror := DBMS_UTILITY.format_error_backtrace ();
   END;

   PROCEDURE spsestructuracat (
      pa_tipos          OUT scactualizadorvt.patypes.rcgcursor,
      pa_pais           OUT scactualizadorvt.patypes.rcgcursor,
      pa_canal          OUT scactualizadorvt.patypes.rcgcursor,
      pa_codigo         OUT INTEGER,
      pa_mensaje        OUT VARCHAR2,
      pa_mensajeerror   OUT VARCHAR2)
   AS
   BEGIN
      OPEN pa_tipos FOR
         SELECT DISTINCT fiest_tipo_reg
           FROM scactualizadorvt.tacatestructura
          WHERE     fiest_tipo_reg > csl_0
                AND fiest_pais > csl_0
                AND fiest_canal > csl_0;

      OPEN pa_pais FOR
         SELECT DISTINCT fiest_pais
           FROM scactualizadorvt.tacatestructura
          WHERE     fiest_tipo_reg > csl_0
                AND fiest_pais > csl_0
                AND fiest_canal > csl_0;

      OPEN pa_canal FOR
         SELECT DISTINCT fiest_canal
           FROM scactualizadorvt.tacatestructura
          WHERE     fiest_tipo_reg > csl_0
                AND fiest_pais > csl_0
                AND fiest_canal > csl_0;

      pa_codigo := 0;
      pa_mensaje := 'OK';
      pa_mensajeerror := NULL;
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN pa_tipos FOR SELECT NULL fiest_tipo_reg FROM DUAL;

         OPEN pa_pais FOR SELECT NULL fiest_pais FROM DUAL;

         OPEN pa_canal FOR SELECT NULL fiest_canal FROM DUAL;

         pa_codigo := 1;
         pa_mensaje := 'Ocurrio un problema al realizar la consulta';
         pa_mensajeerror := DBMS_UTILITY.format_error_backtrace ();
   END;
END PAESTRUCTURA;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAESTRUCTURA" TO "USRACTVT";
