create or replace PACKAGE SCSISGES.TEST_PAGEOGRAFIA
AS
   -- %suite
   -- %displayname(Prepara datos de geografia)

   -- %beforeall
   PROCEDURE inserta_geografia;

   -- %test
   -- %displayname(Consulta geografia nivel sucursal)
   PROCEDURE consulta_sucursal;

   -- %test
   -- %displayname(Consulta geografia nivel region)
   PROCEDURE consulta_regional;

   -- %test
   -- %displayname(Consulta geografia nivel zona)
   PROCEDURE consulta_zonal;

   -- %test
   -- %displayname(Consulta geografia nivel territorio)
   PROCEDURE consulta_territorial;

   -- %test
   -- %displayname(Consulta geografia nivel pais)
   PROCEDURE consulta_nacional;

   -- %test
   -- %displayname(Consulta con parametros no existentes)
   PROCEDURE consulta_no_existentes;

   -- %test
   -- %displayname(Consulta de un registro enviando nulo en el parámetro de entrada.)
   PROCEDURE consulta_con_null;
END TEST_PAGEOGRAFIA;