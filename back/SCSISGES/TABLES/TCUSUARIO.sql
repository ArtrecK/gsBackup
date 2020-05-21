--------------------------------------------------------
--  DDL for Table TCUSUARIO
--------------------------------------------------------

  CREATE TABLE "SCSISGES"."TCUSUARIO" 
   (	"FIIDUSUARIO" NUMBER(*,0), 
	"FIIDROL" NUMBER(*,0), 
	"FIIDROLSAP" NUMBER(*,0), 
	"FCNOMBRE" VARCHAR2(50 BYTE), 
	"FCAPPATERNO" VARCHAR2(50 BYTE), 
	"FCAPMATERNO" VARCHAR2(50 BYTE), 
	"FCPASSWORD" VARCHAR2(80 BYTE), 
	"FIESTATUS" NUMBER(*,0), 
	"FCEMAIL" VARCHAR2(50 BYTE), 
	"FDFECACTUALSYS" DATE, 
	"FDFECACTUALSAP" DATE, 
	"FDFECALTA" DATE, 
	"FDFECPASS" DATE, 
	"FIIDPUESTO" NUMBER(*,0), 
	"FIDIADESCACT" NUMBER(*,0), 
	"FIDIADESCSIG" NUMBER(*,0), 
	"FISEMANADESC" NUMBER(*,0), 
	"FIIDSUCURSAL" NVARCHAR2(4), 
	"FDFECHAMODIF" DATE, 
	"FIPUESTOANT" NUMBER, 
	"FIHISTEJEC" NUMBER(*,0), 
	"FIFUNCION" NUMBER(*,0), 
	"FIPOSICION" NUMBER(*,0), 
	"FCCC" NUMBER(*,0), 
	"FIPOSANT" VARCHAR2(20 BYTE), 
	"FDULTIMAMODIFICACION" DATE DEFAULT sysdate, 
	"FCUSRMODIFICO" VARCHAR2(30 BYTE) DEFAULT user
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_CATALOGO3_DAT" ;
  GRANT DELETE ON "SCSISGES"."TCUSUARIO" TO "USRINFFENIX";
  GRANT INSERT ON "SCSISGES"."TCUSUARIO" TO "USRINFFENIX";
  GRANT SELECT ON "SCSISGES"."TCUSUARIO" TO "USRINFFENIX";
  GRANT UPDATE ON "SCSISGES"."TCUSUARIO" TO "USRINFFENIX";
  GRANT DELETE ON "SCSISGES"."TCUSUARIO" TO "USRINFSISGES";
  GRANT INSERT ON "SCSISGES"."TCUSUARIO" TO "USRINFSISGES";
  GRANT SELECT ON "SCSISGES"."TCUSUARIO" TO "USRINFSISGES";
  GRANT UPDATE ON "SCSISGES"."TCUSUARIO" TO "USRINFSISGES";
