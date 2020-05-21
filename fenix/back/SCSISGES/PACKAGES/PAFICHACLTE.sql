--------------------------------------------------------
--  DDL for Package PAFICHACLTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAFICHACLTE" 
IS
   PROCEDURE SPPROMOCIONES (PA_FIPAIS          IN     INTEGER,
                            PA_FICANAL         IN     INTEGER,
                            PA_FISUCURSALCTE   IN     INTEGER,
                            PA_FIFOLIO         IN     INTEGER,
                            PA_CURDATOS           OUT SYS_REFCURSOR,
                            PA_MENSAJE            OUT VARCHAR2,
                            PA_CODERROR           OUT INTEGER,
                            PA_DESERROR           OUT VARCHAR2);

   PROCEDURE SPACTSTATUSINTERES (PA_FIPAIS          IN     INTEGER,
                                 PA_FICANAL         IN     INTEGER,
                                 PA_FISUCURSALCTE   IN     INTEGER,
                                 PA_FIFOLIO         IN     INTEGER,
                                 PA_FIPRIORIDAD     IN     INTEGER,
                                 PA_FCEMPNO         IN     VARCHAR2,
                                 PA_MENSAJE            OUT VARCHAR2,
                                 PA_CODERROR           OUT INTEGER,
                                 PA_DESERROR           OUT VARCHAR2);

   PROCEDURE SPGESTIONINFOPROMO (PA_MENSAJE    OUT VARCHAR2,
                                 PA_CODERROR   OUT INTEGER,
                                 PA_DESERROR   OUT VARCHAR2);
END PAFICHACLTE;

/

  GRANT EXECUTE ON "SCSISGES"."PAFICHACLTE" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAFICHACLTE" TO "USRVENTAST";
