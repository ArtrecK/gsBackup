--------------------------------------------------------
--  DDL for Table TAEST01001_0100
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TAEST01001_0100" 
   (	"FINOPEDIDO" NUMBER(10,0), 
	"FINGCIOID" NUMBER(3,0), 
	"FINOTIENDA" NUMBER(5,0), 
	"FICTEID" NUMBER(10,0), 
	"FIDIGITOVER" NUMBER(3,0), 
	"FITIPOVENTA" NUMBER(3,0), 
	"FDPEDFEC" DATE, 
	"FIPLAZO_" NUMBER(3,0), 
	"FIPERIODO" NUMBER(3,0), 
	"FNPEDPAGOPER" NUMBER(9,2), 
	"FNPEDULTPAGO" NUMBER(9,2), 
	"FCFOLIOPARAM" NUMBER(10,0), 
	"FCEMPNO" VARCHAR2(6 CHAR), 
	"FNIMPANTICIPO" NUMBER(9,2), 
	"FDLIMVIGENCIA" DATE, 
	"FITIPOCTA" NUMBER(3,0), 
	"FIPLAZO" NUMBER(5,0), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_DATA01_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFVENTAST";
  GRANT INSERT ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFVENTAST";
  GRANT SELECT ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFVENTAST";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAEST01001_0100" TO "USRINFVENTAST";
