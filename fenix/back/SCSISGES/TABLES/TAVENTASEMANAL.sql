--------------------------------------------------------
--  DDL for Table TAVENTASEMANAL
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAVENTASEMANAL" 
   (	"FNEMPLEADO" NUMBER, 
	"FCNOMBREEMP" VARCHAR2(100 BYTE), 
	"FIIDSUCURSAL" NUMBER(6,0), 
	"FCNOMBRESUC" VARCHAR2(100 BYTE), 
	"FINUMCECOSUC" NUMBER(8,0), 
	"FIIDPAIS" NUMBER(3,0), 
	"FCPAIS" VARCHAR2(15 BYTE), 
	"FICANAL" NUMBER(3,0), 
	"FCCANAL" VARCHAR2(30 BYTE), 
	"FIIDREGION" NUMBER(6,0), 
	"FCDESCREGION" VARCHAR2(100 BYTE), 
	"FIIDZONA" NUMBER(6,0), 
	"FCDESCZONAS" VARCHAR2(100 BYTE), 
	"FIIDTERRITORIO" NUMBER(6,0), 
	"FCDESCTERRITORIO" VARCHAR2(100 BYTE), 
	"FNTIPOVENTA" NUMBER(2,0), 
	"FNLINEA" NUMBER(10,0), 
	"FNMONTOTOTAL" NUMBER(15,2), 
	"FISEMANA" NUMBER(2,0), 
	"FIANIO" NUMBER(4,0), 
	"FCUSRCREACION" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDMODIFICO" DATE DEFAULT SYSDATE
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAVDVTSMNL_RP01_DAT" 
  PARTITION BY RANGE ("FIIDSUCURSAL") 
 (PARTITION "VENTA_SUC_P1"  VALUES LESS THAN (2000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAVDVTSMNL_RP01_DAT" , 
 PARTITION "VENTA_SUC_P2"  VALUES LESS THAN (4000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAVDVTSMNL_RP02_DAT" , 
 PARTITION "VENTA_SUC_P3"  VALUES LESS THAN (6000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAVDVTSMNL_RP03_DAT" , 
 PARTITION "VENTA_SUC_P4"  VALUES LESS THAN (8000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAVDVTSMNL_RP04_DAT" , 
 PARTITION "VENTA_SUC_P5"  VALUES LESS THAN (10000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAVDVTSMNL_RP05_DAT" ) ;
  GRANT DELETE ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAVENTASEMANAL" TO "USRINFSISGES";
