--------------------------------------------------------
--  DDL for Type OBJDETGES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCSISGES"."OBJDETGES" AS OBJECT
(
    FCATRIBUTODESC  VARCHAR2(4000),
    FCVALOR VARCHAR2(4000)
);

/

  GRANT EXECUTE ON "SCSISGES"."OBJDETGES" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."OBJDETGES" TO "USRSISGES";
