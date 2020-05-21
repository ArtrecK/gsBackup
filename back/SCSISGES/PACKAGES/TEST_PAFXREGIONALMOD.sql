--------------------------------------------------------
--  DDL for Package TEST_PAFXREGIONALMOD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."TEST_PAFXREGIONALMOD" IS

   --%suite(test_pafxregionalmod)
   --%suitepath(alltests)
   
   --%test
   -- %displayname(Consulta de objetivos semanal exitosa)
   PROCEDURE spobjetivodiario_consulta;

   --%test
   -- %displayname(Consulta de un registro de la tabla no existente)
   PROCEDURE spobjetivodiario_consulta_DNE;

   --%test
   -- %displayname(Consulta de un registro de la tabla no existente ceco)
   PROCEDURE spobjetivodiario_consulta_ceco_no_existente;

   --%test
   -- %displayname(Consulta del ceco enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivodiario_consulta_ceco_null;

   --%test
   -- %displayname(Consulta de un registro enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivodiario_consulta_semana_null;

   --%test
   -- %displayname(Consulta de un registro enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivodiario_consulta_anio_null;

   --%test
   -- %displayname(Consulta de un registro enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivodiario_consulta_con_valores_diferentes;

   --%test
   -- %displayname(Consulta de objetivos semanal exitosa)
   PROCEDURE spobjetivosemanal_consulta;

   --%test
   -- %displayname(Consulta de un registro de la tabla no existente)
   PROCEDURE spobjetivosemanal_consulta_datos_no_existentes;

   --%test
   -- %displayname(Consulta de un registro de la tabla no existente ceco)
   PROCEDURE spobjetivosemanal_consulta_ceco_no_existente;

   --%test
   -- %displayname(Consulta del ceco enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivosemanal_consulta_ceco_null;

   --%test
   -- %displayname(Consulta de un registro enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivosemanal_consulta_semana_null;

   --%test
   -- %displayname(Consulta de un registro enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivosemanal_consulta_anio_null;

   --%test
   -- %displayname(Consulta de un registro enviando un nulo en el parámetro de entrada.)
   PROCEDURE spobjetivosemanal_consulta_con_valores_diferentes;

END test_pafxregionalmod;

/
