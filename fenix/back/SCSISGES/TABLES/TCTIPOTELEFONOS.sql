--------------------------------------------------------
--  DDL for Table TCTIPOTELEFONOS
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCTIPOTELEFONOS" 
   (	"FIIDTIPO" NUMBER(2,0), 
	"FCTIPOTELEFONO" VARCHAR2(80 BYTE), 
	"FNSTATUS" NUMBER(1,0), 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE), 
	"FDMODIFICACION" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO_DAT" ;
  GRANT DELETE ON "SCSISGES"."TCTIPOTELEFONOS" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCTIPOTELEFONOS" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCTIPOTELEFONOS" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCTIPOTELEFONOS" TO "USRINFFENIX";
