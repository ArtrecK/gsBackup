--------------------------------------------------------
--  DDL for Type TYOBJCALENDARIO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCSISGES"."TYOBJCALENDARIO" IS OBJECT
(
    FIANIO NUMBER (5),
    FISEMANA NUMBER (2),
    FCFECHA VARCHAR2 (15)
);

/

  GRANT EXECUTE ON "SCSISGES"."TYOBJCALENDARIO" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."TYOBJCALENDARIO" TO "USRINFSISGES";
