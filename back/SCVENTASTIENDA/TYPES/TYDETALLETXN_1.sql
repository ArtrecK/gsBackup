--------------------------------------------------------
--  DDL for Type TYDETALLETXN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYDETALLETXN" AS OBJECT
                  (FICONSDETA NUMBER,
                   FITIPOREG NUMBER,
                   FCDATODETA VARCHAR2 (4000));

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYDETALLETXN" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYDETALLETXN" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYDETALLETXN" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYDETALLETXN" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYDETALLETXN" TO "USRINFSISGES";
