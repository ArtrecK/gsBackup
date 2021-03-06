--------------------------------------------------------
--  DDL for Table TACREDVTATIENDA
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TACREDVTATIENDA" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FINOPEDIDO" NUMBER(10,0), 
	"FINGCIOIDGEST" NUMBER(3,0), 
	"FINOTIENDAGEST" NUMBER(5,0), 
	"FICTEIDGEST" NUMBER(10,0), 
	"FIDIGITOVERGEST" NUMBER(3,0), 
	"FIPAISGEST" NUMBER(3,0), 
	"FICANALGEST" NUMBER(3,0), 
	"FISUCURSALGEST" NUMBER(5,0), 
	"FIFOLIOGEST" NUMBER(10,0), 
	"FNIMPDOMICILIADO" NUMBER(9,2), 
	"FCTARJETA" VARCHAR2(16 BYTE), 
	"FIAUTORIZACION" NUMBER(10,0), 
	"FDCREACION" DATE, 
	"FDMODIFICO" DATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_DATA03_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRSENDER";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRSENDER";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRSENDER";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRSENDER";
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "SCACTUALIZADORVT";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "SCACTUALIZADORVT";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "SCACTUALIZADORVT";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "SCACTUALIZADORVT";
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFSISGES";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFSISGES";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFSISGES";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDVTATIENDA" TO "USRINFSISGES";
