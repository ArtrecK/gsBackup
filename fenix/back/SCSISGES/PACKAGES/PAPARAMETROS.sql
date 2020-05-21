--------------------------------------------------------
--  DDL for Package PAPARAMETROS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAPARAMETROS" 
IS
   -- Author  : B643963
   -- Created : 26/09/2018 04:34:30 p.m.
   -- Purpose : Consultar propiedades de parametrizaci�n para modulos de prueba en front

   PROCEDURE spConsultaParam (pa_modulo        IN     VARCHAR2,
                              cur_parametros      OUT SYS_REFCURSOR,
                              pa_code             OUT INTEGER,
                              pa_message          OUT VARCHAR2);
END PAPARAMETROS;

/***********************************************/

/

  GRANT EXECUTE ON "SCSISGES"."PAPARAMETROS" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAPARAMETROS" TO "USRSISGES";
