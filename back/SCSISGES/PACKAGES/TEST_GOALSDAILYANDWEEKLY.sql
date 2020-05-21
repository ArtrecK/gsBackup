--------------------------------------------------------
--  DDL for Package TEST_GOALSDAILYANDWEEKLY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."TEST_GOALSDAILYANDWEEKLY" IS

   --%suite(test_pafxregionalmod)
   --%suitepath(alltests)
   
   --%test
   -- %displayname(inserta datos en OBJETIVOS diarios)
   PROCEDURE spinsertA_TAOBJETIVOS;
   
   --%test
   -- %displayname(inserta datos en TCLINEA diarios)
   PROCEDURE  spinserta_TCLINEA;
   
   --%test
   -- %displayname(inserta datos en FXSUCURSAL diarios)
    PROCEDURE spinserta_SUCURSAL;
   
   --%test
   -- %displayname(Consulta de objetivos semanal exitosa)
   PROCEDURE spobjetivodiario_consulta;

   --%test
   -- %displayname(Consulta fecha invalida)
   PROCEDURE spobjetivodiario_CDFE;

   --%test
   -- %displayname(Consulta ceco no existente)
   PROCEDURE spobjetivodiario_CCNE;

   --%test
   -- %displayname(Consulta ceco null)
   PROCEDURE spobjetivodiario_CCN;

   --%test
   -- %displayname(Consulta fecha null)
   PROCEDURE spobjetivodiario_CFN;

   --%test
   -- %displayname(Consulta con valores diferentes)
   PROCEDURE spobjetivodiario_CCVD;
   
   --%test
   -- %displayname(Inserta datos en TCLINEAS objetivo semanal)
   PROCEDURE spinserta_TCLINEAOBJSEM;
   
   --%test
   -- %displayname(Inserta datos en TCSUCURSAL objetivo semanal)
   PROCEDURE spinserta_sucursalobjsem;
   
   --%test
   -- %displayname(Inserta datos en TAOBJETIVOS semanal)
   PROCEDURE spinserta_OBJETIVOSSEM;
   
   --%test
   -- %displayname(Inserta datos en TCPERFILESEMP)
   PROCEDURE spinserta_PERFILES;
   
   --%test
   -- %displayname(Inserta datos en TAEMPLEADOPF)
   PROCEDURE spinserta_TAEMPLEADOPF;
     
   --%test
   -- %displayname(Consulta de objetivos semanal exitosa)
   PROCEDURE spobjetivosemanal_consulta;

   --%test
   -- %displayname(Consulta datos no existentes)
   PROCEDURE spobjetivosemanal_CDNE;

   --%test
   -- %displayname(Consulta ceco no existente)
   PROCEDURE spobjetivosemanal_CCNE;

   --%test
   -- %displayname(Consulta ceco null)
   PROCEDURE spobjetivosemanal_CCN;

   --%test
   -- %displayname(Consulta semana null)
   PROCEDURE spobjetivosemanal_CSN;

   --%test
   -- %displayname(Consulta anio null)
   PROCEDURE spobjetivosemanal_CAN;

   --%test
   -- %displayname(Consulta con valores diferentes)
   PROCEDURE spobjetivosemanal_CCVD;

END test_goalsdailyandweekly;

/
