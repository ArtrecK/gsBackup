--------------------------------------------------------
--  DDL for Package PAUTIL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAUTIL" AS
    TYPE rcg_tipocursor IS REF CURSOR; -- Se define el tipo CURSOR para utilizarlo en el retorno de las funciones
    PROCEDURE spictrlerrores (
        pa_tipoaplicacion   IN scactualizadorvt.tactrlerrores.fitipoaplicacion%TYPE,
        pa_originoerr       IN scactualizadorvt.tactrlerrores.fcorigino%TYPE,
        pa_numeroerr        IN scactualizadorvt.tactrlerrores.finumero%TYPE,
        pa_mensageerr       IN scactualizadorvt.tactrlerrores.fcmensaje%TYPE,
        pa_causaerr         IN scactualizadorvt.tactrlerrores.fccausa%TYPE
    );

END pautil;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAUTIL" TO "USRACTVT";
