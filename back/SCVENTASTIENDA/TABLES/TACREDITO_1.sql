--------------------------------------------------------
--  DDL for Table TACREDITO
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TACREDITO" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FINOPEDIDO" NUMBER(10,0), 
	"FIPLAZO" NUMBER(10,0), 
	"FIPERIODO" NUMBER(5,0), 
	"FNENGANCHE" NUMBER(15,2) DEFAULT 0, 
	"FNPEDPAGOPER" NUMBER(15,2) DEFAULT 0, 
	"FNPEDULTPAGO" NUMBER(15,2) DEFAULT 0, 
	"FICLASIFCUENTA" NUMBER(5,0), 
	"FDFECULTPAGO" DATE DEFAULT TO_DATE ('01/01/1901', 'dd/mm/yyyy'), 
	"FNPEDIMPMORA" NUMBER(15,2) DEFAULT 0, 
	"FNULTIMPMORA" NUMBER(15,2) DEFAULT 0, 
	"FDPEDFECCALCINT" DATE DEFAULT TO_DATE ('01/01/1901', 'dd/mm/yyyy'), 
	"FINOATRASOS" NUMBER(5,0), 
	"FIPERIODOACT" NUMBER(10,0), 
	"FINOPERIODOCORR" NUMBER(10,0), 
	"FIDIASGRACIA" NUMBER(5,0), 
	"FDINIPERIODO" DATE DEFAULT TO_DATE ('01/01/1901', 'dd/mm/yyyy'), 
	"FDVENCIMIENTO" DATE DEFAULT TO_DATE ('01/01/1901', 'dd/mm/yyyy'), 
	"FNIMPPAGADO" NUMBER(15,2) DEFAULT 0, 
	"FNIMPDEVENG" NUMBER(15,2) DEFAULT 0, 
	"FCSTATCARTERA" VARCHAR2(10 CHAR) DEFAULT '', 
	"FITIR" NUMBER(10,0), 
	"FNPAGOMIN" NUMBER(15,2) DEFAULT 0, 
	"FNIMPBONIF" NUMBER(15,2) DEFAULT 0, 
	"FIZONACOBRO" NUMBER(15,0), 
	"FCCOBRADOR" VARCHAR2(10 CHAR), 
	"FDFECHAINACT" DATE DEFAULT TO_DATE ('01/01/1901', 'dd/mm/yyyy'), 
	"FIDIASINIPER" NUMBER(10,0), 
	"FITIPOCTA" NUMBER(5,0), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TACREDITO_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDITO" TO "USRSENDER";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDITO" TO "USRSENDER";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDITO" TO "USRSENDER";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDITO" TO "USRSENDER";
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFVENTAST";
  GRANT INSERT ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFVENTAST";
  GRANT SELECT ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFVENTAST";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACREDITO" TO "USRINFVENTAST";
