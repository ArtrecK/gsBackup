--------------------------------------------------------
--  DDL for Type TYOBPRODUCTO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCSISGES"."TYOBPRODUCTO" AS OBJECT(
        FISKU INTEGER
       ,FCDESPRODUCTO VARCHAR2(100)
)

/

  GRANT EXECUTE ON "SCSISGES"."TYOBPRODUCTO" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."TYOBPRODUCTO" TO "USRSISGES";
