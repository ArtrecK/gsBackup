--------------------------------------------------------
--  DDL for Package Body PQPKLIGAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQPKLIGAS" is

PROCEDURE PAPFObtenLigas(cur_Datos OUT SYS_REFCURSOR) IS

BEGIN

OPEN cur_Datos FOR
    SELECT A.FIIDLIGA
              , A.FCDESCRIPCION
              , A.FCURL
    FROM SCSISGES.TALIGAS A
    WHERE A.FIESTATUS = csl_1 ORDER BY A.FIIDLIGA; 
END;

end PQPKLigas;

/

  GRANT EXECUTE ON "SCSISGES"."PQPKLIGAS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQPKLIGAS" TO "USRVENTAST";
