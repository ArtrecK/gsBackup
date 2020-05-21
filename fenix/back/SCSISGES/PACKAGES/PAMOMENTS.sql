--------------------------------------------------------
--  DDL for Package PAMOMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAMOMENTS" IS
/*************************************************************
Proyecto: Sistema de Gestion
Descripci�n: Paquete MOMENTS que contiene los tipos de momentos felices
Par�metros de entrada: N/A
Par�metros de salida: N/A
Valor de retorno: Tipo de datos de usuario
Par�metros de entrada-salida: N/A
Precondiciones: N/A
Creador: Nallely Grissel Campos Valle
Fecha de creaci�n: 29 - 05 - 2018
*************************************************************/
  --PROCEDURE SPMOMENTS(  status IN VARCHAR2,
    --                   evnCursor OUT SYS_REFCURSOR);
  /************************************************************************************/

  csl_1   CONSTANT INTEGER := 1;


PROCEDURE SPMOMENTSVW (pa_FIPADRE IN INTEGER
                                         , cur_MOMENTS OUT SYS_REFCURSOR
                                         , pa_CODIGO OUT INTEGER
                                         , pa_MENSAJE OUT VARCHAR2); 

  /************************************************************************************/

END PAMOMENTS;

/

  GRANT EXECUTE ON "SCSISGES"."PAMOMENTS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAMOMENTS" TO "USRVENTAST";
