--------------------------------------------------------
--  DDL for Table TCPRODUCTO_TMP
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCPRODUCTO_TMP" 
   (	"FNSKU" NUMBER, 
	"FCDESCSKU" VARCHAR2(100 BYTE), 
	"FNLINEASAP" NUMBER, 
	"FCDESCLINEASAP" VARCHAR2(100 BYTE), 
	"FNSUBLINEASAP" NUMBER, 
	"FCDESCSUBLINEASAP" VARCHAR2(100 BYTE), 
	"FNLINEASIE" NUMBER, 
	"FCDESCLINEASIE" VARCHAR2(100 BYTE), 
	"FNSUBLINEASIE" NUMBER, 
	"FCDESCSUBLINEASIE" VARCHAR2(100 BYTE), 
	"PRECIOACTUAL" NUMBER(10,2), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT user
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO3_DAT" ;
  GRANT DELETE ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TCPRODUCTO_TMP" TO "USRINFSISGES";
