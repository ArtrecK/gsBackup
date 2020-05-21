--------------------------------------------------------
--  DDL for Package PAESTRUCTURA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAESTRUCTURA" 
AS
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
      pa_mensajeerror        OUT VARCHAR2);

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
      pa_mensajeerror        OUT VARCHAR2);

   PROCEDURE spdestructura (
      pa_fiest_pais       IN     scactualizadorvt.tacatestructura.fiest_pais%TYPE,
      pa_fiest_canal      IN     scactualizadorvt.tacatestructura.fiest_canal%TYPE,
      pa_fiest_tipo_reg   IN     scactualizadorvt.tacatestructura.
                                  fiest_tipo_reg%TYPE,
      pa_codigo              OUT INTEGER,
      pa_mensaje             OUT VARCHAR2,
      pa_mensajeerror        OUT VARCHAR2);

   PROCEDURE spsestructura (
      pa_fiest_pais       IN     scactualizadorvt.tacatestructura.fiest_pais%TYPE,
      pa_fiest_canal      IN     scactualizadorvt.tacatestructura.fiest_canal%TYPE,
      pa_fiest_tipo_reg   IN     scactualizadorvt.tacatestructura.
                                  fiest_tipo_reg%TYPE,
      pa_estructuras         OUT scactualizadorvt.patypes.rcgcursor,
      pa_codigo              OUT INTEGER,
      pa_mensaje             OUT VARCHAR2,
      pa_mensajeerror        OUT VARCHAR2);

   PROCEDURE spsestructuracat (
      pa_tipos          OUT scactualizadorvt.patypes.rcgcursor,
      pa_pais           OUT scactualizadorvt.patypes.rcgcursor,
      pa_canal          OUT scactualizadorvt.patypes.rcgcursor,
      pa_codigo         OUT INTEGER,
      pa_mensaje        OUT VARCHAR2,
      pa_mensajeerror   OUT VARCHAR2);
END PAESTRUCTURA;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAESTRUCTURA" TO "USRACTVT";
