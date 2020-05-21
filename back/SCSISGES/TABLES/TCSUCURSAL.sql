--------------------------------------------------------
--  DDL for Table TCSUCURSAL
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCSUCURSAL" 
   (	"FIDSUCURSAL" VARCHAR2(8 BYTE), 
	"FCNOMBRESUCURSAL" VARCHAR2(100 BYTE), 
	"FNIVA" NUMBER(10,2), 
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
  GRANT DELETE ON "SCSISGES"."TCSUCURSAL" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCSUCURSAL" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCSUCURSAL" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCSUCURSAL" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TCSUCURSAL" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TCSUCURSAL" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TCSUCURSAL" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TCSUCURSAL" TO "USRINFSISGES";
