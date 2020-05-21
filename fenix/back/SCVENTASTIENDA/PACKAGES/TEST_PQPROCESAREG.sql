--------------------------------------------------------
--  DDL for Package TEST_PQPROCESAREG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."TEST_PQPROCESAREG" is

  -- Author  : CCAMPOS
  -- Created : 25/04/2019 11:22:29 a. m.
  -- Purpose : PRUEBAS UNITARIAS DEL PROCESAMIENTO DE REGISTROS DEL SENDER
  

   -- %suite

   -- %test
   -- %displayname(Inserta registros en TACLIENTES)
   PROCEDURE SPINSERTA_REG10;
    
   -- %test
   -- %displayname(Inserta registros en TAPEDIDOS)
   PROCEDURE SPINSERTA_REG100;
   
   -- %test
   -- %displayname(Inserta registros en TAMOVPEDIDOS)
   PROCEDURE SPINSERTA_REG120;
   
   -- %test
   -- %displayname(Inserta registros en TAPREPARAME)
   PROCEDURE SPINSERTA_REG50;
   
   -- %test
   -- %displayname(Inserta registros en CRECTEUNICPED) 
   PROCEDURE SPINSERTA_REG2320;
   

end TEST_PQPROCESAREG;

/
