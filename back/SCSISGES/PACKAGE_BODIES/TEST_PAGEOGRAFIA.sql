/* Formatted on 22/05/2019 06:54:20 p. m. (QP5 v5.336) */
CREATE OR REPLACE PACKAGE BODY SCSISGES.TEST_PAGEOGRAFIA
AS
   VG_FIIDPERFIL         INTEGER;
   VG_FIIDPAIS           INTEGER;
   VG_FCDESCPAIS         VARCHAR2 (31000);
   VG_FIIDTERRITORIO     INTEGER;
   VG_FCDESCTERRIRORIO   VARCHAR2 (31000);
   VG_FIIDZONA           INTEGER;
   VG_FCDESCZONAS        VARCHAR2 (31000);
   VG_FIIDREGION         INTEGER;
   VG_FCDESCREGION       VARCHAR2 (31000);
   VG_FIIDSUCURSAL       INTEGER;
   VG_FCNOMBRESUC        VARCHAR2 (31000);
   VG_FIIDCANAL          INTEGER;
   VG_FCCANAL            VARCHAR2 (31000);
   vg_count              INTEGER;

   PROCEDURE inserta_geografia
   AS
   BEGIN
      --Se valida la informacion en la tabla tcperfilesemp
      MERGE INTO scsisges.tcperfilesemp destino
           USING (SELECT 1                   fiidperfil,
                         8067                fnfuncionsap,
                         'Vendedor'          fcnombreperfil,
                         'Socio Vendedor'    fcdescripcion,
                         USER                fcusrmodifico,
                         SYSDATE             fdmodificacion,
                         1                   fntipoperfil
                    FROM DUAL
                  UNION
                  SELECT 4,
                         8033,
                         'Gerente Regional',
                         'Gerente Regional',
                         USER,
                         SYSDATE,
                         1
                    FROM DUAL
                  UNION
                  SELECT 5,
                         8032,
                         'Gerente de Zona',
                         'Gerente de Zona',
                         USER,
                         SYSDATE,
                         1
                    FROM DUAL
                  UNION
                  SELECT 6,
                         6666,
                         'Gerente de Territorio',
                         'Gerente de Territorio',
                         USER,
                         SYSDATE,
                         1
                    FROM DUAL
                  UNION
                  SELECT 7,
                         1533,
                         'Jefe de Área',
                         'Jefe de Área',
                         USER,
                         SYSDATE,
                         1
                    FROM DUAL) origen
              ON (    destino.FIIDPERFIL = origen.FIIDPERFIL
                  AND destino.FNFUNCIONSAP = origen.FNFUNCIONSAP)
      WHEN NOT MATCHED
      THEN
         INSERT     (FIIDPERFIL,
                     FNFUNCIONSAP,
                     FCNOMBREPERFIL,
                     FCDESCRIPCION,
                     FCUSRMODIFICO,
                     FDMODIFICACION,
                     FNTIPOPERFIL)
             VALUES (origen.FIIDPERFIL,
                     origen.FNFUNCIONSAP,
                     origen.FCNOMBREPERFIL,
                     origen.FCDESCRIPCION,
                     origen.FCUSRMODIFICO,
                     origen.FDMODIFICACION,
                     origen.FNTIPOPERFIL);

      --Se valida la informacion en la tabla tcpais
      MERGE INTO scsisges.tcpais destino
           USING (SELECT 1           FIIDPAIS,
                         1           FINUMPAIS,
                         'MEXICO'    FCNOMPAIS,
                         SYSDATE     FDFECACTUAL,
                         'MEXICO'    FCPAIS,
                         1           FIESTATUS,
                         SYSDATE     FDMODIFICACION,
                         USER        FCUSRMODIFICO
                    FROM DUAL) origen
              ON (destino.FIIDPAIS = origen.FIIDPAIS)
      WHEN NOT MATCHED
      THEN
         INSERT     (FIIDPAIS,
                     FINUMPAIS,
                     FCNOMPAIS,
                     FDFECACTUAL,
                     FCPAIS,
                     FIESTATUS,
                     FDMODIFICACION,
                     FCUSRMODIFICO)
             VALUES (origen.FIIDPAIS,
                     origen.FINUMPAIS,
                     origen.FCNOMPAIS,
                     origen.FDFECACTUAL,
                     origen.FCPAIS,
                     origen.FIESTATUS,
                     origen.FDMODIFICACION,
                     origen.FCUSRMODIFICO);

      --Se valida la informacion en la tabla tafxterritorios
      MERGE INTO scsisges.tafxterritorios destino
           USING (SELECT 1                      FIIDPAIS,
                         186337                 FIIDTERRITORIO,
                         'GEOGRAFIA TIENDAS'    FCDESCTERRIRORIO,
                         1                      FIESTATUS,
                         SYSDATE                FDMODIFICACION,
                         USER                   FCUSRMODIFICO,
                         2                      FITIPOGEO
                    FROM DUAL) origen
              ON (    destino.FIIDPAIS = origen.FIIDPAIS
                  AND destino.FIIDTERRITORIO = origen.FIIDTERRITORIO)
      WHEN NOT MATCHED
      THEN
         INSERT     (FIIDPAIS,
                     FIIDTERRITORIO,
                     FCDESCTERRIRORIO,
                     FIESTATUS,
                     FDMODIFICACION,
                     FCUSRMODIFICO,
                     FITIPOGEO)
             VALUES (origen.FIIDPAIS,
                     origen.FIIDTERRITORIO,
                     origen.FCDESCTERRIRORIO,
                     origen.FIESTATUS,
                     origen.FDMODIFICACION,
                     origen.FCUSRMODIFICO,
                     origen.FITIPOGEO);

      --Se valida la informacion en la tabla tafxzonas
      MERGE INTO scsisges.tafxzonas destino
           USING (SELECT 1                                   FIIDPAIS,
                         186337                              FIIDTERRITORIO,
                         186926                              FIIDZONA,
                         'ZONA TIENDAS EKT METRO FORANEA'    FCDESCZONAS,
                         1                                   FIESTATUS,
                         SYSDATE                             FDMODIFICACION,
                         USER                                FCUSRMODIFICO
                    FROM DUAL) origen
              ON (    destino.FIIDPAIS = origen.FIIDPAIS
                  AND destino.FIIDTERRITORIO = origen.FIIDTERRITORIO
                  AND destino.FIIDZONA = origen.FIIDZONA)
      WHEN NOT MATCHED
      THEN
         INSERT     (FIIDPAIS,
                     FIIDTERRITORIO,
                     FIIDZONA,
                     FCDESCZONAS,
                     FIESTATUS,
                     FDMODIFICACION,
                     FCUSRMODIFICO)
             VALUES (origen.FIIDPAIS,
                     origen.FIIDTERRITORIO,
                     origen.FIIDZONA,
                     origen.FCDESCZONAS,
                     origen.FIESTATUS,
                     origen.FDMODIFICACION,
                     origen.FCUSRMODIFICO);

      --Se valida la informacion en la tabla tafxregiones
      MERGE INTO scsisges.tafxregiones destino
           USING (SELECT 1                                    FIIDPAIS,
                         186337                               FIIDTERRITORIO,
                         186926                               FIIDZONA,
                         186366                               FIIDREGION,
                         'REGIONAL TIENDAS EKT CONTRERAS 6'   FCDESCREGION,
                         1                                    FIESTATUS,
                         SYSDATE                              FDMODIFICACION,
                         USER                                 FCUSRMODIFICO
                    FROM DUAL) origen
              ON (    destino.FIIDPAIS = origen.FIIDPAIS
                  AND destino.FIIDTERRITORIO = origen.FIIDTERRITORIO
                  AND destino.FIIDZONA = origen.FIIDZONA
                  AND destino.FIIDREGION = origen.FIIDREGION)
      WHEN NOT MATCHED
      THEN
         INSERT     (FIIDPAIS,
                     FIIDTERRITORIO,
                     FIIDZONA,
                     FIIDREGION,
                     FCDESCREGION,
                     FIESTATUS,
                     FDMODIFICACION,
                     FCUSRMODIFICO)
             VALUES (origen.FIIDPAIS,
                     origen.FIIDTERRITORIO,
                     origen.FIIDZONA,
                     origen.FIIDREGION,
                     origen.FCDESCREGION,
                     origen.FIESTATUS,
                     origen.FDMODIFICACION,
                     origen.FCUSRMODIFICO);

      --Se valida la informacion en la tabla tcfxsucursal
      MERGE INTO scsisges.tcfxsucursal destino
           USING (SELECT 1                     FIIDPAIS,
                         186337                FIIDTERRITORIO,
                         186926                FIIDZONA,
                         186366                FIIDREGION,
                         2024                  FIIDSUCURSAL,
                         1                     FIIDCANAL,
                         522024                FINUMCECOSUC,
                         'MEGA SAN ANGEL'      FCNOMBRESUC,
                         SYSDATE               FDFECACTUAL,
                         'TIENDA'              FCTIPO,
                         SYSDATE               FDINICIOOPERACIONES,
                         0.16                  FNIVA,
                         1                     FIESTATUS,
                         NULL                  FIIDDIVISION,
                         'AV REVOLUCION'       FCCALLE,
                         '1775'                FCNUMEXT,
                         '0'                   FCNUMINT,
                         'SAN ANGEL'           FCCOLONIA,
                         'ALVARO OBREGON'      FCMUNICIPIO,
                         'CIUDAD DE MEXICO'    FCESTADO,
                         '1000'                FCCP,
                         1                     FIIDENTIDAD,
                         SYSDATE               FDMODIFICACION,
                         USER                  FCUSRMODIFICO
                    FROM DUAL) origen
              ON (    destino.FIIDPAIS = origen.FIIDPAIS
                  AND destino.FIIDTERRITORIO = origen.FIIDTERRITORIO
                  AND destino.FIIDZONA = origen.FIIDZONA
                  AND destino.FIIDREGION = origen.FIIDREGION
                  AND destino.FIIDSUCURSAL = origen.FIIDSUCURSAL)
      WHEN NOT MATCHED
      THEN
         INSERT     (FIIDPAIS,
                     FIIDZONA,
                     FIIDREGION,
                     FIIDSUCURSAL,
                     FIIDTERRITORIO,
                     FIIDCANAL,
                     FINUMCECOSUC,
                     FCNOMBRESUC,
                     FDFECACTUAL,
                     FCTIPO,
                     FDINICIOOPERACIONES,
                     FNIVA,
                     FIESTATUS,
                     FIIDDIVISION,
                     FCCALLE,
                     FCNUMEXT,
                     FCNUMINT,
                     FCCOLONIA,
                     FCMUNICIPIO,
                     FCESTADO,
                     FCCP,
                     FIIDENTIDAD,
                     FDMODIFICACION,
                     FCUSRMODIFICO)
             VALUES (origen.FIIDPAIS,
                     origen.FIIDZONA,
                     origen.FIIDREGION,
                     origen.FIIDSUCURSAL,
                     origen.FIIDTERRITORIO,
                     origen.FIIDCANAL,
                     origen.FINUMCECOSUC,
                     origen.FCNOMBRESUC,
                     origen.FDFECACTUAL,
                     origen.FCTIPO,
                     origen.FDINICIOOPERACIONES,
                     origen.FNIVA,
                     origen.FIESTATUS,
                     origen.FIIDDIVISION,
                     origen.FCCALLE,
                     origen.FCNUMEXT,
                     origen.FCNUMINT,
                     origen.FCCOLONIA,
                     origen.FCMUNICIPIO,
                     origen.FCESTADO,
                     origen.FCCP,
                     origen.FIIDENTIDAD,
                     origen.FDMODIFICACION,
                     origen.FCUSRMODIFICO);
   END;

   PROCEDURE consulta_sucursal
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := 8067;                      --funcion sap de un vendedor
      PA_CECO := 522024;                            --ceco de la sucursal 2024

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_not_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_not_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_not_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;

   PROCEDURE consulta_regional
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := 8033;                      --funcion sap de un regional
      PA_CECO := 186366;                              --ceco de la region XXXX

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;

   PROCEDURE consulta_zonal
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := 8032;                         --funcion sap de un zonal
      PA_CECO := 186926;                                --ceco de la zona XXXX

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;


   PROCEDURE consulta_territorial
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := 6666;                    --funcion sap de un territorio
      PA_CECO := 186336;                            --ceco del territorio XXXX

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;

   PROCEDURE consulta_nacional
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := 1533;                          --funcion sap de un pais
      PA_CECO := 1;                                 --ceco del pais 1 - México

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;



   PROCEDURE consulta_no_existentes
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := 12345;                             --dato que no existe
      PA_CECO := 12345;                                  -- dato que no existe

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_not_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_not_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_not_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;

   PROCEDURE consulta_con_null
   AS
      PA_FUNCIONSAP   NUMBER;
      PA_CECO         NUMBER;
      PA_CURS         SYS_REFCURSOR;
      PA_CODERROR     NUMBER;
      PA_DESERROR     VARCHAR2 (200);
   BEGIN
      PA_FUNCIONSAP := NULL;                              --dato que no existe
      PA_CECO := NULL;                                   -- dato que no existe

      -- se ejecuta el store
      SCSISGES.PAGEOGRAFIA.SPCUREMPLEADO (PA_FUNCIONSAP   => PA_FUNCIONSAP,
                                          PA_CECO         => PA_CECO,
                                          PA_CURS         => PA_CURS,
                                          PA_CODERROR     => PA_CODERROR,
                                          PA_DESERROR     => PA_DESERROR);
      vg_count := 0;

      LOOP
         FETCH PA_CURS
            INTO VG_FIIDPERFIL,
                 VG_FIIDPAIS,
                 VG_FCDESCPAIS,
                 VG_FIIDTERRITORIO,
                 VG_FCDESCTERRIRORIO,
                 VG_FIIDZONA,
                 VG_FCDESCZONAS,
                 VG_FIIDREGION,
                 VG_FCDESCREGION,
                 VG_FIIDSUCURSAL,
                 VG_FCNOMBRESUC,
                 VG_FIIDCANAL,
                 VG_FCCANAL;

         EXIT WHEN PA_CURS%NOTFOUND;
         vg_count := vg_count + 1;
         ut.expect (VG_FIIDPERFIL,
                    'Se espera que el campo FIIDPERFIL contenga un valor').to_be_null ();
         ut.expect (VG_FIIDPAIS,
                    'Se espera que el campo FIIDPAIS contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCPAIS,
                    'Se espera que el campo FCDESCPAIS contenga un valor').to_be_null ();
         ut.expect (
            VG_FIIDTERRITORIO,
            'se espera que el campo FIIDTERRITORIO contenga un valor').to_be_null ();
         ut.expect (
            VG_FCDESCTERRIRORIO,
            'se espera que el campo FCDESCTERRIRORIO contenga un valor').to_be_null ();
         ut.expect (VG_FIIDZONA,
                    'Se espera que el campo FIIDZONA contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCZONAS,
                    'Se espera que el campo FCDESCZONAS contenga un valor').to_be_null ();
         ut.expect (VG_FIIDREGION,
                    'Se espera que el campo FIIDREGION contenga un valor').to_be_null ();
         ut.expect (VG_FCDESCREGION,
                    'Se espera que el campo FCDESCREGION contenga un valor').to_be_null ();
         ut.expect (VG_FIIDSUCURSAL,
                    'Se espera que el campo FIIDSUCURSAL contenga un valor').to_be_null ();
         ut.expect (VG_FCNOMBRESUC,
                    'Se espera que el campo FCNOMBRESUC contenga un valor').to_be_null ();
         ut.expect (VG_FIIDCANAL,
                    'Se espera que el campo FIIDCANAL contenga un valor').to_be_null ();
         ut.expect (VG_FCCANAL,
                    'Se espera que el campo FCCANAL contenga un valor').to_be_null ();
      END LOOP;

      CLOSE PA_CURS;

      ut.expect (vg_count, 'Se espera que el cursor devuelva solo una fila').to_ (
         equal (1));
      ut.expect (PA_CODERROR, 'Código de salida es 0').to_ (equal (0));
      ut.expect (PA_DESERROR, 'Mensaje de salida es igual OK').to_ (
         equal ('OK'));
   END;
END TEST_PAGEOGRAFIA;