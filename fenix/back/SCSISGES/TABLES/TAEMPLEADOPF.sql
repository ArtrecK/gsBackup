--------------------------------------------------------
--  DDL for Table TAEMPLEADOPF
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAEMPLEADOPF" 
   (	"FNEMPLEADO" NUMBER, 
	"FCNOMBRE" VARCHAR2(100 BYTE), 
	"FCAPATERNO" VARCHAR2(100 BYTE), 
	"FCAMATERNO" VARCHAR2(100 BYTE), 
	"FNFUNCIONSAP" NUMBER, 
	"FNEMPLEADOJEFE" NUMBER, 
	"FNCC" NUMBER, 
	"FCNEGOCIO" VARCHAR2(3 BYTE), 
	"FIIDLABORA" NUMBER(3,0), 
	"FDULTIMAMODIFICACION" DATE DEFAULT SYSDATE, 
	"FDBAJA" DATE, 
	"FDALTA" DATE, 
	"FISITUACION" NUMBER(1,0), 
	"FIIDSUCURSAL" NUMBER(5,0), 
	"FIIDPERFIL" NUMBER(3,0), 
	"FNORIGEN" NUMBER(1,0), 
	"FCUSRCREACION" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDMODIFICO" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA02_DAT" ;
  GRANT DELETE ON "SCSISGES"."TAEMPLEADOPF" TO "SCVENTASTIENDA";
  GRANT INSERT ON "SCSISGES"."TAEMPLEADOPF" TO "SCVENTASTIENDA";
  GRANT SELECT ON "SCSISGES"."TAEMPLEADOPF" TO "SCVENTASTIENDA";
  GRANT UPDATE ON "SCSISGES"."TAEMPLEADOPF" TO "SCVENTASTIENDA";
  GRANT DELETE ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAEMPLEADOPF" TO "USRINFSISGES";
  GRANT DELETE ON "SCSISGES"."TAEMPLEADOPF" TO "USRSISGES";
  GRANT INSERT ON "SCSISGES"."TAEMPLEADOPF" TO "USRSISGES";
  GRANT SELECT ON "SCSISGES"."TAEMPLEADOPF" TO "USRSISGES";
  GRANT UPDATE ON "SCSISGES"."TAEMPLEADOPF" TO "USRSISGES";
