--------------------------------------------------------
--  DDL for Table TAERROR_LOG_TMP
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TAERROR_LOG_TMP" 
   (	"FIERR_CONS" NUMBER, 
	"FCERR_PROCESO" VARCHAR2(4 CHAR), 
	"FIERR_ID" NUMBER(5,0), 
	"FCERR_MSG" VARCHAR2(2000 CHAR), 
	"FCORA_ERR" VARCHAR2(15 CHAR), 
	"FCORA_ERR_MESG" VARCHAR2(2000 CHAR), 
	"ORA_ERR_ROWID" ROWID, 
	"FCORA_ERR_USR" VARCHAR2(40 CHAR), 
	"FCORA_ERR_OSUSR" VARCHAR2(40 CHAR), 
	"FCORA_DB_NAME" VARCHAR2(40 CHAR), 
	"FIORA_INSTANCE" NUMBER, 
	"FCORA_INSTANCE_NAME" VARCHAR2(40 CHAR), 
	"FCORA_IP_ADDRESS" VARCHAR2(17 CHAR), 
	"FDERR_FECHA" DATE, 
	"FISTS_ERRSOL" NUMBER(2,0), 
	"FDFECHA_ERRSOL" DATE, 
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
