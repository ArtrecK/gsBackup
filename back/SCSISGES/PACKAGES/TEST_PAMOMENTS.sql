--------------------------------------------------------
--  DDL for Package TEST_PAMOMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."TEST_PAMOMENTS" as

  -- %suite
  -- %displayname(Validación Consulta de Momentos)

  -- %beforeall
  procedure inserta_momentos;

  -- %test
  -- %displayname(Consulta de momentos exitosa)
  procedure consulta_momentos;

  -- %test
  -- %displayname(Consulta de un registro de la tabla momentos no existente)
  procedure consulta_no_existentes;

  -- %test
  -- %displayname(Consulta de un registro enviando nulo en el parámetro de entrada.)
  procedure consulta_con_null;

end;

/
