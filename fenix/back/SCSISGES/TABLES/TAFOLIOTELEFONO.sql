--------------------------------------------------------
--  DDL for Table TAFOLIOTELEFONO
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TAFOLIOTELEFONO" 
   (	"FIIDFOLIO" NUMBER(*,0), 
	"FIIDTELEFONO" NUMBER(*,0), 
	"FDSTATUS" DATE, 
	"FISTATUS" NUMBER(1,0), 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT USER, 
	"FDMODIFICACION" DATE DEFAULT SYSDATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA03_DAT" ;

   COMMENT ON COLUMN "SCSISGES"."TAFOLIOTELEFONO"."FIIDFOLIO" IS 'FOLIO UNICO GENERADO PARA VERIFICAR TELEFONOS';
   COMMENT ON COLUMN "SCSISGES"."TAFOLIOTELEFONO"."FIIDTELEFONO" IS 'ID DEL TELEFONO DE LA TABLA TATELEFONOS';
   COMMENT ON COLUMN "SCSISGES"."TAFOLIOTELEFONO"."FDSTATUS" IS 'FECHA EN QUE CAMBIO EL STATUS';
   COMMENT ON COLUMN "SCSISGES"."TAFOLIOTELEFONO"."FISTATUS" IS 'ESTATUS DEL FOLIO 0: POR VERIFICAR | 1: VERIFICADO | 2: NO VERIFICADO';
  GRANT DELETE ON "SCSISGES"."TAFOLIOTELEFONO" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TAFOLIOTELEFONO" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TAFOLIOTELEFONO" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TAFOLIOTELEFONO" TO "USRINFFENIX";
