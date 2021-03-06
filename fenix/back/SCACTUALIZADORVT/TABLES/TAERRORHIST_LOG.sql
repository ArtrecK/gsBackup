--------------------------------------------------------
--  DDL for Table TAERRORHIST_LOG
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TAERRORHIST_LOG" 
   (	"FIERR_CONSHIST" NUMBER, 
	"FIERR_CONS" NUMBER, 
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
	"FCORA_ERR_USRSOL" VARCHAR2(40 CHAR), 
	"FCERR_USRSOL" VARCHAR2(40 CHAR), 
	"FDERR_FECHASOL" DATE, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TAERHISLOG_DAT" ;
  GRANT DELETE ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFACTVT";
  GRANT INSERT ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFACTVT";
  GRANT SELECT ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFACTVT";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFACTVT";
  GRANT DELETE ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFFENIX";
  GRANT INSERT ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFFENIX";
  GRANT SELECT ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFFENIX";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TAERRORHIST_LOG" TO "USRINFFENIX";
