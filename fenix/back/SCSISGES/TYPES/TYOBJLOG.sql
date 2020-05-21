--------------------------------------------------------
--  DDL for Type TYOBJLOG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCSISGES"."TYOBJLOG" IS OBJECT
(
    FCNOMBRE VARCHAR2 (100),
    FICODERROR INTEGER,
    FCDESCERROR VARCHAR2 (200),
    FCFECHAERROR DATE
);

/

  GRANT EXECUTE ON "SCSISGES"."TYOBJLOG" TO "USRSISGES";
