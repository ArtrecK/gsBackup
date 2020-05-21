--------------------------------------------------------
--  DDL for Table TAALERTAPERSONA
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAALERTAPERSONA" 
   (	"FIALERTAID" NUMBER(*,0), 
	"FIEMPNUM" NUMBER(*,0), 
	"FICATALERTAID" NUMBER(3,0), 
	"FNSTATUS" NUMBER(1,0), 
	"FDMODIFICACION" DATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA03_DAT" ;
  GRANT DELETE ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAALERTAPERSONA" TO "USRINFSISGES";
