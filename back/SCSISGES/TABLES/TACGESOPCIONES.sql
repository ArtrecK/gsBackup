--------------------------------------------------------
--  DDL for Table TACGESOPCIONES
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TACGESOPCIONES" 
   (	"FIGESOPCIONID" NUMBER(38,0), 
	"FITIPOGESTIONID" NUMBER(38,0), 
	"FILINEAID" NUMBER(38,0), 
	"FIPERIODOID" NUMBER(38,0), 
	"FIPROMOCIONID" NUMBER(38,0), 
	"FIPAISID" NUMBER(38,0), 
	"FITERRITORIOID" NUMBER(38,0), 
	"FIZONAID" NUMBER(38,0), 
	"FISTATUS" NUMBER(38,0) DEFAULT 1, 
	"FDCREACION" DATE DEFAULT SYSDATE, 
	"FDMODIFICO" DATE DEFAULT SYSDATE, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO_DAT" ;

   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FIGESOPCIONID" IS 'IDENTIFICADOR DE OPCIONES DE GESTION';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FITIPOGESTIONID" IS 'ID DEL CATALOGO TCTIPOGESTION';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FILINEAID" IS 'ID DE LA LINEA DEL PRODUCTO';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FIPERIODOID" IS 'ID DEL CATALOGO TACGESPERIODOS';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FIPROMOCIONID" IS 'ID DE LA PROMOCION';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FIPAISID" IS 'ID DEL PAIS';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FITERRITORIOID" IS 'ID DEL TERRIORIO';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FIZONAID" IS 'ID DE LA ZONA';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FISTATUS" IS 'BORRADO L�GICO. 1)ACTIVO 2)BORRADO';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FDCREACION" IS 'CAMPO DE AUDITORIA';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FDMODIFICO" IS 'CAMPO DE AUDITORIA';
   COMMENT ON COLUMN "SCSISGES"."TACGESOPCIONES"."FCUSRMODIFICO" IS 'CAMPO DE AUDITORIA';
  GRANT DELETE ON "SCSISGES"."TACGESOPCIONES" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TACGESOPCIONES" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TACGESOPCIONES" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TACGESOPCIONES" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TACGESOPCIONES" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TACGESOPCIONES" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TACGESOPCIONES" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TACGESOPCIONES" TO "USRINFSISGES";
