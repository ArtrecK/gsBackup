--------------------------------------------------------
--  DDL for Table TAFXCARTERAPF
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAFXCARTERAPF" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(5,0), 
	"FIFOLIO" NUMBER(20,0), 
	"FIIDPORTAFOLIO" NUMBER(12,0), 
	"FIIDSUCURSAL" NUMBER(5,0), 
	"FNUMEMPSOL" NUMBER(10,0), 
	"FCTIPOMOV" VARCHAR2(25 BYTE), 
	"FIEMPDUENIO" NUMBER(10,0), 
	"FNSTATUSCTE" NUMBER(1,0), 
	"FIIDROL" NUMBER(10,0), 
	"FIIDPUESTO" NUMBER(6,0), 
	"FIIDEMPLEADO" NUMBER(10,0), 
	"FIIDPOSICION" NUMBER(*,0), 
	"FDMODIFICACION" DATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE)
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP01_DAT" 
  PARTITION BY RANGE ("FIIDSUCURSAL") 
 (PARTITION "TAFXCARTERAP_01"  VALUES LESS THAN (1000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP01_DAT" , 
 PARTITION "TAFXCARTERAP_02"  VALUES LESS THAN (2000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP02_DAT" , 
 PARTITION "TAFXCARTERAP_03"  VALUES LESS THAN (3000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP03_DAT" , 
 PARTITION "TAFXCARTERAP_04"  VALUES LESS THAN (4000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP04_DAT" , 
 PARTITION "TAFXCARTERAP_05"  VALUES LESS THAN (5000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP05_DAT" , 
 PARTITION "TAFXCARTERAP_06"  VALUES LESS THAN (6000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP06_DAT" , 
 PARTITION "TAFXCARTERAP_07"  VALUES LESS THAN (7000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP07_DAT" , 
 PARTITION "TAFXCARTERAP_08"  VALUES LESS THAN (8000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP08_DAT" , 
 PARTITION "TAFXCARTERAP_09"  VALUES LESS THAN (9000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP09_DAT" , 
 PARTITION "TAFXCARTERAP_10"  VALUES LESS THAN (MAXVALUE) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP10_DAT" ) ;
  GRANT DELETE ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAFXCARTERAPF" TO "USRINFSISGES";
