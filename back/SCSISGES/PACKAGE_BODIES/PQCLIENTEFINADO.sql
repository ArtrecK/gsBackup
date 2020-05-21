--------------------------------------------------------
--  DDL for Package Body PQCLIENTEFINADO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQCLIENTEFINADO" 
AS
   csl_0              CONSTANT INTEGER := 0;
   csl_1              CONSTANT INTEGER := 1;
   csl_nodiasfinado   CONSTANT VARCHAR2 (15) := 'NO_DIAS_FINADO';
   vg_nodiasfinado             INTEGER := 180;

   PROCEDURE SPICLIENTEFINADO (
      pa_fipais       IN     scsisges.taclientefinado.fipais%TYPE,
      pa_ficanal      IN     scsisges.taclientefinado.ficanal%TYPE,
      pa_fisucursal   IN     scsisges.taclientefinado.fisucursal%TYPE,
      pa_fifolio      IN     scsisges.taclientefinado.fifolio%TYPE,
      pa_fnempnum     IN     scsisges.taclientefinado.fnempnum%TYPE,
      pa_codigo          OUT INTEGER,
      pa_mensaje         OUT VARCHAR2)
   AS
   BEGIN
      INSERT INTO SCSISGES.TACLIENTEFINADO (FIPAIS,
                                            FICANAL,
                                            FISUCURSAL,
                                            FIFOLIO,
                                            FNEMPNUM)
           VALUES (pa_fipais,
                   pa_ficanal,
                   pa_fisucursal,
                   pa_fifolio,
                   pa_fnempnum);

      COMMIT;
      pa_codigo := csl_0;
      pa_mensaje := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codigo := csl_1;
         pa_mensaje := 'FALLO AL REALIZAR EL GUARDADO DEL CLIENTE FINADO';
         scsisges.
          sperrores (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PQCLIENTEFINADO.SPICLIENTEFINADO');
   END SPICLIENTEFINADO;

   PROCEDURE SPDCLIENTEFINADO (
      pa_fipais       IN     scsisges.taclientefinado.fipais%TYPE,
      pa_ficanal      IN     scsisges.taclientefinado.ficanal%TYPE,
      pa_fisucursal   IN     scsisges.taclientefinado.fisucursal%TYPE,
      pa_fifolio      IN     scsisges.taclientefinado.fifolio%TYPE,
      pa_fnempnum     IN     scsisges.taclientefinado.fnempnum%TYPE,
      pa_codigo          OUT INTEGER,
      pa_mensaje         OUT VARCHAR2)
   AS
   BEGIN
      DELETE SCSISGES.TACLIENTEFINADO
       WHERE     FIPAIS = pa_fipais
             AND FICANAL = pa_ficanal
             AND FISUCURSAL = pa_fisucursal
             AND FIFOLIO = pa_fifolio
             AND FNEMPNUM = pa_fnempnum
             AND FNSTATUS = csl_0
             AND TRUNC (FDALTA) = TRUNC (SYSDATE);

      COMMIT;
      pa_codigo := csl_0;
      pa_mensaje := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         pa_codigo := csl_1;
         pa_mensaje := 'FALLO AL REALIZAR LA ELIMINACION DEL CLIENTE FINADO';
         scsisges.
          sperrores (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PQCLIENTEFINADO.SPDCLIENTEFINADO');
   END SPDCLIENTEFINADO;

   PROCEDURE SPCCTESNOCONFIR (pa_datos     OUT scsisges.patypes.rcgcursor,
                              pa_codigo    OUT INTEGER,
                              pa_mensaje   OUT VARCHAR2)
   AS
   BEGIN
      OPEN pa_datos FOR
           SELECT TCF.FIPAIS AS PAIS,
                  TCF.FICANAL AS CANAL,
                  TCF.FISUCURSAL AS SUCURSAL,
                  TCF.FIFOLIO AS FOLIO
             FROM    (SELECT FIPAIS,
                             FICANAL,
                             FISUCURSAL,
                             FIFOLIO
                        FROM SCSISGES.TACLIENTEFINADO
                       WHERE FNSTATUS = csl_0) TCF
                  INNER JOIN
                     (SELECT FIPAIS,
                             FICANAL,
                             FISUCURSAL,
                             FIFOLIO
                        FROM SCSISGES.TACLIENTEFINADO
                       WHERE TRUNC (FDALTA) <=
                                TRUNC (SYSDATE - vg_nodiasfinado)) TCFAUX
                  ON     TCF.FIPAIS = TCFAUX.FIPAIS
                     AND TCF.FICANAL = TCFAUX.FICANAL
                     AND TCF.FISUCURSAL = TCFAUX.FISUCURSAL
                     AND TCF.FIFOLIO = TCFAUX.FIFOLIO
         GROUP BY TCF.FIPAIS,
                  TCF.FICANAL,
                  TCF.FISUCURSAL,
                  TCF.FIFOLIO;

      pa_codigo := csl_0;
      pa_mensaje := 'CONSULTA REALIZADA CORRECTAMENTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN pa_datos FOR
            SELECT NULL FIPAIS,
                   NULL FICANAL,
                   NULL FISUCURSAL,
                   NULL FIFOLIO
              FROM DUAL;

         pa_codigo := csl_1;
         pa_mensaje := 'FALLO AL REALIZAR LA CONSULTA DE CLIENTES FINADOS';
         scsisges.
          sperrores (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PQCLIENTEFINADO.SPCCTESNOCONFIR');
   END SPCCTESNOCONFIR;

   PROCEDURE SPUSTATUSCTEFINADO (
      pa_fnstatus       scsisges.taclientefinado.fnstatus%TYPE,
      pa_codigo     OUT INTEGER,
      pa_mensaje    OUT VARCHAR2)
   AS
   BEGIN
      UPDATE SCSISGES.TACLIENTEFINADO TCF
         SET FNSTATUS = pa_fnstatus
       WHERE FNSTATUS = csl_0
             AND TRUNC (FDALTA) <= TRUNC (SYSDATE - vg_nodiasfinado);

      pa_codigo := csl_0;
      pa_mensaje := 'ACTUALIZACION REALIZADA CORRECTAMENTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         pa_codigo := csl_1;
         pa_mensaje :=
            'FALLO AL REALIZAR LA ACTUALIZACION DE CLIENTES FINADOS';
         scsisges.
          sperrores (
            SYSDATE,
            SQLCODE,
            SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
            'SCSISGES.PQCLIENTEFINADO.SPUSTATUSCTEFINADO');
   END SPUSTATUSCTEFINADO;
END PQCLIENTEFINADO;

/

  GRANT EXECUTE ON "SCSISGES"."PQCLIENTEFINADO" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQCLIENTEFINADO" TO "USRSISGES";
