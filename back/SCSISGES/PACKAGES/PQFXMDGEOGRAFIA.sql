--------------------------------------------------------
--  DDL for Package PQFXMDGEOGRAFIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQFXMDGEOGRAFIA" 
IS
    -- Author  : 149766 - Arturo Lopez Patricio
    -- Created : 03/12/2018
    -- Purpose : geografias para aplicativo fenix

    PROCEDURE SPCONSULGEOGRAFIA (PA_TIPOGEOGRAFIA   IN     NUMBER,
                                 PA_FNPAIS          IN     NUMBER,
                                 PA_CURDATOS           OUT SYS_REFCURSOR,
                                 PA_FNCODERROR         OUT INTEGER,
                                 PA_FCDESERROR         OUT VARCHAR2);

    PROCEDURE SPCONSULPAISES (PA_CURDATOS     OUT SYS_REFCURSOR,
                              PA_FNCODERROR   OUT INTEGER,
                              PA_FCDESERROR   OUT VARCHAR2);

    PROCEDURE SPCONSULCANALES (PA_CURDATOS     OUT SYS_REFCURSOR,
                               PA_FNCODERROR   OUT INTEGER,
                               PA_FCDESERROR   OUT VARCHAR2);
END PQFXMDGEOGRAFIA;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXMDGEOGRAFIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXMDGEOGRAFIA" TO "USRSISGES";
