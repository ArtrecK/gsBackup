--------------------------------------------------------
--  DDL for Package PAGEOGRAFIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAGEOGRAFIA" 
AS
   PROCEDURE spcurempleado (pa_funcionsap   IN     INTEGER,
                            pa_ceco         IN     INTEGER,
                            pa_curs            OUT SYS_REFCURSOR,
                            pa_coderror        OUT INTEGER,
                            pa_deserror        OUT VARCHAR2);
END pageografia;

/

  GRANT EXECUTE ON "SCSISGES"."PAGEOGRAFIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGEOGRAFIA" TO "USRSISGES";
