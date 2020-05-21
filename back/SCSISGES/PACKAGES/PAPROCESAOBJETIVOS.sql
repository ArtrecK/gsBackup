--------------------------------------------------------
--  DDL for Package PAPROCESAOBJETIVOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAPROCESAOBJETIVOS" 
AS
   PROCEDURE SPINSJERARQUIA (PA_CODIGO OUT INTEGER, PA_MENSAJE OUT VARCHAR2);

   PROCEDURE SPPROCESOSDIA (PA_CODIGO OUT INTEGER, PA_MENSAJE OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSEMP (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2);

   PROCEDURE SPPROCESOSSEM (PA_CODIGO OUT INTEGER, PA_MENSAJE OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSHIST (PA_SEMANA    IN     INTEGER,
                                 PA_CODIGO       OUT INTEGER,
                                 PA_MENSAJE      OUT VARCHAR2);

   PROCEDURE SPDELOBJETIVOSEMP (PA_SEMANA    IN     INTEGER,
                                PA_CODIGO       OUT INTEGER,
                                PA_MENSAJE      OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSEMEMP (PA_SEMANA    IN     INTEGER,
                                  PA_CODIGO       OUT INTEGER,
                                  PA_MENSAJE      OUT VARCHAR2);

   PROCEDURE SPDELOBJETIVOSHIST (PA_CODIGO    OUT INTEGER,
                                 PA_MENSAJE   OUT VARCHAR2);
END PAPROCESAOBJETIVOS;

/
