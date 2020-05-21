--------------------------------------------------------
--  DDL for Table TCFXSUCURSAL
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCFXSUCURSAL" 
   (	"FIIDPAIS" NUMBER(3,0), 
	"FIIDTERRITORIO" NUMBER(6,0), 
	"FIIDZONA" NUMBER(6,0), 
	"FIIDREGION" NUMBER(6,0), 
	"FIIDSUCURSAL" NUMBER(4,0), 
	"FIIDCANAL" NUMBER(3,0), 
	"FINUMCECOSUC" NUMBER(6,0), 
	"FCNOMBRESUC" VARCHAR2(100 BYTE), 
	"FDFECACTUAL" DATE, 
	"FCTIPO" VARCHAR2(30 CHAR), 
	"FDINICIOOPERACIONES" DATE, 
	"FNIVA" NUMBER(5,4), 
	"FIESTATUS" NUMBER(1,0), 
	"FIIDDIVISION" NUMBER(5,0), 
	"FCCALLE" VARCHAR2(100 CHAR), 
	"FCNUMEXT" VARCHAR2(20 CHAR), 
	"FCNUMINT" VARCHAR2(20 CHAR), 
	"FCCOLONIA" VARCHAR2(100 CHAR), 
	"FCMUNICIPIO" VARCHAR2(100 CHAR), 
	"FCESTADO" VARCHAR2(30 CHAR), 
	"FCCP" VARCHAR2(5 CHAR), 
	"FIIDENTIDAD" NUMBER(5,0), 
	"FDMODIFICACION" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA01_DAT" ;

   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FIIDPAIS" IS 'ID PAIS DEL CATALOGO TCPAIS';
   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FCNOMBRESUC" IS 'NOMBRE DE LA SUCURSAL';
   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FNIVA" IS 'IVA DE LA SUCURSAL';
   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FIESTATUS" IS 'STATUS DE LA SUCURSAL 1: ACTIVA | 0: CERRADA';
   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FIIDDIVISION" IS 'ID DE LA DIVISION';
   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FDMODIFICACION" IS 'CAMPO DE AUDITORIA: ULTIMA MODIFICACION';
   COMMENT ON COLUMN "SCSISGES"."TCFXSUCURSAL"."FCUSRMODIFICO" IS 'CAMPO DE AUDITORIA: USUARIO QUE MODIFICO';
  GRANT DELETE ON "SCSISGES"."TCFXSUCURSAL" TO "SCVENTASTIENDA";
  GRANT INSERT ON "SCSISGES"."TCFXSUCURSAL" TO "SCVENTASTIENDA";
  GRANT SELECT ON "SCSISGES"."TCFXSUCURSAL" TO "SCVENTASTIENDA";
  GRANT UPDATE ON "SCSISGES"."TCFXSUCURSAL" TO "SCVENTASTIENDA";
  GRANT DELETE ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TCFXSUCURSAL" TO "USRINFSISGES";
