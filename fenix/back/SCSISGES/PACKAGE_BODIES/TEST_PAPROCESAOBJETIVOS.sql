--------------------------------------------------------
--  DDL for Package Body TEST_PAPROCESAOBJETIVOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."TEST_PAPROCESAOBJETIVOS" IS

 /* generated by utPLSQL for SQL Developer on 2019-05-13 16:24:00 */

   --
   -- test spinsjerarquia case 1: ...
   --
   PROCEDURE spinsjerarquia IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsjerarquia;
      paprocesaobjetivos.spinsjerarquia(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);

      -- populate expected
      -- ...

      -- assert

   END spinsjerarquia;

   --
   -- test spinsobjetivossuc case 1: ...
   --
   PROCEDURE spinsobjetivossuc IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivossuc;
      paprocesaobjetivos.spinsobjetivossuc(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spinsobjetivossuc;

   --
   -- test spinsobjetivosreg case 1: ...
   --
   PROCEDURE spinsobjetivosreg IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivosreg;
      paprocesaobjetivos.spinsobjetivosreg(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spinsobjetivosreg;

   --
   -- test spinsobjetivoszon case 1: ...
   --
   PROCEDURE spinsobjetivoszon IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivoszon;
      paprocesaobjetivos.spinsobjetivoszon(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spinsobjetivoszon;

   --
   -- test spinsobjetivospais case 1: ...
   --
   PROCEDURE spinsobjetivospais IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivospais;
         paprocesaobjetivos.spinsobjetivospais(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spinsobjetivospais;

   --
   -- test spinsobjetivosemp case 1: ...
   --
   PROCEDURE spinsobjetivosemp IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivosemp;
      paprocesaobjetivos.spinsobjetivosemp(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spinsobjetivosemp;

   --
   -- test spprocesossem case 1: ...
   --
   PROCEDURE spprocesossem IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spprocesossem;
         paprocesaobjetivos.spprocesossem(pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spprocesossem;

   --
   -- test spinsobjetivoshist case 1: ...
   --
   PROCEDURE spinsobjetivoshist IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_semana   INTEGER := 15;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivoshist;
      paprocesaobjetivos.spinsobjetivoshist(   pa_semana  => pa_semana, 
                                               pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spinsobjetivoshist;

   --
   -- test spdelobjetivosemp case 1: ...
   --
   PROCEDURE spdelobjetivosemp IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_semana   INTEGER := 15;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spdelobjetivosemp;
      paprocesaobjetivos.spdelobjetivosemp(pa_semana  => pa_semana,
                                           pa_codigo  => pa_codigo, 
                                           pa_mensaje  => pa_mensaje);
      -- populate expected
      -- ...

      -- assert

   END spdelobjetivosemp;

   --
   -- test spinsobjetivosememp case 1: ...
   --
   PROCEDURE spinsobjetivosememp IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_semana INTEGER := 15;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spinsobjetivosememp;
       paprocesaobjetivos.spinsobjetivosememp (pa_semana  => pa_semana,
                                               pa_codigo  => pa_codigo, 
                                               pa_mensaje  => pa_mensaje);

      -- populate expected
      -- ...
       ut.expect(pa_codigo,'Código de salida es 200').to_equal(200);
       ut.expect(pa_mensaje,'Mensaje de salida es igual OK').to_equal('OK');

      -- assert
   END spinsobjetivosememp;

   --
   -- test spprocesosdia case 1: ...
   --
   PROCEDURE spprocesosdia IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 1;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
   BEGIN
      -- populate actual
      -- paprocesaobjetivos.spprocesosdia;
      paprocesaobjetivos.spprocesosdia(pa_codigo  => pa_codigo, 
                                       pa_mensaje  => pa_mensaje);

      -- populate expected
      -- ...
       ut.expect(pa_codigo,'Código de salida es 200').to_equal(200);
       ut.expect(pa_mensaje,'Mensaje de salida es igual OK').to_equal('OK');

      -- assert

   END spprocesosdia;

   --
   -- test spdelobjetivoshist case 1: ...
   --

  PROCEDURE spdelobjetivoshist IS
      l_actual   INTEGER := 0;
      l_expected INTEGER := 0;
      i_tablename  VARCHAR2(200) := 'THOBJETIVOEMP';
      anio INTEGER;
      pa_codigo     NUMBER;
      pa_mensaje    VARCHAR2(200);
 BEGIN
      -- populate actual
      -- paprocesaobjetivos.spdelobjetivoshist;
       paprocesaobjetivos.spdelobjetivoshist(pa_codigo  => pa_codigo, 
                                             pa_mensaje  => pa_mensaje);

       SELECT EXTRACT(YEAR FROM SYSDATE) INTO anio FROM DUAL;
       ut.expect(pa_codigo,'Código de salida es 200').to_equal(200);
       ut.expect(pa_mensaje,'Mensaje de salida es igual OK').to_equal('OK');

      -- populate expected
      -- ...
      execute immediate 'select count(*) from ('||i_tablename||') WHERE FNANIO = ('||anio||' - 2)  ' into l_expected;
      -- assert
      ut.expect(l_actual).to_equal(l_expected);
 END spdelobjetivoshist;

END test_paprocesaobjetivos;

/
