--------------------------------------------------------
--  DDL for Table TADATOSMAIL
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TADATOSMAIL" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FIFOLIO" NUMBER(10,0), 
	"FCMAIL" VARCHAR2(50 BYTE), 
	"FCESTATUS" NUMBER(1,0), 
	"FCUSRMODIFICO" VARCHAR2(50 BYTE) DEFAULT user, 
	"FDULTMODIFICA" DATE DEFAULT sysdate
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA01_DAT" ;
  GRANT DELETE ON "SCSISGES"."TADATOSMAIL" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TADATOSMAIL" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TADATOSMAIL" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TADATOSMAIL" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TADATOSMAIL" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TADATOSMAIL" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TADATOSMAIL" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TADATOSMAIL" TO "USRINFSISGES";
