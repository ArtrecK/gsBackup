--------------------------------------------------------
--  DDL for Package TEST_ACUMULADOSUC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."TEST_ACUMULADOSUC" is

   -- %suite

   -- %test
   -- %displayname(Inserta registros en TAEMPLEADO)
   PROCEDURE spacumsuc_insertaEmpleado;
   
   -- %test
   -- %displayname(Inserta registros en TCSUCURSAL)
   PROCEDURE spacumsuc_insertaTcsucursal;
   
   -- %test
   -- %displayname(Inserta registros en DETPEDIDOS)
   PROCEDURE spacumsuc_spinsertaDetped;
   
   -- %test
   -- %displayname(Inserta registros en TAPEDIDOS)
   PROCEDURE spacumsuc_spinsertaPedidos;
   
   -- %test
   -- %displayname(Inserta registros en TCLINEA)
   PROCEDURE spacumsuc_spinsertaTclinea;
   
   -- %test
   -- %displayname(Inserta registros en TCPRODUCTO)
   PROCEDURE spacumsuc_spinsertaTcproducto;

   -- %test
   -- %displayname(Consulta si regresa registros)
   PROCEDURE spacumuladosuc_consulta;
   
   -- %test
   -- %displayname(Consulta todos en null)
   PROCEDURE spacumuladosuc_CTN; 
   
   -- %test
   -- %displayname(Consulta de fecha erronea)
   PROCEDURE spacumuladosuc_CDFE;
   
   -- %test
   -- %displayname(Consulta de sucursal erronea)
   PROCEDURE spacumuladosuc_CSNE;
   
   -- %test
   -- %displayname(Consulta de sucursal nula)
   PROCEDURE spacumuladosuc_CSN;
   
   -- %test
   -- %displayname(Consulta de fecha nula)
   PROCEDURE spacumuladosuc_CFN;
   
   -- %test
   -- %displayname(Consulta con valores diferentes)
   PROCEDURE spacumuladosuc_CCVD;
   
   -- %test
   -- %displayname(Inserta registros de objsemanales en TAEMPLEADO)
   PROCEDURE spobjsem_insertaEmpleado;
   
   -- %test
   -- %displayname(Inserta de objsemanales registros en TCSUCURSAL)
   PROCEDURE spobjsem_insertaTcsucursal;
   
   -- %test
   -- %displayname(Inserta de objsemanales registros en DETPEDIDOS)
   PROCEDURE spobjsem_spinsertaDetped;
   
   -- %test
   -- %displayname(Inserta de objsemanales registros en TAPEDIDOS)
   PROCEDURE spobjsem_spinsertaPedidos;
   
   -- %test
   -- %displayname(Inserta de objsemanales registros en TCLINEA)
   PROCEDURE spobjsem_spinsertaTclinea;
   
   -- %test
   -- %displayname(Inserta de objsemanales registros en TCPRODUCTO)
   PROCEDURE spobjsem_spinsertaTcproducto;
   -- %test
   -- %displayname(Consulta si regresa registros mayores o igual a 1)
   PROCEDURE spobjtvossemanales_consulta ;
   
   -- %test
   -- %displayname(Consulta todos en null)
   procedure  spobjtvossemanales_CTN;
   
   -- %test
   -- %displayname(Consulta de sucursal erronea)
   PROCEDURE spobjtvossemanales_CSNE;
   
   -- %test
   -- %displayname(Consulta de semana erronea)
   PROCEDURE spobjtvossemanales_CSEMNE;
   
   -- %test
   -- %displayname(Consulta de anio erronea)
   PROCEDURE spobjtvossemanales_CANE;
   
   -- %test
   -- %displayname(Consulta de sucursal nula)
   PROCEDURE spobjtvossemanales_CSN;
   
   -- %test
   -- %displayname(Consulta de semana nula)
   PROCEDURE spobjtvossemanales_CSEMN;
   
   -- %test
   -- %displayname(Consulta de anio nula)
   PROCEDURE spobjtvossemanales_CAN;
   
   -- %test
   -- %displayname(Consulta con valores diferentes)
   PROCEDURE spobjtvossemanales_CCVD;

end test_acumuladosuc;

/
