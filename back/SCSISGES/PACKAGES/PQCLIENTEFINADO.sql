--------------------------------------------------------
--  DDL for Package PQCLIENTEFINADO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQCLIENTEFINADO" 
AS
   PROCEDURE SPICLIENTEFINADO (
      pa_fipais       IN     scsisges.taclientefinado.fipais%TYPE,
      pa_ficanal      IN     scsisges.taclientefinado.ficanal%TYPE,
      pa_fisucursal   IN     scsisges.taclientefinado.fisucursal%TYPE,
      pa_fifolio      IN     scsisges.taclientefinado.fifolio%TYPE,
      pa_fnempnum     IN     scsisges.taclientefinado.fnempnum%TYPE,
      pa_codigo          OUT INTEGER,
      pa_mensaje         OUT VARCHAR2);

   PROCEDURE SPDCLIENTEFINADO (
      pa_fipais       IN     scsisges.taclientefinado.fipais%TYPE,
      pa_ficanal      IN     scsisges.taclientefinado.ficanal%TYPE,
      pa_fisucursal   IN     scsisges.taclientefinado.fisucursal%TYPE,
      pa_fifolio      IN     scsisges.taclientefinado.fifolio%TYPE,
      pa_fnempnum     IN     scsisges.taclientefinado.fnempnum%TYPE,
      pa_codigo          OUT INTEGER,
      pa_mensaje         OUT VARCHAR2);

   PROCEDURE SPCCTESNOCONFIR (pa_datos     OUT scsisges.patypes.rcgcursor,
                              pa_codigo    OUT INTEGER,
                              pa_mensaje   OUT VARCHAR2);

   PROCEDURE SPUSTATUSCTEFINADO (
      pa_fnstatus       scsisges.taclientefinado.fnstatus%TYPE,
      pa_codigo     OUT INTEGER,
      pa_mensaje    OUT VARCHAR2);
END PQCLIENTEFINADO;

/

  GRANT EXECUTE ON "SCSISGES"."PQCLIENTEFINADO" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQCLIENTEFINADO" TO "USRSISGES";
