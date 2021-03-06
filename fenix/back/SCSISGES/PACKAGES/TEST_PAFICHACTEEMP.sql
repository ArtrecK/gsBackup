CREATE OR REPLACE PACKAGE SCSISGES.test_pafichacteemp
AS
   /* generated by utPLSQL for SQL Developer on 2019-06-18 10:37:51 */


   --%suite(test_pafichacteemp)
   --%suitepath(alltests)

   -- %beforeall
   PROCEDURE inserta_datos_spasesorcu;

   -- %test
   -- %displayname(Consulta asesor existente para un cu determinado)
   PROCEDURE consulta_asesorcu;

   -- %test
   -- %displayname(Consulta asesor no existente para un cu determinado)
   PROCEDURE consulta_no_existentes;

   -- %test
   -- %displayname(Consulta de un registro enviando nulo en el parámetro de entrada.)
   PROCEDURE consulta_con_null;
END test_pafichacteemp;
