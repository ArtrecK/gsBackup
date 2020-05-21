--------------------------------------------------------
--  DDL for Package PATYPES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PATYPES" 
IS
/*************************************************************
Proyecto: Sistema de Gestion
Descripci�n: Paquete bodiless que contiene tipos de datos definidos
             por el usuario que ser�n utilizados de manera global
Par�metros de entrada: N/A
Par�metros de salida: N/A
Valor de retorno: Tipo de datos de usuario
Par�metros de entrada-salida: N/A
Precondiciones: N/A
Creador: Maria Canales
Fecha de creaci�n: 27 - 03 - 2018
*************************************************************/
   TYPE rcgCursor IS REF CURSOR; --Tipo de dato que contendr� el cursor de salida de las funciones de las p�ginas del Fron-End
END PATYPES;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PATYPES" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PATYPES" TO "USRVENTAST";
