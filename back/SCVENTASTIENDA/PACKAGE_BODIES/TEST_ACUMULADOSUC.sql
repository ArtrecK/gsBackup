--------------------------------------------------------
--  DDL for Package Body TEST_ACUMULADOSUC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCVENTASTIENDA"."TEST_ACUMULADOSUC" as

PROCEDURE spacumsuc_insertaEmpleado is 
   conteoreg number;
       
     BEGIN
     DELETE FROM SCSISGES.TAEMPLEADOPF T WHERE TRUNC(T.FDULTIMAMODIFICACION)='25/03/2019';
     
     insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(999121,
                             'MIGUEL DE JESUS',
                             'ANGEL',
                             'LOPEZ',
                             8035,
                             677095,
                             529796,
                             'EKT',
                             1,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             9796,
                             3,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');
                             
    insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(959496,
                             'LUIS FERNANDO',
                             'SAGASTE',
                             'ESPINOZA',
                             8067,
                             826117,
                             524182,
                             'EKT',
                             1,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             4182,
                             1,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');
        insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(977492,
                             'DOROTEA',
                             'RAMOS',
                             'SALDAÑA',
                             8067,
                             876531,
                             522649,
                             'EKT',
                             2,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             2649,
                             1,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');
                             
       insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(973425,
                             'NICANOR',
                             'HERNANDEZ',
                             'CARBALLIDO',
                             8067,
                             876786,
                             529702,
                             'EKT',
                             1,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             9702,
                             1,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');                                                                                          
    
   SELECT COUNT (1)
           INTO conteoreg
           FROM SCSISGES.TAEMPLEADOPF
          WHERE TRUNC (fdultimamodificacion) = '25/03/2019';

                ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
     END spacumsuc_insertaEmpleado;  
     
     
   PROCEDURE spacumsuc_insertaTcsucursal is     
   conteoreg number;
       
     BEGIN
     DELETE FROM SCVENTASTIENDA.TCSUCURSAL T WHERE TRUNC(fdcreacion)='25/03/2019';
     
     INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1575,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA'); 
                                            
     INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1753,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA');
                                            
      INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1892,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA');
                                            
      INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1915,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA');                                                                                                                         
 
   SELECT COUNT (1)
        INTO conteoreg
        FROM SCVENTASTIENDA.TCSUCURSAL
       WHERE TRUNC (fdcreacion) = '25/03/2019';

             ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spacumsuc_insertaTcsucursal;   
   
   PROCEDURE spacumsuc_spinsertaDetped is 
     conteoreg number;
       
     BEGIN
     DELETE FROM SCVENTASTIENDA.TADETPEDIDOS T WHERE TRUNC(fdcreacion)='25/03/2019';     
  
   INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675381,
                                             530218,
                                             1,
                                             208.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             125.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             45.93,
                                             0.00,
                                             333.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA');
                                             
     INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675382,
                                             530228,
                                             1,
                                             208.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             115.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             45.93,
                                             0.00,
                                             332.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA'); 
                                             
     INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675382,
                                             530218,
                                             1,
                                             298.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             115.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             65.93,
                                             0.00,
                                             222.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA');    
                                             
     INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675382,
                                             534746,
                                             1,
                                             398.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             105.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             65.93,
                                             0.00,
                                             332.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA');                                                                                                                   

     SELECT COUNT (1)
        INTO conteoreg
        FROM SCVENTASTIENDA.TADETPEDIDOS
       WHERE TRUNC (fdcreacion) = '25/03/2019';

             ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spacumsuc_spinsertaDetped;
   
   PROCEDURE spacumsuc_spinsertaPedidos IS
     conteoreg NUMBER;
     
     BEGIN
       DELETE FROM SCVENTASTIENDA.TAPEDIDOS T WHERE TRUNC(T.FDCREACION)='25/03/2019';
       
             INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3675281,
                                              1,
                                              2024,
                                              374863,
                                              4,
                                              '997980',
                                              '341203',
                                              2,
                                              '25/03/2019',
                                              2560.00,
                                              1,
                                              '25/03/2019',
                                              2560.00,
                                              0.00,
                                              991354,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda');
                                              
       INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3675288,
                                              1,
                                              2024,
                                              194157,
                                              9,
                                              '296268',
                                              '296268',
                                              2,
                                              '25/03/2019',
                                              664.00,
                                              1,
                                              '25/03/2019',
                                              574.00,
                                              0.00,
                                              991361,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda');
                                              
     INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3675293,
                                              1,
                                              2024,
                                              388641,
                                              3,
                                              '296268',
                                              '296268',
                                              1,
                                              '25/03/2019',
                                              10784.00,
                                              1,
                                              '25/03/2019',
                                              10784.00,
                                              0.00,
                                              991361,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda'); 
                                              
      INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3875302,
                                              1,
                                              2024,
                                              100000,
                                              3,
                                              '296268',
                                              '296268',
                                              4,
                                              '25/03/2019',
                                              10784.00,
                                              1,
                                              '25/03/2019',
                                              10784.00,
                                              0.00,
                                              991361,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda');                                                                                                                       
    
   
   SELECT COUNT (1)
        INTO conteoreg
        FROM SCVENTASTIENDA.TAPEDIDOS
       WHERE TRUNC (fdcreacion) = '25/03/2019';

             ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spacumsuc_spinsertaPedidos;  
   
   procedure spacumsuc_spinsertaTclinea is
     conteoreg NUMBER;
     
   BEGIN
    DELETE FROM SCVENTASTIENDA.TCLINEA T WHERE TRUNC(T.FDCREACION)='25/03/2019'; 
      INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(400,
                                          'COMPUTO',
                                          13,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS');
                                    
     INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(530,
                                          'ACCESORIOS',
                                          31,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS');
                                    
      INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(100,
                                          'ELECTRONICA',
                                          10,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS');
                                    
      INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(200,
                                          'LINEA BLANCA',
                                          11,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS'); 
       
    SELECT COUNT(1)
       INTO conteoreg
       FROM SCVENTASTIENDA.TCLINEA T
      WHERE T.FDCREACION='25/03/2019';   
            ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spacumsuc_spinsertaTclinea; 
   
   PROCEDURE spacumsuc_spinsertaTcproducto IS
     conteoreg NUMBER;
     
     BEGIN
       DELETE FROM SCVENTASTIENDA.TCPRODUCTO T WHERE TRUNC(T.FDCREACION)='25/03/2019'; 
            INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000049,
                                                   'TV SONY VEGA KU-29FV10 29..',
                                                   10,
                                                   'Electrónica',
                                                   1010,
                                                   'Televisiones',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   101,
                                                   'TELEVISIONES',
                                                   6497.00,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');
                                                   
       INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000050,
                                                   'LG COMBO DC-596 M..',
                                                   10,
                                                   'Electrónica',
                                                   1013,
                                                   'Video',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   104,
                                                   'VIDEO',
                                                   1079.00,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');   
                                                   
       INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000051,
                                                   'TV TOSAKI 14CRT-08 14..',
                                                   10,
                                                   'Electrónica',
                                                   1010,
                                                   'Video',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   104,
                                                   'VIDEO',
                                                   682.00,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');
                                                   
       INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000052,
                                                   'TV.SONY KV-25FS120,.',
                                                   10,
                                                   'Electrónica',
                                                   1010,
                                                   'Video',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   101,
                                                   'VIDEO',
                                                   2050.20,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');                                                                                                                                   
                                                   
   SELECT COUNT(1)
     into conteoreg
     FROM SCVENTASTIENDA.TCPRODUCTO T
    WHERE TRUNC(T.FDCREACION)='25/03/2019';
    
          ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spacumsuc_spinsertaTcproducto;                              
                                           
 PROCEDURE spacumuladosuc_consulta IS                                                                           
  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      
  begin
  pa_fiidsucursal := 5458;   
  pa_fecha :='20190313';
  pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);
  open pa_curdatos for select * from dual connect by level <=10;
  ut.expect( pa_curdatos,'Se espera que el cursor devuelva 1 o más reg' ).to_have_count(10);
  ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
  ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
        
  end;  
  
   PROCEDURE spacumuladosuc_CTN IS                                                                           

  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      

begin
 pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);
  open pa_curdatos for select * from dual where 1 = 0;
  ut.expect( pa_curdatos,'Se espera que el cursor devuelva 0 reg' ).to_( be_empty() );
  ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
  ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
end;

    PROCEDURE spacumuladosuc_CDFE IS                                                                           

  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      

begin
  pa_fiidsucursal := 5458;   
  pa_fecha :='30190325';
 pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);

      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_not_null();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 2.2: ...
   --
   PROCEDURE spacumuladosuc_CSNE IS                                                                           

  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      

begin
  pa_fiidsucursal := 864213;   
  pa_fecha :='20190313';
 pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);

      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_empty();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.1: ...
   --
   PROCEDURE spacumuladosuc_CSN IS
  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      

begin
  pa_fiidsucursal := NULL;   
  pa_fecha :='20190313';
 pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);

      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_empty();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.2: ...
   --
   PROCEDURE spacumuladosuc_CFN IS
  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      

begin
  pa_fiidsucursal := 5458;   
  pa_fecha := NULL;
 pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);

      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_not_null();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 4: ...
   --
   PROCEDURE spacumuladosuc_CCVD IS
  pa_fiidsucursal number;
  pa_fecha  integer;
  pa_curdatos sys_refcursor;
  pa_fncoderror integer;
  pa_fcdeserror VARCHAR2(200);
      

begin
  pa_fiidsucursal := 5458;   
  pa_fecha :='Hola';
 pafxobjetivosreg.spacumuladosuc(pa_fiidsucursal => pa_fiidsucursal,
                                  pa_fecha => pa_fecha,
                                  pa_curdatos => pa_curdatos,
                                  pa_fncoderror => pa_fncoderror,
                                  pa_fcdeserror => pa_fcdeserror);

      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_empty();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_not_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_not_null();
   END;
   
--------------------------------------------------------------------------------
PROCEDURE spobjsem_insertaEmpleado is 
   conteoreg number;
       
     BEGIN
     DELETE FROM SCSISGES.TAEMPLEADOPF T WHERE TRUNC(T.FDULTIMAMODIFICACION)='25/03/2019';
     
     insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(999321,
                             'MIGUEL ',
                             'ANGEL',
                             'LOPEZ',
                             8035,
                             677095,
                             529796,
                             'EKT',
                             1,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             9796,
                             3,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');
                             
    insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(951496,
                             'JOSE',
                             'SAGASTE',
                             'ESPINOZA',
                             8067,
                             826117,
                             524182,
                             'EKT',
                             1,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             4182,
                             1,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');
        insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(979492,
                             'DORA',
                             'RAMOS',
                             'SALDAÑA',
                             8067,
                             876531,
                             522649,
                             'EKT',
                             2,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             2649,
                             1,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');
                             
       insert into SCSISGES.TAEMPLEADOPF(fnempleado,
                              fcnombre,
                              fcapaterno,
                              fcamaterno,
                              fnfuncionsap,
                              fnempleadojefe,
                              fncc,
                              fcnegocio,
                              fiidlabora,
                              fdultimamodificacion,
                              fdbaja,
                              fdalta,
                              fisituacion,
                              fiidsucursal,
                              fiidperfil,
                              fnorigen,
                              fcusrcreacion,
                              fdcreacion,
                              fcusrmodifico,
                              fdmodifico
                              )
                      VALUES(993425,
                             'LUPITA',
                             'HERNANDEZ',
                             'CARBALLIDO',
                             8067,
                             876786,
                             529702,
                             'EKT',
                             1,
                             '25/03/2019',
                             '01/01/1901',
                             '04/04/2018',
                             1,
                             9702,
                             1,
                             1,
                             'SCSISGES',
                             '25/03/2019',
                             'SCSISGES',
                             '25/03/2019');                                                                                          
    
   SELECT COUNT (1)
           INTO conteoreg
           FROM SCSISGES.TAEMPLEADOPF
          WHERE TRUNC (fdultimamodificacion) = '25/03/2019';

                ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
     END spobjsem_insertaEmpleado;  
     
     
   PROCEDURE spobjsem_insertaTcsucursal is     
   conteoreg number;
       
     BEGIN
     DELETE FROM SCVENTASTIENDA.TCSUCURSAL T WHERE TRUNC(fdcreacion)='25/03/2019';
     
     INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1575,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA'); 
                                            
     INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1753,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA');
                                            
      INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1892,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA');
                                            
      INSERT INTO SCVENTASTIENDA.TCSUCURSAL (fidsucursal,
                                            fcnombresucursal,
                                            fniva,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico)
                                     VALUES(1915,
                                            NULL,
                                            0.16,
                                            '25/03/2019',
                                            '25/03/2019',
                                            'SCVENTASTIENDA');                                                                                                                         
 
   SELECT COUNT (1)
        INTO conteoreg
        FROM SCVENTASTIENDA.TCSUCURSAL
       WHERE TRUNC (fdcreacion) = '25/03/2019';

             ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spobjsem_insertaTcsucursal;   
   
   PROCEDURE spobjsem_spinsertaDetped is 
     conteoreg number;
       
     BEGIN
     DELETE FROM SCVENTASTIENDA.TADETPEDIDOS T WHERE TRUNC(fdcreacion)='25/03/2019';     
  
   INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675381,
                                             530218,
                                             1,
                                             208.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             125.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             45.93,
                                             0.00,
                                             333.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA');
                                             
     INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675382,
                                             530228,
                                             1,
                                             208.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             115.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             45.93,
                                             0.00,
                                             332.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA'); 
                                             
     INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675382,
                                             530218,
                                             1,
                                             298.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             115.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             65.93,
                                             0.00,
                                             222.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA');    
                                             
     INSERT INTO SCVENTASTIENDA.TADETPEDIDOS (fipais,
                                              ficanal,
                                              fisucursal,
                                              finopedido,
                                              fiprodid,
                                              ficantart,
                                              fnprcunit,
                                              fnpdctodescto,
                                              fnproddesctoe,
                                              fipdctostatus,
                                              fncomisiong,
                                              fncomisionv,
                                              fnimpsobrep,
                                              fncostopdcto,
                                              fnporcenganche,
                                              fnintereses,
                                              fnporciva,
                                              fndesctomkt,
                                              fnprecioventa,
                                              ficveprom,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                      VALUES(1,
                                             1,
                                             2024,
                                             1675382,
                                             534746,
                                             1,
                                             398.00,
                                             0.00,
                                             0.00,
                                             NULL,
                                             0.00,
                                             0.00,
                                             105.0000,
                                             0.00,
                                             1.00,
                                             0.00,
                                             65.93,
                                             0.00,
                                             332.00,
                                             348888,
                                             '25/03/2019',
                                             '25/03/2019',
                                             'SCVENTASTIENDA');                                                                                                                   

     SELECT COUNT (1)
        INTO conteoreg
        FROM SCVENTASTIENDA.TADETPEDIDOS
       WHERE TRUNC (fdcreacion) = '25/03/2019';

             ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spobjsem_spinsertaDetped;
   
   PROCEDURE spobjsem_spinsertaPedidos IS
     conteoreg NUMBER;
     
     BEGIN
       DELETE FROM SCVENTASTIENDA.TAPEDIDOS T WHERE TRUNC(T.FDCREACION)='25/03/2019';
       
             INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3675281,
                                              1,
                                              2024,
                                              374863,
                                              4,
                                              '997980',
                                              '341203',
                                              2,
                                              '25/03/2019',
                                              2560.00,
                                              1,
                                              '25/03/2019',
                                              2560.00,
                                              0.00,
                                              991354,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda');
                                              
       INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3675288,
                                              1,
                                              2024,
                                              194157,
                                              9,
                                              '296268',
                                              '296268',
                                              2,
                                              '25/03/2019',
                                              664.00,
                                              1,
                                              '25/03/2019',
                                              574.00,
                                              0.00,
                                              991361,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda');
                                              
     INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3675293,
                                              1,
                                              2024,
                                              388641,
                                              3,
                                              '296268',
                                              '296268',
                                              1,
                                              '25/03/2019',
                                              10784.00,
                                              1,
                                              '25/03/2019',
                                              10784.00,
                                              0.00,
                                              991361,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda'); 
                                              
      INSERT INTO SCVENTASTIENDA.TAPEDIDOS(fipais,
                                                  ficanal,
                                                  fisucursal,
                                                  finopedido,
                                                  fingcioid,
                                                  finotienda,
                                                  ficteid,
                                                  fidigitover,
                                                  fcempnoventa,
                                                  fcempnosurte,
                                                  fitipoventa,
                                                  fdpedfec,
                                                  fnpedtotal,
                                                  fipedstat,
                                                  fdfecsurt,
                                                  fnpedsaldo,
                                                  fnenganche,
                                                  fifolioparam,
                                                  fipedfact,
                                                  fdfecimpfactura,
                                                  fdfechaarribo,
                                                  fdcreacion,
                                                  fdmodifico,
                                                  fcusrmodifico)
                                       VALUES(1,
                                              1,
                                              2024,
                                              3875302,
                                              1,
                                              2024,
                                              100000,
                                              3,
                                              '296268',
                                              '296268',
                                              4,
                                              '25/03/2019',
                                              10784.00,
                                              1,
                                              '25/03/2019',
                                              10784.00,
                                              0.00,
                                              991361,
                                              0,
                                              '01/01/2001',
                                              '25/03/2019',
                                              '25/03/2019',
                                              '25/03/2019',
                                              'scventastienda');                                                                                                                       
    
   
   SELECT COUNT (1)
        INTO conteoreg
        FROM SCVENTASTIENDA.TAPEDIDOS
       WHERE TRUNC (fdcreacion) = '25/03/2019';

             ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spobjsem_spinsertaPedidos;  
   
   procedure spobjsem_spinsertaTclinea is
     conteoreg NUMBER;
     
   BEGIN
    DELETE FROM SCVENTASTIENDA.TCLINEA T WHERE TRUNC(T.FDCREACION)='25/03/2019'; 
      INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(400,
                                          'COMPUTO',
                                          13,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS');
                                    
     INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(530,
                                          'ACCESORIOS',
                                          31,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS');
                                    
      INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(100,
                                          'ELECTRONICA',
                                          10,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS');
                                    
      INSERT INTO SCVENTASTIENDA.TCLINEA (fnlinea,
                                          fcprdlindesc,
                                          fnlineaprod,
                                          fdcreacion,
                                          fdmodifico,
                                          fcusrmodifico)
                                   VALUES(200,
                                          'LINEA BLANCA',
                                          11,
                                          '25/03/2019',
                                          sysdate,
                                          'USERS'); 
       
    SELECT COUNT(1)
       INTO conteoreg
       FROM SCVENTASTIENDA.TCLINEA T
      WHERE T.FDCREACION='25/03/2019';   
            ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spobjsem_spinsertaTclinea; 
   
   PROCEDURE spobjsem_spinsertaTcproducto IS
     conteoreg NUMBER;
     
     BEGIN
       DELETE FROM SCVENTASTIENDA.TCPRODUCTO T WHERE TRUNC(T.FDCREACION)='25/03/2019'; 
            INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000049,
                                                   'TV SONY VEGA KU-29FV10 29..',
                                                   10,
                                                   'Electrónica',
                                                   1010,
                                                   'Televisiones',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   101,
                                                   'TELEVISIONES',
                                                   6497.00,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');
                                                   
       INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000050,
                                                   'LG COMBO DC-596 M..',
                                                   10,
                                                   'Electrónica',
                                                   1013,
                                                   'Video',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   104,
                                                   'VIDEO',
                                                   1079.00,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');   
                                                   
       INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000051,
                                                   'TV TOSAKI 14CRT-08 14..',
                                                   10,
                                                   'Electrónica',
                                                   1010,
                                                   'Video',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   104,
                                                   'VIDEO',
                                                   682.00,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');
                                                   
       INSERT INTO SCVENTASTIENDA.TCPRODUCTO(FNSKU, 
                                                  FCDESCSKU, 
                                                  FNLINEASAP, 
                                                  FCDESCLINEASAP, 
                                                  FNSUBLINEASAP, 
                                                  FCDESCSUBLINEASAP, 
                                                  FNLINEASIE, 
                                                  FCDESCLINEASIE, 
                                                  FNSUBLINEASIE, 
                                                  FCDESCSUBLINEASIE, 
                                                  FNPRECIO, 
                                                  FDCREACION, 
                                                  FDMODIFICO, 
                                                  FCUSRMODIFICO) 
                                            VALUES(100000052,
                                                   'TV.SONY KV-25FS120,.',
                                                   10,
                                                   'Electrónica',
                                                   1010,
                                                   'Video',
                                                   100,
                                                   'ELECTRÓNICA',
                                                   101,
                                                   'VIDEO',
                                                   2050.20,
                                                   '25/03/2019',
                                                   '25/03/2019',
                                                   'SCVENTASTIENDA');                                                                                                                                   
                                                   
   SELECT COUNT(1)
     into conteoreg
     FROM SCVENTASTIENDA.TCPRODUCTO T
    WHERE TRUNC(T.FDCREACION)='25/03/2019';
    
          ut.expect (conteoreg, 'El numero de registros es igual a 0').to_(be_greater_than (0));                         
   end spobjsem_spinsertaTcproducto;
   
PROCEDURE spobjtvossemanales_consulta IS 
  

PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);
                              
  BEGIN                            
  
  pa_fiidsucursal := 5458;   
  pa_fisemana :=11;
  pa_fianio :=2019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
  open pa_curdatos for select * from dual connect by level <=10;
  ut.expect( pa_curdatos,'Se espera que el cursor devuelva 1 o más reg' ).to_have_count(10);
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   
  END;
 

procedure  spobjtvossemanales_CTN is 
 

PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
                                      
      
  ut.expect(pa_curdatos,'Se espera que el cursor devuelva 0 reg').to_have_count(0); 
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
        
        end;

   --
   -- test spobjetivosemanal case 2.2: ...
   --
   PROCEDURE spobjtvossemanales_CSNE IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := 1345682;   
  pa_fisemana :=11;
  pa_fianio :=2019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- populate actual
      -- pafxregionalmod.spobjetivosemanal;

      -- populate expected
      -- ...

      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_empty();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.1: ...
   --
   PROCEDURE spobjtvossemanales_CSEMNE IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := 5458;   
  pa_fisemana :=289;
  pa_fianio :=2019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_empty();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.2: ...
   --
   PROCEDURE spobjtvossemanales_CANE IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := 5458;   
  pa_fisemana :=11;
  pa_fianio :=3019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_not_null();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.3: ...
   --
   PROCEDURE spobjtvossemanales_CSN IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := NULL;   
  pa_fisemana :=11;
  pa_fianio :=2019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_not_null();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.3: ...
   --
   PROCEDURE spobjtvossemanales_CSEMN IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := 5458;   
  pa_fisemana :=NULL;
  pa_fianio :=2019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_not_null();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 3.3: ...
   --
   PROCEDURE spobjtvossemanales_CAN IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := 5458;   
  pa_fisemana :=11;
  pa_fianio :=NULL;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_not_null();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_null();
   END;

   --
   -- test spobjetivosemanal case 4: ...
   --
   PROCEDURE spobjtvossemanales_CCVD IS
PA_FIIDSUCURSAL  NUMBER;
PA_FISEMANA  NUMBER;
PA_FIANIO  NUMBER;
PA_CURDATOS SYS_REFCURSOR;
PA_FNCODERROR   INTEGER;
PA_FCDESERROR  VARCHAR2(200);

begin
  

  pa_fiidsucursal := 'Hola';   
  pa_fisemana :=11;
  pa_fianio :=2019;
  pafxobjetivosreg.spobjtvossemanales(pa_fiidsucursal => pa_fiidsucursal,
                                      pa_fisemana => pa_fisemana,
                                      pa_fianio => pa_fianio,
                                      pa_curdatos => pa_curdatos,
                                      pa_fncoderror => pa_fncoderror,
                                      pa_fcdeserror => pa_fcdeserror);
      -- assert
   ut.expect(PA_CURDATOS,'El cursor esta vacio').to_be_empty();
   ut.expect(PA_FNCODERROR,'El codigo de error no es null').to_be_not_null();
   ut.expect(PA_FCDESERROR,'El mensaje de error no es null').to_be_not_null();
   END;
end;

/
