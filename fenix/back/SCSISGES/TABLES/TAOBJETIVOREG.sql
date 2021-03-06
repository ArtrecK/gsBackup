--------------------------------------------------------
--  DDL for Table TAOBJETIVOREG
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAOBJETIVOREG" 
   (	"FIIDREGION" NUMBER(6,0), 
	"FCDESCREGION" VARCHAR2(100 BYTE), 
	"FIIDZONA" NUMBER(6,0), 
	"FCDESCZONA" VARCHAR2(100 BYTE), 
	"FIIDTERRITORIO" NUMBER(6,0), 
	"FCDESCTERRITORIO" VARCHAR2(100 BYTE), 
	"FIIDPAIS" NUMBER(3,0), 
	"FDFECHA" VARCHAR2(8 BYTE), 
	"FNLINEA" NUMBER(10,0), 
	"FCLINEADESC" VARCHAR2(50 BYTE), 
	"FNSUBLINEA" NUMBER(10,0), 
	"FNCLASE" NUMBER(10,0), 
	"FNSEMANA" NUMBER(2,0), 
	"FNANIO" NUMBER(4,0), 
	"FNMONTOCREDITO" NUMBER(18,2), 
	"FNMONTOCONTADO" NUMBER(18,2), 
	"FCUSRCREACION" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDMODIFICO" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA03_DAT" ;
  GRANT DELETE ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAOBJETIVOREG" TO "USRINFSISGES";
