--------------------------------------------------------
--  DDL for Package PAVTASSEMANALES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAVTASSEMANALES" 
IS
   PROCEDURE SPPROCESAVTAS (PA_MENSAJE    OUT VARCHAR2,
                            PA_CODERROR   OUT INTEGER,
                            PA_DESERROR   OUT VARCHAR2);

   PROCEDURE SPPROCESAOPE (PA_MENSAJE    OUT VARCHAR2,
                           PA_CODERROR   OUT INTEGER,
                           PA_DESERROR   OUT VARCHAR2);

   PROCEDURE SPPROCESAHIST (PA_MENSAJE    OUT VARCHAR2,
                            PA_CODERROR   OUT INTEGER,
                            PA_DESERROR   OUT VARCHAR2);
END PAVTASSEMANALES;

/

  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAVTASSEMANALES" TO "USRSISGES";
