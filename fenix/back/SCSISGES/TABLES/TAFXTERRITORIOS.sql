--------------------------------------------------------
--  DDL for Table TAFXTERRITORIOS
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAFXTERRITORIOS" 
   (	"FIIDPAIS" NUMBER(3,0), 
	"FIIDTERRITORIO" NUMBER(10,0), 
	"FCDESCTERRIRORIO" VARCHAR2(100 BYTE), 
	"FIESTATUS" NUMBER(1,0), 
	"FDMODIFICACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE), 
	"FITIPOGEO" NUMBER(1,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO_DAT" ;

   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FIIDPAIS" IS 'ID DEL PAIS, DEL CATALOGO TCPAIS';
   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FIIDTERRITORIO" IS 'ID DEL TERRITORIO PROPORCIONADO POR CECO';
   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FCDESCTERRIRORIO" IS 'NOMBRE DEL TERRITORIO';
   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FIESTATUS" IS 'BORRADO LOGICO: 1 ACTIVO | 0 INACTIVO';
   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FDMODIFICACION" IS 'CAMPO DE AUDITORIA: ULTIMA MODIFICACION';
   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FCUSRMODIFICO" IS 'CAMPO DE AUDITORIA: USUARIO QUE MODIFICO';
   COMMENT ON COLUMN "SCSISGES"."TAFXTERRITORIOS"."FITIPOGEO" IS ' TIPO DE GEOGRAFIA: 1 BANCO AZTECA | 2 ELEKTRA';
  GRANT DELETE ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TAFXTERRITORIOS" TO "USRINFSISGES";
