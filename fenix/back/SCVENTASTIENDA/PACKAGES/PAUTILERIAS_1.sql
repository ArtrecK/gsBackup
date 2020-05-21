--------------------------------------------------------
--  DDL for Package PAUTILERIAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PAUTILERIAS" AS
/*******************************************************************************
  Proyecto:     GESTION CLIENTES
  Descripcion:  Paquete de utilerias para pago de servicios
  Parametros de Entrada: paFecha      fecha
  Parametros de Salida:
  Valor de Retorno: Regresa un registro tipo cursor
  Parametros de Entrada-Salida:
  PreCondiciones:
  Creador:           Carolina P�rez Vite
  Fecha de Creacion:  24 de Abril del 2018
*******************************************************************************/
    FUNCTION fnobtenerformatofecha (
        pa_fecha IN CHAR
    ) RETURN DATE;

    FUNCTION fnconviertenumerico (
        pa_convertir VARCHAR2
    ) RETURN NUMBER;

END pautilerias;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAUTILERIAS" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAUTILERIAS" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAUTILERIAS" TO "SCACTUALIZADORVT";
