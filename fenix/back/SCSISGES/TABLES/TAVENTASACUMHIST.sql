--------------------------------------------------------
--  DDL for Table TAVENTASACUMHIST
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAVENTASACUMHIST" 
   (	"FNEMPLEADO" NUMBER, 
	"FCNOMBREEMP" VARCHAR2(200 BYTE), 
	"FIIDSUCURSAL" NUMBER, 
	"FNTIPOVENTA" NUMBER(1,0), 
	"FNLINEA" NUMBER, 
	"FDFECHAVENTA" DATE, 
	"FNMONTO" NUMBER(12,2), 
	"FCUSRCREACION" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDMODIFICO" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_HISTORICA01_DAT" ;
  GRANT DELETE ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAVENTASACUMHIST" TO "USRINFSISGES";
