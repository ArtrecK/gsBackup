CREATE OR REPLACE PACKAGE BODY scsisges.test_pafichacteemp
IS
   /* generated by utPLSQL for SQL Developer on 2019-06-18 10:37:51 */
   --
   -- test spasesorcu case 1: ...
   --

   PROCEDURE inserta_datos_spasesorcu
   AS
   BEGIN
      --Se valida la informacion en la tabla scsisges.tafxcarterapf
      MERGE INTO scsisges.tafxcarterapf destino
           USING (SELECT 1                     fipais,
                         1                     ficanal,
                         2024                  fisucursal,
                         98765                 fifolio,
                         1                     fiidportafolio,
                         2024                  fiidsucursal,
                         0                     fnumempsol,
                         'ASIGNA_CTE_NUEVO'    fctipomov,
                         0                     fiempduenio,
                         NULL                  fnstatuscte,
                         345                   fiidrol,
                         23                    fiidpuesto,
                         260985                fiidempleado,
                         1745908               fiidposicion,
                         SYSDATE               fdmodificacion,
                         USER                  fcusrmodifico
                    FROM DUAL) origen
              ON (    destino.fipais = origen.fipais
                  AND destino.ficanal = origen.ficanal
                  AND destino.fisucursal = origen.fisucursal
                  AND destino.fifolio = origen.fifolio)
      WHEN NOT MATCHED
      THEN
         INSERT     (fipais,
                     ficanal,
                     fisucursal,
                     fifolio,
                     fiidportafolio,
                     fiidsucursal,
                     fnumempsol,
                     fctipomov,
                     fiempduenio,
                     fnstatuscte,
                     fiidrol,
                     fiidpuesto,
                     fiidempleado,
                     fiidposicion,
                     fdmodificacion,
                     fcusrmodifico)
             VALUES (origen.fipais,
                     origen.ficanal,
                     origen.fisucursal,
                     origen.fifolio,
                     origen.fiidportafolio,
                     origen.fiidsucursal,
                     origen.fnumempsol,
                     origen.fctipomov,
                     origen.fiempduenio,
                     origen.fnstatuscte,
                     origen.fiidrol,
                     origen.fiidpuesto,
                     origen.fiidempleado,
                     origen.fiidposicion,
                     origen.fdmodificacion,
                     origen.fcusrmodifico);

      --Se valida la informacion en la tabla scsisges.taempleadopf

      MERGE INTO scsisges.taempleadopf destino
           USING (SELECT 260985         fnempleado,
                         'ALDO OMAR'    fcnombre,
                         'FABA'         fcapaterno,
                         'RODRIGUEZ'    fcamaterno,
                         2609           fnfuncionsap,
                         708265         fnempleadojefe,
                         529660         fncc,
                         'EKT'          fcnegocio,
                         1              fiidlabora,
                         SYSDATE        fdultimamodificacion,
                         SYSDATE        fdbaja,
                         SYSDATE        fdalta,
                         1              fisituacion,
                         9660           fiidsucursal,
                         2              fiidperfil,
                         1              fnorigen,
                         USER           fcusrcreacion,
                         SYSDATE        fdcreacion,
                         USER           fcusrmodifico,
                         SYSDATE        fdmodifico
                    FROM DUAL) origen
              ON (    destino.fnempleado = origen.fnempleado
                  AND destino.fiidsucursal = origen.fiidsucursal)
      WHEN NOT MATCHED
      THEN
         INSERT     (fnempleado,
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
                     fdmodifico)
             VALUES (origen.fnempleado,
                     origen.fcnombre,
                     origen.fcapaterno,
                     origen.fcamaterno,
                     origen.fnfuncionsap,
                     origen.fnempleadojefe,
                     origen.fncc,
                     origen.fcnegocio,
                     origen.fiidlabora,
                     origen.fdultimamodificacion,
                     origen.fdbaja,
                     origen.fdalta,
                     origen.fisituacion,
                     origen.fiidsucursal,
                     origen.fiidperfil,
                     origen.fnorigen,
                     origen.fcusrcreacion,
                     origen.fdcreacion,
                     origen.fcusrmodifico,
                     origen.fdmodifico);
   END inserta_datos_spasesorcu;

   PROCEDURE consulta_asesorcu
   AS
      pa_cu           VARCHAR2 (200);
      pa_idempleado   NUMBER;
      pa_nombre       VARCHAR2 (200);
      pa_apellidop    VARCHAR2 (200);
      pa_apellidom    VARCHAR2 (200);
      pa_coderror     NUMBER;
      pa_deserror     VARCHAR2 (200);
   BEGIN
      pa_cu := '0101202498765'; --el numero de cu 0101202498765 es el que acaba de ser dado de alta con el store inserta_datos_spasesorcu
      -- se ejecuta el store
      pafichacteemp.spasesorcu (pa_cu           => pa_cu,
                                pa_idempleado   => pa_idempleado,
                                pa_nombre       => pa_nombre,
                                pa_apellidop    => pa_apellidop,
                                pa_apellidom    => pa_apellidom,
                                pa_coderror     => pa_coderror,
                                pa_deserror     => pa_deserror);

      DBMS_OUTPUT.put_line ('PA_IDEMPLEADO = ' || pa_idempleado);
      DBMS_OUTPUT.put_line ('PA_NOMBRE = ' || pa_nombre);
      DBMS_OUTPUT.put_line ('PA_APELLIDOP = ' || pa_apellidop);
      DBMS_OUTPUT.put_line ('PA_APELLIDOM = ' || pa_apellidom);
      ut.expect (pa_idempleado,
                 'Se espera que el campo idempleado contenga un valor').to_be_not_null ();
      ut.expect (pa_nombre,
                 'Se espera que el campo nombre contenga un valor').to_be_not_null ();
      ut.expect (pa_apellidop,
                 'Se espera que el campo apellidop contenga un valor').to_be_not_null ();
      ut.expect (pa_apellidom,
                 'Se espera que el campo apellidom contenga un valor').to_be_not_null ();
      ut.expect (pa_coderror, 'Código de salida es 0').to_ (equal (0));
      ut.expect (pa_deserror, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END consulta_asesorcu;

   PROCEDURE consulta_no_existentes
   AS
      pa_cu           VARCHAR2 (200);
      pa_idempleado   NUMBER;
      pa_nombre       VARCHAR2 (200);
      pa_apellidop    VARCHAR2 (200);
      pa_apellidom    VARCHAR2 (200);
      pa_coderror     NUMBER;
      pa_deserror     VARCHAR2 (200);
   BEGIN
      pa_cu := '0000202400000'; --el numero de cu 0000202400000 no existe en la tabla scsisges.tafxcarterapf
      -- se ejecuta el store
      pafichacteemp.spasesorcu (pa_cu           => pa_cu,
                                pa_idempleado   => pa_idempleado,
                                pa_nombre       => pa_nombre,
                                pa_apellidop    => pa_apellidop,
                                pa_apellidom    => pa_apellidom,
                                pa_coderror     => pa_coderror,
                                pa_deserror     => pa_deserror);

      DBMS_OUTPUT.put_line ('PA_IDEMPLEADO = ' || pa_idempleado);
      DBMS_OUTPUT.put_line ('PA_NOMBRE = ' || pa_nombre);
      DBMS_OUTPUT.put_line ('PA_APELLIDOP = ' || pa_apellidop);
      DBMS_OUTPUT.put_line ('PA_APELLIDOM = ' || pa_apellidom);
      ut.expect (pa_idempleado,
                 'Se espera que el campo idempleado contenga un valor').to_be_null ();
      ut.expect (pa_nombre,
                 'Se espera que el campo nombre contenga un valor').to_be_null ();
      ut.expect (pa_apellidop,
                 'Se espera que el campo apellidop contenga un valor').to_be_null ();
      ut.expect (pa_apellidom,
                 'Se espera que el campo apellidom contenga un valor').to_be_null ();
      ut.expect (pa_coderror, 'Código de salida es 1').to_ (equal (1));
      ut.expect (pa_deserror, 'Mensaje de salida no es igual OK').not_to (
         equal ('OK'));
   END consulta_no_existentes;

   PROCEDURE consulta_con_null
   AS
      pa_cu           VARCHAR2 (200);
      pa_idempleado   NUMBER;
      pa_nombre       VARCHAR2 (200);
      pa_apellidop    VARCHAR2 (200);
      pa_apellidom    VARCHAR2 (200);
      pa_coderror     NUMBER;
      pa_deserror     VARCHAR2 (200);
   BEGIN
      pa_cu := NULL;  --se envía como cu de parametro de entrada un valor null
      -- se ejecuta el store
      pafichacteemp.spasesorcu (pa_cu           => pa_cu,
                                pa_idempleado   => pa_idempleado,
                                pa_nombre       => pa_nombre,
                                pa_apellidop    => pa_apellidop,
                                pa_apellidom    => pa_apellidom,
                                pa_coderror     => pa_coderror,
                                pa_deserror     => pa_deserror);

      DBMS_OUTPUT.put_line ('PA_IDEMPLEADO = ' || pa_idempleado);
      DBMS_OUTPUT.put_line ('PA_NOMBRE = ' || pa_nombre);
      DBMS_OUTPUT.put_line ('PA_APELLIDOP = ' || pa_apellidop);
      DBMS_OUTPUT.put_line ('PA_APELLIDOM = ' || pa_apellidom);
      ut.expect (pa_idempleado,
                 'Se espera que el campo idempleado contenga un valor').to_be_null ();
      ut.expect (pa_nombre,
                 'Se espera que el campo nombre contenga un valor').to_be_null ();
      ut.expect (pa_apellidop,
                 'Se espera que el campo apellidop contenga un valor').to_be_null ();
      ut.expect (pa_apellidom,
                 'Se espera que el campo apellidom contenga un valor').to_be_null ();
      ut.expect (pa_coderror, 'Código de salida es 1').to_ (equal (1));
      ut.expect (
         pa_deserror,
         'Mensaje de salida no es igual OK ya que parametro de entrada fue un valor null').not_to (
         equal ('OK'));
   END consulta_con_null;
END test_pafichacteemp;
