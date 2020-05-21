--------------------------------------------------------
--  DDL for Package Body PAUTILERIAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."PAUTILERIAS" AS
/*******************************************************************************
  Proyecto:     GESTION CLIENTES
  Descripcion:  Paquete de utilerias para pago de servicios
  Parametros de Entrada:
  Parametros de Salida:
  Valor de Retorno:
  Parametros de Entrada-Salida:
  Creador:           Carolina P�rez Vite
  Fecha de Creaci?n:  24 de Abril del 2018
*******************************************************************************/
    FUNCTION fnobtenerformatofecha (
        pa_fecha IN CHAR
    ) RETURN DATE IS
/*******************************************************************************
  Proyecto:     GESTION CLIENTES
  Descripcion:  Paquete de utilerias para pago de servicios 
  Parametros de Entrada: pa_fecha .- Fecha a formatear
  Parametros de Salida: Ninguno
  Valor de Retorno: Regresa un registro tipo fecha
  Parametros de Entrada-Salida:
  PreCondiciones:
  Creador:           Carolina P�rez Vite
  Fecha de Creacion:  24 de Abril del 2018
*************************************************************************************************************/
        vl_tipofecha   DATE := NULL; -- Fecha en cadena con formato YYYY-MM-DD HH24:MI:SS 
    BEGIN
        vl_tipofecha := TO_DATE(pa_fecha,'YYYY-MM-DD HH24:MI:SS');
        RETURN vl_tipofecha;
    END fnobtenerformatofecha;

    FUNCTION fnconviertenumerico (
        pa_convertir VARCHAR2
    ) RETURN NUMBER
/*************************************************************************************************************
   Proyecto:              GESTION CLIENTES
   Descripcion:           Convierte una cadena de caracteres a un numero.
   Parametros de entrada: pa_convertir - Cadena a convertir.
   Par?metros de Salida:  Ninguno
   Valor de retorno:      Devuelve un tipo numerico   
   PreCondiciones:
   Creador:               Carolina P�rez Vite
   Fecha de Creacion:     24 de Abril del 2018                     
*************************************************************************************************************/ AS

        vl_numerico           NUMBER(5,2) := 0;    --Variable que regresa el valor que se insertara en la tabla TAPAGOSERVICIOS
        csl_default           NUMBER(5,2) := 0.00; --Constante para el valor default de la funcion
        csl_posicioninicial   NUMBER(1) := 1;    --Constante para el comienzo del ciclo for
    BEGIN
        BEGIN
            vl_numerico := pa_convertir;
        EXCEPTION
            WHEN OTHERS THEN
                FOR i IN csl_posicioninicial..length(pa_convertir) LOOP
                    IF
                        substr(upper(pa_convertir),i,csl_posicioninicial) BETWEEN 'A' AND 'Z'
                    THEN
                        vl_numerico := csl_default;
                    END IF;
                END LOOP;
        END;

        RETURN vl_numerico;
    END fnconviertenumerico;

END pautilerias;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAUTILERIAS" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAUTILERIAS" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAUTILERIAS" TO "SCACTUALIZADORVT";
