--------------------------------------------------------
--  DDL for Table TALOGERRORES
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TALOGERRORES" 
   (	"FDFECHAERROR" DATE, 
	"FICODIGO" NUMBER(5,0), 
	"FCMENSAJE" VARCHAR2(600 BYTE), 
	"FCSPGENERA" VARCHAR2(50 BYTE), 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT user, 
	"FDULTMODIFICACION" DATE DEFAULT sysdate
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TALOGERROR_DAT" ;
  GRANT DELETE ON "SCSISGES"."TALOGERRORES" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TALOGERRORES" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TALOGERRORES" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TALOGERRORES" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TALOGERRORES" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TALOGERRORES" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TALOGERRORES" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TALOGERRORES" TO "USRINFSISGES";
