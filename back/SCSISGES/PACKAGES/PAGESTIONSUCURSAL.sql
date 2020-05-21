--------------------------------------------------------
--  DDL for Package PAGESTIONSUCURSAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAGESTIONSUCURSAL" 
IS
   PROCEDURE SPGESTIONSUCURSAL (pa_sucursal        IN     INTEGER,
                                pa_cursupervisor      OUT SYS_REFCURSOR,
                                pa_codmsg             OUT INTEGER,
                                pa_msg                OUT VARCHAR2,
                                pa_msgerror           OUT VARCHAR2);
END PAGESTIONSUCURSAL;

/

  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRINFVENTAST";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGESTIONSUCURSAL" TO "USRVENTAST";
