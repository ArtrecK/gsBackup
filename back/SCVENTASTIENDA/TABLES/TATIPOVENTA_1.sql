--------------------------------------------------------
--  DDL for Table TATIPOVENTA
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TATIPOVENTA" 
   (	"FITIPOVENTA" NUMBER(3,0), 
	"FCDESCTIPOVENTA" VARCHAR2(100 CHAR), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_CATALOGO_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFVENTAST";
  GRANT INSERT ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFVENTAST";
  GRANT SELECT ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFVENTAST";
  GRANT UPDATE ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFVENTAST";
  GRANT DELETE ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TATIPOVENTA" TO "USRINFFENIX";
