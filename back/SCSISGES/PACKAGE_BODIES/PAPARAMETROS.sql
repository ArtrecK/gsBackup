--------------------------------------------------------
--  DDL for Package Body PAPARAMETROS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAPARAMETROS" 
AS
   csl_200   INTEGER := 200;

   PROCEDURE spConsultaParam (pa_modulo        IN     VARCHAR2,
                              cur_parametros      OUT SYS_REFCURSOR,
                              pa_code             OUT INTEGER,
                              pa_message          OUT VARCHAR2)
   AS
   BEGIN
      OPEN cur_parametros FOR
         SELECT fcvalor AS valor
           FROM SCSISGES.taparametros
          WHERE fcdescripcion = pa_modulo;

      pa_code := csl_200;
      pa_message := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_code := SQLCODE;
         pa_message := SQLERRM;
   END spConsultaParam;
END PAPARAMETROS;

/

  GRANT EXECUTE ON "SCSISGES"."PAPARAMETROS" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAPARAMETROS" TO "USRSISGES";
