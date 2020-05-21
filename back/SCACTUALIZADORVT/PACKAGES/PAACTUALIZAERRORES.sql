--------------------------------------------------------
--  DDL for Package PAACTUALIZAERRORES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAACTUALIZAERRORES" 
AS
   /*************************************************************************************************************
   Proyecto:              Manejo de transacciones en error recurrente
   Proposito:             Crear Proces de reclasificacion de transacciones en error
   Parametros de entrada: --
   Par�metros de salida:  --
   Valores de retorno:    --
   Llamado por:           Ejecuci�n manual mediante la p�gina de monitoreo
   Creador:               Erick Alberto Arana Trenado
   Fecha de Creaci�n:     Septiembre 2018
   Precondiciones:        P�gina de Monitoreo para su ejecuci�n
   *************************************************************************************************************/
   PROCEDURE SPACTUALIZAENERROR (PA_TOTBLOCKS   IN     INTEGER,
                                 PA_ACTBLOCK    IN     INTEGER,
                                 PA_NUM_TRAN    IN     INTEGER,
                                 PA_CODE           OUT INTEGER,
                                 PA_MESSAGE        OUT VARCHAR2,
                                 PA_DETAIL         OUT VARCHAR2);

   PROCEDURE SPACTERRORSUCURSAL (PA_NUM_TRAN   IN INTEGER,
                                 PA_COUNTRY    IN INTEGER,
                                 PA_CHANNEL    IN INTEGER,
                                 PA_BRANCH     IN INTEGER);

   PROCEDURE SPERRORSUCESS (PA_COUNTRY       IN INTEGER,
                            PA_CHANNEL       IN INTEGER,
                            PA_BRANCH        IN INTEGER,
                            PA_TRANSACTION   IN INTEGER,
                            ROW_ID           IN ROWID);

   PROCEDURE SPDESCRIPERROR (PA_MESSAGE_FAULT IN VARCHAR2, ROW_ID IN ROWID);
END PAACTUALIZAERRORES;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZAERRORES" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAACTUALIZAERRORES" TO "USRINFFENIX";
