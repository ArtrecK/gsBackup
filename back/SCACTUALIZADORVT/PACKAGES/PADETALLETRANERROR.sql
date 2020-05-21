--------------------------------------------------------
--  DDL for Package PADETALLETRANERROR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PADETALLETRANERROR" 
AS
   /*************************************************************************************************************
   Proyecto:              Manejo de transacciones en error recurrente
   Proposito:             Actualizaci�n de los detalles en error
   Parametros de entrada: --
   Par�metros de salida:  --
   Valores de retorno:    --
   Llamado por:           Ejecuci�n manual mediante la p�gina de monitoreo
   Creador:               Erick Alberto Arana Trenado
   Fecha de Creaci�n:     Septiembre 2018
   Precondiciones:        P�gina de Monitoreo para su ejecuci�n
   *************************************************************************************************************/
   PROCEDURE SPTRANDETERROR (
      PA_COUNTRY             SCACTUALIZADORVT.TATRNCRCB.FIPAISID%TYPE,
      PA_CHANNEL             SCACTUALIZADORVT.TATRNCRCB.FICANAL%TYPE,
      PA_BRANCH              SCACTUALIZADORVT.TATRNCRCB.FISUCURSAL%TYPE,
      PA_TRANSACTION         SCACTUALIZADORVT.TATRNCRCB.FITRANNO%TYPE,
      PA_TRN_TYPE            SCACTUALIZADORVT.TATRNCRCB.FITRANTIPO%TYPE,
      PA_CON_TYPE            SCACTUALIZADORVT.TATRNCRCB.FICONSECTIPO%TYPE,
      PA_DATE                SCACTUALIZADORVT.TATRNCRCB.FDTRANSFECHR%TYPE,
      PA_WS                  SCACTUALIZADORVT.TATRNCRCB.FCTRANWS%TYPE,
      PA_USER                SCACTUALIZADORVT.TATRNCRCB.FCTRANUSR%TYPE,
      PA_FAULT           OUT INTEGER,
      PA_MESSAGE_FAULT   OUT VARCHAR2);
END PADETALLETRANERROR;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADETALLETRANERROR" TO "USRACTVT";
  GRANT EXECUTE ON "SCACTUALIZADORVT"."PADETALLETRANERROR" TO "USRINFFENIX";
