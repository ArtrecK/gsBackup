--------------------------------------------------------
--  DDL for Table TATRNCRDTH
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TATRNCRDTH" 
   (	"FIPAISID" NUMBER(5,0) DEFAULT 1, 
	"FICANAL" NUMBER(5,0) DEFAULT 1, 
	"FISUCURSAL" NUMBER(10,0), 
	"FITRANNO" NUMBER(10,0), 
	"FICONSDETA" NUMBER(10,0), 
	"FITIPOREG" NUMBER(5,0), 
	"FCDATODETA" VARCHAR2(270 CHAR), 
	"FDFECHAFINPROCESO" DATE, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP01_DAT" 
  PARTITION BY RANGE ("FISUCURSAL") 
 (PARTITION "PTATRANCREDETHIST1"  VALUES LESS THAN (218) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP01_DAT" , 
 PARTITION "PTATRANCREDETHIST2"  VALUES LESS THAN (596) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP02_DAT" , 
 PARTITION "PTATRANCREDETHIST3"  VALUES LESS THAN (988) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP03_DAT" , 
 PARTITION "PTATRANCREDETHIST4"  VALUES LESS THAN (1388) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP04_DAT" , 
 PARTITION "PTATRANCREDETHIST5"  VALUES LESS THAN (1714) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP05_DAT" , 
 PARTITION "PTATRANCREDETHIST6"  VALUES LESS THAN (2049) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP06_DAT" , 
 PARTITION "PTATRANCREDETHIST7"  VALUES LESS THAN (2190) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP07_DAT" , 
 PARTITION "PTATRANCREDETHIST8"  VALUES LESS THAN (2533) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP08_DAT" , 
 PARTITION "PTATRANCREDETHIST9"  VALUES LESS THAN (3061) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP09_DAT" , 
 PARTITION "PTATRANCREDETHIST10"  VALUES LESS THAN (3422) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP10_DAT" , 
 PARTITION "PTATRANCREDETHIST11"  VALUES LESS THAN (3885) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP11_DAT" , 
 PARTITION "PTATRANCREDETHIST12"  VALUES LESS THAN (4609) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP12_DAT" , 
 PARTITION "PTATRANCREDETHIST13"  VALUES LESS THAN (5117) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP13_DAT" , 
 PARTITION "PTATRANCREDETHIST14"  VALUES LESS THAN (5695) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP14_DAT" , 
 PARTITION "PTATRANCREDETHIST15"  VALUES LESS THAN (6212) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP15_DAT" , 
 PARTITION "PTATRANCREDETHIST16"  VALUES LESS THAN (6937) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP16_DAT" , 
 PARTITION "PTATRANCREDETHIST17"  VALUES LESS THAN (7444) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP17_DAT" , 
 PARTITION "PTATRANCREDETHIST18"  VALUES LESS THAN (8337) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP18_DAT" , 
 PARTITION "PTATRANCREDETHIST19"  VALUES LESS THAN (8964) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP19_DAT" , 
 PARTITION "PTATRANCREDETHIST20"  VALUES LESS THAN (10000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRANDETH_RP20_DAT" ) ;
  GRANT DELETE ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFACTVT";
  GRANT INSERT ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFACTVT";
  GRANT SELECT ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFACTVT";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFACTVT";
  GRANT DELETE ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFFENIX";
  GRANT INSERT ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFFENIX";
  GRANT SELECT ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFFENIX";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TATRNCRDTH" TO "USRINFFENIX";
