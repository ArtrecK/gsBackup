--------------------------------------------------------
--  DDL for Package PAFXTRUNCAMAPASVT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PAFXTRUNCAMAPASVT" is

  -- Author  : CCAMPOS
  -- Created : 10/12/2018 01:04:35 p. m.
  -- Purpose : truncate la tabla para el MAPA y CARGAR DATOS DE CENCLIENTETIENDA

PROCEDURE SPTRUNCACTETIENDA;

end PAFXTRUNCAMAPASVT;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAFXTRUNCAMAPASVT" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAFXTRUNCAMAPASVT" TO "SCSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAFXTRUNCAMAPASVT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAFXTRUNCAMAPASVT" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAFXTRUNCAMAPASVT" TO "USRINFVENTAST";
