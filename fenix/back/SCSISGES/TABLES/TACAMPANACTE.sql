--------------------------------------------------------
--  DDL for Table TACAMPANACTE
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TACAMPANACTE" 
   (	"FIIDCAMPANA" NUMBER(8,0), 
	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(5,0), 
	"FIFOLIO" NUMBER(20,0), 
	"FIIDEMPLEADO" NUMBER(10,0), 
	"FNSTATUSCTE" NUMBER(1,0), 
	"FIIDPAIS" NUMBER(1,0), 
	"FIIDTERRITORIO" NUMBER(6,0), 
	"FIIDZONA" NUMBER(6,0), 
	"FIIDREGION" NUMBER(6,0), 
	"FIIDSUCURSAL" NUMBER(5,0), 
	"FDMODIFICACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TACAMPANAC_RP01_DAT" 
  PARTITION BY RANGE ("FIIDSUCURSAL") 
 (PARTITION "CAMPANACTE_01"  VALUES LESS THAN (2000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TACAMPANAC_RP01_DAT" , 
 PARTITION "CAMPANACTE_02"  VALUES LESS THAN (4000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TACAMPANAC_RP02_DAT" , 
 PARTITION "CAMPANACTE_03"  VALUES LESS THAN (6000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TACAMPANAC_RP03_DAT" , 
 PARTITION "CAMPANACTE_04"  VALUES LESS THAN (8000) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TACAMPANAC_RP04_DAT" , 
 PARTITION "CAMPANACTE_05"  VALUES LESS THAN (MAXVALUE) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TACAMPANAC_RP05_DAT" ) ;
  GRANT DELETE ON "SCSISGES"."TACAMPANACTE" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TACAMPANACTE" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TACAMPANACTE" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TACAMPANACTE" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TACAMPANACTE" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TACAMPANACTE" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TACAMPANACTE" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TACAMPANACTE" TO "USRINFSISGES";
