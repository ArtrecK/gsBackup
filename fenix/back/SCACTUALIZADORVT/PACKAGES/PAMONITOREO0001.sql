--------------------------------------------------------
--  DDL for Package PAMONITOREO0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAMONITOREO0001" AS
    PROCEDURE spgettotpagsucbloq (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    PROCEDURE spgetsucbloq (
        pa_numeropag        IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    PROCEDURE spdesbloquesuc (
        pa_erridrow         IN VARCHAR2,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

END pamonitoreo0001;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0001" TO "USRACTVT";
