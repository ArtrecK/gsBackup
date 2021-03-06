--------------------------------------------------------
--  DDL for Table TACTETIENDAHIST
--------------------------------------------------------

  CREATE TABLE "SCVENTASTIENDA"."TACTETIENDAHIST" 
   (	"FIPAIS" NUMBER(5,0), 
	"FICANAL" NUMBER(5,0), 
	"FISUCURSAL" NUMBER(10,0), 
	"FINGCIOID" NUMBER(5,0), 
	"FINOTIENDA" NUMBER(10,0), 
	"FICTEID" NUMBER(15,0), 
	"FIDIGITOVER" NUMBER(5,0), 
	"FIFOLIO" NUMBER(15,0), 
	"FIPAISCU" NUMBER(5,0), 
	"FICANALCU" NUMBER(5,0), 
	"FISUCURSALCU" NUMBER(10,0), 
	"FDFECHAALTA" DATE DEFAULT TO_DATE ('01/01/1901', 'dd/mm/yyyy'), 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TACENCLITI_RP01_DAT" 
  PARTITION BY RANGE ("FDFECHAALTA") 
 (PARTITION "PTACENCLIENTESTIENDA1"  VALUES LESS THAN (TO_DATE(' 2019-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  STORAGE( INITIAL 8388608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TACENCLITI_RP01_DAT" ) ;
  GRANT SELECT ON "SCVENTASTIENDA"."TACTETIENDAHIST" TO "SCSISGES";
  GRANT DELETE ON "SCVENTASTIENDA"."TACTETIENDAHIST" TO "USRINFFENIX";
  GRANT INSERT ON "SCVENTASTIENDA"."TACTETIENDAHIST" TO "USRINFFENIX";
  GRANT SELECT ON "SCVENTASTIENDA"."TACTETIENDAHIST" TO "USRINFFENIX";
  GRANT UPDATE ON "SCVENTASTIENDA"."TACTETIENDAHIST" TO "USRINFFENIX";
