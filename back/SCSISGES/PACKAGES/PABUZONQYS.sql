--------------------------------------------------------
--  DDL for Package PABUZONQYS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PABUZONQYS" AS
/*************************************************************
Proyecto: Sistema de Gestion
Descripci�n: Paquete de Buzon de Quejas y Sugerencias
Par�metros de entrada: N/A
Par�metros de salida: N/A
Valor de retorno: Tipo de datos de usuario
Par�metros de entrada-salida: N/A
Precondiciones: N/A
Creador: Daniel Esparza Rodriguez 
Fecha de creaci�n: 17-12-2018
*************************************************************/

    PROCEDURE SPGUARDABUZON (
      pa_FCEMPNUM               IN   SCSISGES.TABUZON.FCEMPNUM%TYPE,       
      pa_FISUCURSAL             IN   SCSISGES.TABUZON.FISUCURSAL%TYPE,           
      pa_FICATBUZONID           IN   SCSISGES.TABUZON.FICATBUZONID%TYPE,
      pa_FIESTBUZONID           IN   SCSISGES.TABUZON.FIESTBUZONID%TYPE,
      pa_FCTEXTOBUZON           IN   SCSISGES.TABUZON.FCTEXTOBUZON%TYPE,
      pa_FNTELEFONO             IN   VARCHAR2 DEFAULT NULL,
      pa_CODIGO                 OUT  INTEGER,
      pa_MENSAJE                OUT  VARCHAR2,
      pa_MENSAJEERROR           OUT  VARCHAR2);


    PROCEDURE SPOBTIENECATBUZ (
      pa_TIPOBUZON              IN SCSISGES.TCCATBUZON.FICATBUZONID%TYPE,
      pa_BANDERA                OUT INTEGER,
      cur_TIPOBUZON             OUT SYS_REFCURSOR,
      pa_CODIGO                 OUT INTEGER,
      pa_MENSAJE                OUT VARCHAR2);


END PABUZONQYS;

/

  GRANT EXECUTE ON "SCSISGES"."PABUZONQYS" TO "USRSISGES";
