--------------------------------------------------------
--  DDL for Table TAEST01001_0215
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TAEST01001_0215" 
   (	"FINOPEDIDO" NUMBER(10,0), 
	"FIMCID" NUMBER(5,0), 
	"FINGCIOID" NUMBER(3,0), 
	"FDFECCANPED" DATE, 
	"FISTATCANC" NUMBER(3,0), 
	"FCCANOBSERV" VARCHAR2(65 CHAR), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_DATA02_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFVENTAST";
  GRANT INSERT ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFVENTAST";
  GRANT SELECT ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFVENTAST";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAEST01001_0215" TO "USRINFVENTAST";
