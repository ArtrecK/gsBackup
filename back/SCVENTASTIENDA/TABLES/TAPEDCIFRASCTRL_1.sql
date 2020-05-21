--------------------------------------------------------
--  DDL for Table TAPEDCIFRASCTRL
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TAPEDCIFRASCTRL" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FITRANNO" NUMBER(10,0), 
	"FINOPEDIDO" NUMBER(10,0), 
	"FITIR" NUMBER(5,0), 
	"FDFECSURT" DATE, 
	"FNPRCBNFPGPNTL" NUMBER(13,6), 
	"FNTSGLBNORMALANULSNIVA" NUMBER(13,6), 
	"FNTSGLBPUNTUALANULSNIVA" NUMBER(13,6), 
	"FNIVA" NUMBER(13,6), 
	"FDCREACION" DATE, 
	"FDMODIFICO" DATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_DATA03_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRSENDER";
  GRANT INSERT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRSENDER";
  GRANT SELECT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRSENDER";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRSENDER";
  GRANT DELETE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "SCACTUALIZADORVT";
  GRANT INSERT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "SCACTUALIZADORVT";
  GRANT SELECT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "SCACTUALIZADORVT";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "SCACTUALIZADORVT";
  GRANT DELETE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFSISGES";
  GRANT INSERT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFSISGES";
  GRANT SELECT ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFSISGES";
  GRANT UPDATE ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" TO "USRINFSISGES";
