--------------------------------------------------------
--  DDL for Table TATRNCRDTH_TMP
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TATRNCRDTH_TMP" 
   (	"FIPAISID" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FITRANNO" NUMBER(10,0), 
	"FICONSDETA" NUMBER(10,0), 
	"FITIPOREG" NUMBER(5,0), 
	"FCDATODETA" VARCHAR2(270 CHAR), 
	"FDFECHAFINPROCESO" DATE, 
	"FDCREACION" DATE, 
	"FDMODIFICO" DATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_CATALOGO_DAT" ;
