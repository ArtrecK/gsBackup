--------------------------------------------------------
--  DDL for Package PQSBGESTION0002
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQSBGESTION0002" AS
    PROCEDURE spieventgest (
        pa_figestionid   IN scsisges.taeventgest.figestionid%TYPE,
        pa_fiusuarioid   IN scsisges.taeventgest.fiusuarioid%TYPE,
        pa_fieventoid    IN scsisges.taeventgest.fieventoid%TYPE,
        pa_ficliente     IN scsisges.taeventgest.ficliente%TYPE
    );

    PROCEDURE spcactividaddiaria (
        pa_fcempnum   IN scsisges.tagestion.fcempnum%TYPE,
        pa_datos      OUT scsisges.patypes.rcgcursor,
        pa_codigo     OUT INTEGER,
        pa_mensaje    OUT VARCHAR2
    );

    PROCEDURE SPACTIVIDADSEMANAL (
    PA_FCEMPNUM  IN SCSISGES.TAGESTION.FCEMPNUM%TYPE,
    PA_CURACTDIA OUT SCSISGES.PATYPES.RCGCURSOR,
    PA_CURACTSEM OUT SCSISGES.PATYPES.RCGCURSOR,
    PA_CODIGO    OUT INTEGER,
    PA_MENSAJE   OUT VARCHAR2
    );

END pqsbgestion0002;

/

  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0002" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0002" TO "USRVENTAST";
