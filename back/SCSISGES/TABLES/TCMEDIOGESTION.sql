--------------------------------------------------------
--  DDL for Table TCMEDIOGESTION
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCMEDIOGESTION" 
   (	"FIMEDIOGESTIONID" NUMBER(10,0), 
	"FCMEDIOSGESTIONDESC" VARCHAR2(50 BYTE), 
	"FDCREACION" DATE, 
	"FISTATUS" NUMBER(1,0), 
	"FDMODIFICACION" DATE, 
	"USRMODIFICO" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO2_DAT" ;
  GRANT DELETE ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TCMEDIOGESTION" TO "USRINFSISGES";
