--------------------------------------------------------
--  DDL for Package PADEPURACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PADEPURACION" AS
/*************************************************************************************************************
Proyecto:              Depuracion de Tablas
Proposito:             Crear Proces de Depuraci�n de Tablas
Parametros de entrada: --
Par�metros de salida:  --
Valores de retorno:    --
Llamado por:           Timer de depuraci�n.
Creador:               Erick Alberto Arana Trenado
Fecha de Creaci�n:     Septiembre 2018
Precondiciones:        Ninguna
*************************************************************************************************************/

PROCEDURE SPDEPURAHIST (PA_CODE      OUT INTEGER,
                        PA_MESSAGE   OUT VARCHAR2,
                        PA_DETAIL    OUT VARCHAR2);
END PADEPURACION;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADEPURACION" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADEPURACION" TO "USRINFFENIX";
