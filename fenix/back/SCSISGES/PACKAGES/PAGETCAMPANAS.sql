--------------------------------------------------------
--  DDL for Package PAGETCAMPANAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAGETCAMPANAS" 
IS

   PROCEDURE SPCAMPANASCLTE (PA_FIPAIS           INTEGER,
                             PA_FICANAL          INTEGER,
                             PA_FISUCURSAL       INTEGER,
                             PA_FIFOLIO          INTEGER,
                             PA_CURDATOS     OUT SYS_REFCURSOR,
                             PA_MENSAJE      OUT VARCHAR2,
                             PA_CODERROR     OUT INTEGER,
                             PA_DESERROR     OUT VARCHAR2);

   PROCEDURE SPCTESCAMPANAS (PA_FCEMPLEADO       VARCHAR2,
                             PA_FISUCURSAL       NUMBER,
                             PA_CURSCAMP     OUT SYS_REFCURSOR,
                             PA_MENSAJE      OUT VARCHAR2,
                             PA_CODERROR     OUT INTEGER,
                             PA_DESERROR     OUT VARCHAR2);

   PROCEDURE SPCONTEOCTESCAMP (PA_FCEMPLEADO       VARCHAR2,
                               PA_FISUCURSAL       NUMBER,
                               PA_FIPAIS           NUMBER,
                               PA_CURSCAMP     OUT SYS_REFCURSOR,
                               PA_MENSAJE      OUT VARCHAR2,
                               PA_CODERROR     OUT INTEGER,
                               PA_DESERROR     OUT VARCHAR2);

   PROCEDURE SPCAMPANASACT (PA_CURSCAMPACT   OUT SYS_REFCURSOR,
                            PA_MENSAJE       OUT VARCHAR2,
                            PA_CODERROR      OUT INTEGER,
                            PA_DESERROR      OUT VARCHAR2);
END PAGETCAMPANAS;

/

  GRANT EXECUTE ON "SCSISGES"."PAGETCAMPANAS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGETCAMPANAS" TO "USRSISGES";
