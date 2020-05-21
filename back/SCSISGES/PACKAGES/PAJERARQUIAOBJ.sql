--------------------------------------------------------
--  DDL for Package PAJERARQUIAOBJ
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAJERARQUIAOBJ" 
AS
   PROCEDURE SPINSOBJETIVOSSUC (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSREG (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSZON (PA_CODIGO    OUT INTEGER,
                                PA_MENSAJE   OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSTERR (PA_CODIGO    OUT INTEGER,
                                 PA_MENSAJE   OUT VARCHAR2);

   PROCEDURE SPINSOBJETIVOSPAIS (PA_CODIGO    OUT INTEGER,
                                 PA_MENSAJE   OUT VARCHAR2);
END PAJERARQUIAOBJ;
/
