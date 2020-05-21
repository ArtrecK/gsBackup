--------------------------------------------------------
--  DDL for Package PAACTUALIZA0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAACTUALIZA0001" 
AS
    PROCEDURE SPUPDBRANCHCAT (PA_CODE      OUT INTEGER,
                              PA_MESSAGE   OUT VARCHAR2,
                              PA_DETAIL    OUT VARCHAR2);

    PROCEDURE SPRUNUPDATERV2 (PA_TOTBLOCKS   IN     INTEGER,
                              PA_ACTBLOCK    IN     INTEGER,
                              PA_NUM_TRAN    IN     INTEGER,
                              PA_CODE           OUT INTEGER,
                              PA_MESSAGE        OUT VARCHAR2,
                              PA_DETAIL         OUT VARCHAR2);

    PROCEDURE SPRUNUPDATER (PA_NUM_TRAN   IN     INTEGER,
                            PA_CODE          OUT INTEGER,
                            PA_MESSAGE       OUT VARCHAR2,
                            PA_DETAIL        OUT VARCHAR2);

    PROCEDURE SPPROCESSBRANCH (PA_NUM_TRAN   IN INTEGER,
                               PA_COUNTRY    IN INTEGER,
                               PA_CHANNEL    IN INTEGER,
                               PA_BRANCH     IN INTEGER);

    PROCEDURE SPMOVEOK (PA_COUNTRY       IN INTEGER,
                        PA_CHANNEL       IN INTEGER,
                        PA_BRANCH        IN INTEGER,
                        PA_TRANSACTION   IN INTEGER);

    PROCEDURE SPMOVEERR (PA_COUNTRY       IN INTEGER,
                         PA_CHANNEL       IN INTEGER,
                         PA_BRANCH        IN INTEGER,
                         PA_TRANSACTION   IN INTEGER);

    PROCEDURE SPSAVEFAULT (PA_MESSAGE_FAULT IN VARCHAR2, ROW_ID IN ROWID);
END PAACTUALIZA0001;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZA0001" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZA0001" TO "USRINFFENIX";
