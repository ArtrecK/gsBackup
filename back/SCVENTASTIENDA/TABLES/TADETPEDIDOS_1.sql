--------------------------------------------------------
--  DDL for Table TADETPEDIDOS
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TADETPEDIDOS" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FINOPEDIDO" NUMBER(10,0), 
	"FIPRODID" NUMBER(15,0), 
	"FICANTART" NUMBER(10,0), 
	"FNPRCUNIT" NUMBER(15,2), 
	"FNPDCTODESCTO" NUMBER(15,2), 
	"FNPRODDESCTOE" NUMBER(15,2), 
	"FIPDCTOSTATUS" NUMBER(5,0), 
	"FNCOMISIONG" NUMBER(10,2), 
	"FNCOMISIONV" NUMBER(10,2), 
	"FNIMPSOBREP" NUMBER(15,4), 
	"FNCOSTOPDCTO" NUMBER(15,2), 
	"FNPORCENGANCHE" NUMBER(15,2) DEFAULT 0, 
	"FNINTERESES" NUMBER(15,2), 
	"FNPORCIVA" NUMBER(15,2), 
	"FNDESCTOMKT" NUMBER(15,2), 
	"FNPRECIOVENTA" NUMBER(15,2), 
	"FICVEPROM" NUMBER(15,0), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TADETPEDID_DAT" ;
  GRANT DELETE ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRSENDER";
  GRANT INSERT ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRSENDER";
  GRANT SELECT ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRSENDER";
  GRANT UPDATE ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRSENDER";
  GRANT DELETE ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFFENIX";
  GRANT DELETE ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFVENTAST";
  GRANT INSERT ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFVENTAST";
  GRANT SELECT ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFVENTAST";
  GRANT UPDATE ON "SCVENTASTIENDA"."TADETPEDIDOS" TO "USRINFVENTAST";
