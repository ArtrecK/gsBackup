--------------------------------------------------------
--  DDL for Package Body PAPRODUCT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."PAPRODUCT" 
AS   
   PROCEDURE spproduct (
            pa_fnsku        IN scventastienda.tcproducto.fnsku%TYPE,
            pa_curproduct   OUT SYS_REFCURSOR,
            pa_code         OUT INTEGER,
            pa_message      OUT VARCHAR2)
   IS
   BEGIN
      OPEN pa_curproduct FOR
           SELECT FNSKU,
                FCDESCSKU,
                FNLINEASAP,
                FCDESCLINEASAP,
                FNSUBLINEASAP,
                FCDESCSUBLINEASAP,
                FNLINEASIE,
                FCDESCLINEASIE,
                FNSUBLINEASIE,
                FCDESCSUBLINEASIE,
                FNPRECIO
             FROM scventastienda.tcproducto
            WHERE FNSKU = pa_fnsku;

      pa_code := 200;
      pa_message := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_code := SQLCODE;
         pa_message := SQLERRM;
   END spproduct;   
END PAPRODUCT;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAPRODUCT" TO "USRVENTAST";
