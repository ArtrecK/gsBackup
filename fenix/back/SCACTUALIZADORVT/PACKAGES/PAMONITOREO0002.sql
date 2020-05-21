--------------------------------------------------------
--  DDL for Package PAMONITOREO0002
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCACTUALIZADORVT"."PAMONITOREO0002" AS
    PROCEDURE spgettotpagerrorlog (
        pa_totalpaginas     OUT NUMBER,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    PROCEDURE spgeterrorlog (
        pa_numeropag        IN NUMBER,
        pa_datos            OUT scactualizadorvt.pautil.rcg_tipocursor,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

    PROCEDURE spupderrorlog (
        pa_erridrow         IN VARCHAR2,
        pa_codigo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_detallemensaje   OUT VARCHAR2
    );

END pamonitoreo0002;

/

  GRANT EXECUTE ON "SCACTUALIZADORVT"."PAMONITOREO0002" TO "USRACTVT";
