--------------------------------------------------------
--  DDL for Package PAINSERTAREPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAINSERTAREPORTES" 
IS
    -- Author  : CCAMPOS
    -- Created : 03/12/2018 03:48:55 p. m.
    -- Purpose : inserta en tabla de campa??as

    PROCEDURE SPBORRATABLACAMPREP;


    PROCEDURE SPPENDXSURTIR (pa_mensaje    OUT VARCHAR2,
                             pa_coderror   OUT INTEGER,
                             pa_deserror   OUT VARCHAR2);

    PROCEDURE SPSOLICITUDES (pa_mensaje    OUT VARCHAR2,
                             pa_coderror   OUT INTEGER,
                             pa_deserror   OUT VARCHAR2);

    PROCEDURE SPPRESUPUESTOS (pa_mensaje    OUT VARCHAR2,
                              pa_coderror   OUT INTEGER,
                              pa_deserror   OUT VARCHAR2);

    PROCEDURE SPPROMOCIONES (pa_mensaje    OUT VARCHAR2,
                             pa_coderror   OUT INTEGER,
                             pa_deserror   OUT VARCHAR2);
END PAINSERTAREPORTES;

/

  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAINSERTAREPORTES" TO "USRVENTAST";
