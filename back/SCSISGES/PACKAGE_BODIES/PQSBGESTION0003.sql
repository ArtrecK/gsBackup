--------------------------------------------------------
--  DDL for Package Body PQSBGESTION0003
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQSBGESTION0003" 
IS
   csl_0   CONSTANT INTEGER := 0;
   csl_1   CONSTANT INTEGER := 1;
   csl_2   CONSTANT INTEGER := 2;
   csl_3   CONSTANT INTEGER := 3;
   csl_4   CONSTANT INTEGER := 4;
   csl_5   CONSTANT INTEGER := 5;
   csl_6   CONSTANT INTEGER := 6;
   csl_7   CONSTANT INTEGER := 7;

   PROCEDURE SPLISTGSTCU (pa_tb_cus      IN     SCSISGES.TYTBGSTCU,
                          pa_curGstCUs      OUT SYS_REFCURSOR,
                          pa_codmsg         OUT INTEGER,
                          pa_msg            OUT VARCHAR2,
                          pa_msgerror       OUT VARCHAR2)
   IS

   BEGIN
     OPEN pa_curGstCUs FOR
      SELECT TT.FICAMPO5 AS ORDERID,
			 TT.FIPAIS,
             TT.FICANAL,
             TT.FISUCURSAL,
             TT.FIFOLIO,
             TT.FICAMPO1 AS FIIDRESGEST,
             TT.FICAMPO3 AS FISTATGEST,
             TT.FDFECHA1 AS FDFECGEST,
             TT.FCCAMPO1 AS FCDESCGEST
      FROM TABLE(SCSISGES.FNFXGETCTESGEST(CSL_1,pa_tb_cus))TT
      order by CASE
            WHEN FISTATGEST  = csl_0 then csl_1
            WHEN FIIDRESGEST = csl_1 then csl_2
			WHEN FIIDRESGEST = csl_3 then csl_3
			WHEN FIIDRESGEST = csl_6 then csl_4
			WHEN FIIDRESGEST = csl_4 then csl_5
			WHEN FIIDRESGEST = csl_2 then csl_6
			WHEN FIIDRESGEST = csl_5 then csl_7 END;


   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN pa_curGstCUs FOR
            SELECT NULL ORDERID,
				   NULL FIPAIS,
                   NULL FICANAL,
                   NULL FISUCURSAL,
                   NULL FIFOLIO,
                   NULL FISTATGEST,
                   NULL FIIDRESGEST,
                   NULL FCDESCGEST,
                   NULL FDFECGEST
              FROM DUAL;

         pa_codmsg := SQLCODE;
         pa_msg := SQLERRM; -- 'Error al consultar ultima gestion'
         pa_msgerror := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
   END SPLISTGSTCU;
END pqsbgestion0003;

/

  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRACTVT";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRVENTAST";
