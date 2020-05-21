--------------------------------------------------------
--  DDL for Package PAPRODUCT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PAPRODUCT" 
AS 
  PROCEDURE spproduct (
        pa_fnsku   IN scventastienda.tcproducto.fnsku%TYPE,
        pa_curproduct   OUT SYS_REFCURSOR,
        pa_code            OUT INTEGER,
        pa_message         OUT VARCHAR2
    );

END PAPRODUCT;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAPRODUCT" TO "USRVENTAST";
