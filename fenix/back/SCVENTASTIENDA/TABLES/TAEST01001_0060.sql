--------------------------------------------------------
--  DDL for Table TAEST01001_0060
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TAEST01001_0060" 
   (	"FCFOLIOPARAM" NUMBER(10,0), 
	"FIPRODID" NUMBER(10,0), 
	"FNPRODPRECIOD" NUMBER(9,2), 
	"FICANT" NUMBER(10,0), 
	"FNDESCTO" NUMBER(7,2), 
	"FNDESCTOESP" NUMBER(7,2), 
	"FNSOBREPRECIO" NUMBER(11,4), 
	"FIPORCIVA" NUMBER(6,2), 
	"FNDESCTOMKT" NUMBER(9,2), 
	"FNCOSTOPDCTO" NUMBER(9,2), 
	"FISTATDP" NUMBER(3,0), 
	"FNINTERESES" NUMBER(8,2), 
	"FNENGANCHE" NUMBER(8,2), 
	"FICVEPROM" NUMBER(10,0), 
	"FNCOMISIONV" NUMBER(9,2), 
	"FNCOMISIONG" NUMBER(9,2), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_DATA01_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFVENTAST";
  GRANT INSERT ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFVENTAST";
  GRANT SELECT ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFVENTAST";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAEST01001_0060" TO "USRINFVENTAST";
