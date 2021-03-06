--------------------------------------------------------
--  DDL for Type TYOBJGEOGRAFIAEKT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCSISGES"."TYOBJGEOGRAFIAEKT" IS OBJECT
(
    FCIDCANAL VARCHAR2 (3),
    FCCANAL VARCHAR2 (30),
    FIIDPAIS NUMBER (5),
    FCPAIS VARCHAR2 (30),
    FIIDCCBISABUELO NUMBER (15),
    FITIPOBISABUELO NUMBER (15),
    FCNOMBREBISABUELO VARCHAR2 (100),
    FIIDCCABUELO NUMBER (15),
    FITIPOABUELO NUMBER (15),
    FCNOMBREABUELO VARCHAR2 (100),
    FIIDCCPADRE NUMBER (10),
    FITIPOPADRE NUMBER (15),
    FCNOMBREPADRE VARCHAR2 (100),
    FINUMECO NUMBER (15),
    FIIDCC NUMBER (15),
    FCNOMECO VARCHAR2 (100),
    FCSTATUS_DESC VARCHAR2 (15),
    FDFECHAAPACT DATE,
    FDFECHACIERRE DATE,
    FCTIPOOP VARCHAR2 (15),
    FIIDENTIDAD NUMBER (38),
    FCNOMBREENTIDAD VARCHAR2 (100),
    FCCALLE VARCHAR2 (100),
    FCNUMEXT VARCHAR2 (20),
    FCNUMINT VARCHAR2 (20),
    FCCOLONIA VARCHAR2 (100),
    FCMUNICIPIO VARCHAR2 (100),
    FCESTADO VARCHAR2 (30),
    FICP NUMBER (15),
    FIIVA NUMBER (5, 2)
);

/

  GRANT EXECUTE ON "SCSISGES"."TYOBJGEOGRAFIAEKT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."TYOBJGEOGRAFIAEKT" TO "USRSISGES";
