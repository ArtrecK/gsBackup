--------------------------------------------------------
--  DDL for Table TACAT_ERROR
--------------------------------------------------------

  CREATE TABLE "SCACTUALIZADORVT"."TACAT_ERROR" 
   (	"FIERR_ID" NUMBER(5,0), 
	"FCERR_TIPO" VARCHAR2(4 CHAR), 
	"FCERR_SEVERIDAD" VARCHAR2(1 CHAR), 
	"FCERR_CAUSA" VARCHAR2(2000 CHAR), 
	"FCERR_ACCION" VARCHAR2(2000 CHAR), 
	"FCORA_USR" VARCHAR2(40 CHAR), 
	"FDERR_FECALTA" DATE, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_CATALOGO_DAT" ;
  GRANT DELETE ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFACTVT";
  GRANT INSERT ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFACTVT";
  GRANT SELECT ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFACTVT";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFACTVT";
  GRANT DELETE ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFFENIX";
  GRANT INSERT ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFFENIX";
  GRANT SELECT ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFFENIX";
  GRANT UPDATE ON "SCACTUALIZADORVT"."TACAT_ERROR" TO "USRINFFENIX";
