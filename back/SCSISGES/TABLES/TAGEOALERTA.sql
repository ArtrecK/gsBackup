--------------------------------------------------------
--  DDL for Table TAGEOALERTA
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAGEOALERTA" 
   (	"FIGEOALERTAID" NUMBER(*,0), 
	"FIALERTAID" NUMBER(*,0), 
	"FIPAISID" NUMBER(6,0), 
	"FITERRITORIOID" NUMBER(6,0), 
	"FIZONAID" NUMBER(6,0), 
	"FIREGIONID" NUMBER(6,0), 
	"FISUCURSALID" NUMBER(10,0), 
	"FIEMPNUM" NUMBER(10,0), 
	"FIFUNCION" NUMBER(10,0), 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDULTIMAMODIFICACION" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA02_DAT" ;
  GRANT DELETE ON "SCSISGES"."TAGEOALERTA" TO "SCACTUALIZADORVT";
  GRANT INSERT ON "SCSISGES"."TAGEOALERTA" TO "SCACTUALIZADORVT";
  GRANT SELECT ON "SCSISGES"."TAGEOALERTA" TO "SCACTUALIZADORVT";
  GRANT UPDATE ON "SCSISGES"."TAGEOALERTA" TO "SCACTUALIZADORVT";
  GRANT DELETE ON "SCSISGES"."TAGEOALERTA" TO "SCVENTASTIENDA";
  GRANT INSERT ON "SCSISGES"."TAGEOALERTA" TO "SCVENTASTIENDA";
  GRANT SELECT ON "SCSISGES"."TAGEOALERTA" TO "SCVENTASTIENDA";
  GRANT UPDATE ON "SCSISGES"."TAGEOALERTA" TO "SCVENTASTIENDA";
  GRANT DELETE ON "SCSISGES"."TAGEOALERTA" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAGEOALERTA" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAGEOALERTA" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAGEOALERTA" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAGEOALERTA" TO "USRSISGES";
  GRANT INSERT ON "SCSISGES"."TAGEOALERTA" TO "USRSISGES";
  GRANT SELECT ON "SCSISGES"."TAGEOALERTA" TO "USRSISGES";
  GRANT UPDATE ON "SCSISGES"."TAGEOALERTA" TO "USRSISGES";
