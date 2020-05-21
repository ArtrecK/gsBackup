--------------------------------------------------------
--  DDL for Package PAGESTACUMULADO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAGESTACUMULADO" 
IS
   PROCEDURE SPACUMULADOSUPERV (PA_SUCURSAL        IN     INTEGER,
                                PA_CURSUPERVACUM      OUT SYS_REFCURSOR,
                                PA_CODMSG             OUT INTEGER,
                                PA_MSG                OUT VARCHAR2,
                                PA_MSGERROR           OUT VARCHAR2);
END PAGESTACUMULADO;

/

  GRANT EXECUTE ON "SCSISGES"."PAGESTACUMULADO" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGESTACUMULADO" TO "USRSISGES";
