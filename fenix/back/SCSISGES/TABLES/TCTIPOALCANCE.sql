--------------------------------------------------------
--  DDL for Table TCTIPOALCANCE
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCTIPOALCANCE" 
   (	"FIALCANCEID" NUMBER(38,0), 
	"FIDESCRALCANCE" VARCHAR2(30 BYTE), 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT user, 
	"FDULTIMAMODIFICACION" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO3_DAT" ;
  GRANT DELETE ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TCTIPOALCANCE" TO "USRINFSISGES";
