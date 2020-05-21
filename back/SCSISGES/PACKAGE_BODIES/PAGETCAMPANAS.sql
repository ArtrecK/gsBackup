--------------------------------------------------------
--  DDL for Package Body PAGETCAMPANAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAGETCAMPANAS" 
IS
   CSL_0   CONSTANT INTEGER := 0;
   CSL_1   CONSTANT INTEGER := 1;

   PROCEDURE SPCAMPANASCLTE (PA_FIPAIS           INTEGER,
                             PA_FICANAL          INTEGER,
                             PA_FISUCURSAL       INTEGER,
                             PA_FIFOLIO          INTEGER,
                             PA_CURDATOS     OUT SYS_REFCURSOR,
                             PA_MENSAJE      OUT VARCHAR2,
                             PA_CODERROR     OUT INTEGER,
                             PA_DESERROR     OUT VARCHAR2)
   IS
   BEGIN
      OPEN PA_CURDATOS FOR
         SELECT TC.FIIDCAMPANA,
                TC.FCCAMPANA        AS FCNOMBRECORTO,
                TC.FCDESCCAMPANA    AS FCDESCRIPCION
           FROM SCSISGES.TACAMPANACTE CTE, SCSISGES.TCCAMPANAMKT TC
          WHERE     CTE.FIIDCAMPANA = TC.FIIDCAMPANA
                AND CTE.FIPAIS = PA_FIPAIS
                AND CTE.FICANAL = PA_FICANAL
                AND CTE.FISUCURSAL = PA_FISUCURSAL
                AND CTE.FIFOLIO = PA_FIFOLIO
                AND TC.FIIDCAMPANA > CSL_0;

      pa_codError := CSL_1;
      PA_MENSAJE := 'CONSULTA REALIZADA CORRECTAMENTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, 0, 200);
         PA_MENSAJE := 'OCURRIO UN ERROR AL CONSULTAR CAMPANAS';

         OPEN PA_CURDATOS FOR
            SELECT NULL    AS FIIDCAMPANA,
                   NULL    AS FCNOMBRECORTO,
                   NULL    AS FCDESCRIPCION
              FROM DUAL;

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             pa_desError,
                             'PAGETCAMPANAS.SPCAMPANASCLTE');
   END SPCAMPANASCLTE;

   PROCEDURE SPCONTEOCTESCAMP (PA_FCEMPLEADO       VARCHAR2,
                               PA_FISUCURSAL       NUMBER,
                               PA_FIPAIS           NUMBER,
                               PA_CURSCAMP     OUT SYS_REFCURSOR,
                               PA_MENSAJE      OUT VARCHAR2,
                               PA_CODERROR     OUT INTEGER,
                               PA_DESERROR     OUT VARCHAR2)
   IS
   BEGIN
      OPEN PA_CURSCAMP FOR
           SELECT CTE.FIIDCAMPANA,
                  TC.FCCAMPANA    AS FCNOMBRECORTO,
                  COUNT (1)       AS CONTEOCTES
             FROM SCSISGES.TACAMPANACTE CTE, SCSISGES.TCCAMPANAMKT TC
            WHERE     CTE.FIIDCAMPANA = TC.FIIDCAMPANA
                  AND CTE.FIIDEMPLEADO = PA_FCEMPLEADO
                  AND CTE.FIIDSUCURSAL = PA_FISUCURSAL
                  AND CTE.FIIDPAIS = PA_FIPAIS
                  AND TC.FIIDCAMPANA > CSL_0
         GROUP BY CTE.FIIDCAMPANA, TC.FCCAMPANA;



      pa_codError := CSL_1;
      PA_MENSAJE := 'CONSULTA REALIZADA CORRECTAMENTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         PA_MENSAJE := 'OCURRIO UN ERROR AL REALIZAR LAS CONSULTAS';
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, 0, 200);

         OPEN PA_CURSCAMP FOR
            SELECT NULL    AS FIIDCAMPANA,
                   NULL    AS FCNOMBRECORTO,
                   NULL    AS CONTEOCTES
              FROM DUAL;

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             pa_desError,
                             'PAGETCAMPANAS.SPCONTEOCTESCAMP');
   END SPCONTEOCTESCAMP;

   PROCEDURE SPCTESCAMPANAS (PA_FCEMPLEADO       VARCHAR2,
                             PA_FISUCURSAL       NUMBER,
                             PA_CURSCAMP     OUT SYS_REFCURSOR,
                             PA_MENSAJE      OUT VARCHAR2,
                             PA_CODERROR     OUT INTEGER,
                             PA_DESERROR     OUT VARCHAR2)
   IS
   BEGIN
      OPEN PA_CURSCAMP FOR
         SELECT CTE.FIIDCAMPANA,
                TC.FCCAMPANA    AS FCNOMBRECORTO,
                TC.FCDESCCAMPANA,
                CTE.FIPAIS,
                CTE.FICANAL,
                CTE.FISUCURSAL,
                CTE.FIFOLIO
           FROM SCSISGES.TACAMPANACTE CTE, SCSISGES.TCCAMPANAMKT TC
          WHERE     CTE.FIIDCAMPANA = TC.FIIDCAMPANA
                AND CTE.FIIDEMPLEADO = PA_FCEMPLEADO
                AND CTE.FIIDSUCURSAL = PA_FISUCURSAL
                AND TC.FIIDCAMPANA > CSL_0;


      pa_codError := CSL_1;
      PA_MENSAJE := 'CONSULTA REALIZADA CORRECTAMENTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_codError := SQLCODE;
         pa_desError := SUBSTR (SQLERRM, 0, 200);
         PA_MENSAJE := 'OCURRIO UN ERROR AL CONSULTAR CTES EN CAMPANAS';

         OPEN PA_CURSCAMP FOR
            SELECT NULL    AS FIIDCAMPANA,
                   NULL    AS FCNOMBRECORTO,
                   NULL    AS FCDESCCAMPANA,
                   NULL    AS FIPAIS,
                   NULL    AS FICANAL,
                   NULL    AS FISUCURSAL,
                   NULL    AS FIFOLIO
              FROM DUAL;

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             pa_desError,
                             'PAGETCAMPANAS.SPCTESCAMPANAS');
   END SPCTESCAMPANAS;



   PROCEDURE SPCAMPANASACT (PA_CURSCAMPACT   OUT SYS_REFCURSOR,
                            PA_MENSAJE       OUT VARCHAR2,
                            PA_CODERROR      OUT INTEGER,
                            PA_DESERROR      OUT VARCHAR2)
   IS
   BEGIN
      OPEN PA_CURSCAMPACT FOR SELECT TC.FIIDCAMPANA      AS FIIDCAMPANA,
                                     TC.FCCAMPANA        AS FCNOMBRECORTO,
                                     TC.FCDESCCAMPANA    AS FCDESCRIPCION,
                                     TC.FIIDTIPO         AS FITIPO,
                                     TC.FIIDNEGOCIO      AS FINEGOCIO,
                                     TC.FIIDPAIS         AS FIPAIS
                                FROM SCSISGES.TCCAMPANAMKT TC
                               WHERE TC.FIIDCAMPANA >= CSL_0;

      PA_CODERROR := CSL_1;
      PA_MENSAJE := 'CONSULTA REALIZADA CORRECTAMENTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         PA_MENSAJE := 'OCURRIO UN ERROR AL REALIZAR LAS CONSULTAS';
         PA_CODERROR := SQLCODE;
         PA_DESERROR := SUBSTR (SQLERRM, 0, 200);

         OPEN PA_CURSCAMPACT FOR
            SELECT NULL    AS FIIDCAMPANA,
                   NULL    AS FCNOMBRECORTO,
                   NULL    AS CONTEOCTES
              FROM DUAL;

         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             PA_DESERROR,
                             'PAGETCAMPANAS.SPCAMPANASACT');
   END SPCAMPANASACT;
END PAGETCAMPANAS;

/

  GRANT EXECUTE ON "SCSISGES"."PAGETCAMPANAS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGETCAMPANAS" TO "USRSISGES";
