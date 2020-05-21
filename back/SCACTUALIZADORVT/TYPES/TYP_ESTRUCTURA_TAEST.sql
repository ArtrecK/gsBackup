--------------------------------------------------------
--  DDL for Type TYP_ESTRUCTURA_TAEST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCACTUALIZADORVT"."TYP_ESTRUCTURA_TAEST" AS OBJECT
  (
  column_name      VARCHAR2(30 CHAR),
  data_type        VARCHAR2(30 CHAR),
  data_length      NUMBER(4),
  data_precision   NUMBER(4));

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."TYP_ESTRUCTURA_TAEST" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."TYP_ESTRUCTURA_TAEST" TO "USRINFFENIX";
