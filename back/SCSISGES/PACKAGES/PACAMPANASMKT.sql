--------------------------------------------------------
--  DDL for Package PACAMPANASMKT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PACAMPANASMKT" 
IS

   PROCEDURE SPPROCESAMKT (PA_PAIS           IN     NUMBER,
                           PA_NEGOCIO        IN     NUMBER,
                           PA_TAMANIOBULK    IN     NUMBER,
                           PA_FNFINALIZOWF      OUT NUMBER,
                           PA_FNFINALIZOSP      OUT NUMBER,
                           PA_CODERROR          OUT INTEGER,
                           PA_DESCERROR         OUT VARCHAR2);

   PROCEDURE SPPROCESACAMP (PA_PAIS          IN     NUMBER,
                            PA_CAMPANA       IN     NUMBER,
                            PA_TAMANIOBULK   IN     NUMBER,
                            PA_CODERROR         OUT INTEGER,
                            PA_DESCERROR        OUT VARCHAR2);

   PROCEDURE SPRESPALDO (PA_PAIS        IN     NUMBER,
                         PA_CODERROR       OUT INTEGER,
                         PA_DESCERROR      OUT VARCHAR2);
END PACAMPANASMKT;

/

  GRANT EXECUTE ON "SCSISGES"."PACAMPANASMKT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PACAMPANASMKT" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PACAMPANASMKT" TO "USRSISGES";
