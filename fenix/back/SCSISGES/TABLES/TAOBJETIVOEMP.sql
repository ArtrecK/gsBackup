--------------------------------------------------------
--  DDL for Table TAOBJETIVOEMP
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAOBJETIVOEMP" 
   (	"FNEMPLEADO" NUMBER, 
	"FCNOMBREEMP" VARCHAR2(100 BYTE), 
	"FIIDSUCURSAL" NUMBER(5,0), 
	"FCNOMBRESUC" VARCHAR2(100 BYTE), 
	"FIIDREGION" NUMBER(6,0), 
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
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETIVO_RP01_DAT" 
  PARTITION BY RANGE ("FIIDSUCURSAL") 
 (PARTITION "OBJETIVOEMP_01"  VALUES LESS THAN (2000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETIVO_RP01_DAT" , 
 PARTITION "OBJETIVOEMP_02"  VALUES LESS THAN (4000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETIVO_RP02_DAT" , 
 PARTITION "OBJETIVOEMP_03"  VALUES LESS THAN (6000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETIVO_RP03_DAT" , 
 PARTITION "OBJETIVOEMP_04"  VALUES LESS THAN (8000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETIVO_RP04_DAT" , 
 PARTITION "OBJETIVOEMP_05"  VALUES LESS THAN (MAXVALUE) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETIVO_RP05_DAT" ) ;
  GRANT DELETE ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAOBJETIVOEMP" TO "USRINFSISGES";
