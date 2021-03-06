--------------------------------------------------------
--  DDL for Table TACTRLSUC
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TACTRLSUC" 
   (	"FIPAISID" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FISTATADN" NUMBER(2,0) DEFAULT 1, 
	"FISTATUSTDA" NUMBER(5,0) DEFAULT 1, 
	"FIULTTRANS" NUMBER(10,0), 
	"FDULTTRANS" DATE, 
	"FDULTACTCEN" DATE, 
	"FCTIPOERR" VARCHAR2(1 CHAR), 
	"FCDESCERR" VARCHAR2(100 CHAR), 
	"ORA_ERR_ROWID" ROWID, 
	"FITRANNO" NUMBER(10,0), 
	"FISTSCBAN" NUMBER(2,0), 
	"FDFECCBAN" DATE, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP01_DAT" 
  PARTITION BY RANGE ("FISUCURSAL") 
 (PARTITION "PTACTRLSUC1"  VALUES LESS THAN (218) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP01_DAT" , 
 PARTITION "PTACTRLSUC2"  VALUES LESS THAN (596) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP02_DAT" , 
 PARTITION "PTACTRLSUC3"  VALUES LESS THAN (988) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP03_DAT" , 
 PARTITION "PTACTRLSUC4"  VALUES LESS THAN (1388) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP04_DAT" , 
 PARTITION "PTACTRLSUC5"  VALUES LESS THAN (1714) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP05_DAT" , 
 PARTITION "PTACTRLSUC6"  VALUES LESS THAN (2049) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP06_DAT" , 
 PARTITION "PTACTRLSUC7"  VALUES LESS THAN (2190) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP07_DAT" , 
 PARTITION "PTACTRLSUC8"  VALUES LESS THAN (2533) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP08_DAT" , 
 PARTITION "PTACTRLSUC9"  VALUES LESS THAN (3061) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP09_DAT" , 
 PARTITION "PTACTRLSUC10"  VALUES LESS THAN (3422) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP10_DAT" , 
 PARTITION "PTACTRLSUC11"  VALUES LESS THAN (3885) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP11_DAT" , 
 PARTITION "PTACTRLSUC12"  VALUES LESS THAN (4609) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP12_DAT" , 
 PARTITION "PTACTRLSUC13"  VALUES LESS THAN (5117) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP13_DAT" , 
 PARTITION "PTACTRLSUC14"  VALUES LESS THAN (5695) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP14_DAT" , 
 PARTITION "PTACTRLSUC15"  VALUES LESS THAN (6212) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP15_DAT" , 
 PARTITION "PTACTRLSUC16"  VALUES LESS THAN (6937) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP16_DAT" , 
 PARTITION "PTACTRLSUC17"  VALUES LESS THAN (7444) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP17_DAT" , 
 PARTITION "PTACTRLSUC18"  VALUES LESS THAN (8337) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP18_DAT" , 
 PARTITION "PTACTRLSUC19"  VALUES LESS THAN (8964) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP19_DAT" , 
 PARTITION "PTACTRLSUC20"  VALUES LESS THAN (10000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLSUC_RP20_DAT" ) ;
  GRANT DELETE ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFACTVT";
  GRANT INSERT ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFACTVT";
  GRANT SELECT ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFACTVT";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFACTVT";
  GRANT DELETE ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFFENIX";
  GRANT INSERT ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFFENIX";
  GRANT SELECT ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFFENIX";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TACTRLSUC" TO "USRINFFENIX";
