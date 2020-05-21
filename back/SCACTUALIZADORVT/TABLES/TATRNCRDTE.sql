--------------------------------------------------------
--  DDL for Table TATRNCRDTE
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TATRNCRDTE" 
   (	"ORA_ERR_ROWID" ROWID, 
	"FIPAISID" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FITRANNO" NUMBER(10,0), 
	"FICONSDETA" NUMBER(10,0), 
	"FITIPOREG" NUMBER(5,0), 
	"FCDATODETA" VARCHAR2(270 CHAR), 
	"FISTS_ERRSOL" NUMBER(2,0) DEFAULT 0, 
	"FDFECHA_ERRSOL" DATE DEFAULT TO_DATE('1901-01-01', 'YYYY-MM-DD'), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TRANDETERR_DAT" ;
  GRANT DELETE ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFACTVT";
  GRANT INSERT ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFACTVT";
  GRANT SELECT ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFACTVT";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFACTVT";
  GRANT DELETE ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFFENIX";
  GRANT INSERT ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFFENIX";
  GRANT SELECT ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFFENIX";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TATRNCRDTE" TO "USRINFFENIX";
