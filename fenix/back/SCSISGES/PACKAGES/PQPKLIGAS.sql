--------------------------------------------------------
--  DDL for Package PQPKLIGAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQPKLIGAS" 
 IS

  -- Author  : B683464
  -- Created : 29/05/2018 
  -- Purpose : Procesos de regresar ligas a otros sistemas


  csl_1   CONSTANT INTEGER := 1;

  PROCEDURE PAPFObtenLigas(cur_Datos OUT SYS_REFCURSOR);

end PQPKLigas;

/

  GRANT EXECUTE ON "SCSISGES"."PQPKLIGAS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQPKLIGAS" TO "USRVENTAST";
