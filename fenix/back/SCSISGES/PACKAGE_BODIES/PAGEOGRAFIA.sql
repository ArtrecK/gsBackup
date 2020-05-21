--------------------------------------------------------
--  DDL for Package Body PAGEOGRAFIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAGEOGRAFIA" 
AS
   csG_0      CONSTANT INTEGER := 0;
   csG_1      CONSTANT INTEGER := 1;
   csG_7      CONSTANT INTEGER := 7;
   csG_200    CONSTANT INTEGER := 200;

   csG_8067   CONSTANT INTEGER := 8067;                             --VENDEDOR
   csG_1778   CONSTANT INTEGER := 1778;                             --VENDEDOR
   csG_8034   CONSTANT INTEGER := 8034;                             --SUBLIDER
   csG_8035   CONSTANT INTEGER := 8035;                                --LIDER
   csG_8033   CONSTANT INTEGER := 8033;                             --REGIONAL
   csG_8032   CONSTANT INTEGER := 8032;                                --ZONAL
   csG_6666   CONSTANT INTEGER := 6666;                          --TERRITORIAL

   PROCEDURE spcurempleado (pa_funcionsap   IN     INTEGER,
                            pa_ceco         IN     INTEGER,
                            pa_curs            OUT SYS_REFCURSOR,
                            pa_coderror        OUT INTEGER,
                            pa_deserror        OUT VARCHAR2)
   AS
      vl_perfil   INTEGER;
   BEGIN
      BEGIN
         SELECT fiidperfil
           INTO vl_perfil
           FROM scsisges.tcperfilesemp
          WHERE fnfuncionsap = pa_funcionsap;
      EXCEPTION
         WHEN OTHERS
         THEN
            vl_perfil := csg_7;
      END;

      CASE
         WHEN pa_funcionsap IN (csG_8067, csG_1778, csG_8034, csG_8035)
         THEN          --funciones sap para vendedores, subgerentes y gerentes
            OPEN pa_curs FOR
               SELECT vl_perfil fiidperfil,
                      PAIS.FIIDPAIS,
                      PAIS.FCNOMPAIS FCDESCPAIS,
                      TERR.FIIDTERRITORIO,
                      TERR.FCDESCTERRIRORIO,
                      ZONA.FIIDZONA,
                      ZONA.FCDESCZONAS,
                      REG.FIIDREGION,
                      REG.FCDESCREGION,
                      SUC.FIIDSUCURSAL,
                      SUC.FCNOMBRESUC,
                      SUC.FIIDCANAL,
                      SUC.FCTIPO FCCANAL
                 FROM SCSISGES.TCPAIS PAIS
                      LEFT JOIN SCSISGES.TAFXTERRITORIOS TERR
                         ON PAIS.FIIDPAIS = TERR.FIIDPAIS
                      LEFT JOIN SCSISGES.TAFXZONAS ZONA
                         ON TERR.FIIDPAIS = ZONA.FIIDPAIS
                            AND TERR.FIIDTERRITORIO = ZONA.FIIDTERRITORIO
                      LEFT JOIN SCSISGES.TAFXREGIONES REG
                         ON     ZONA.FIIDPAIS = REG.FIIDPAIS
                            AND ZONA.FIIDTERRITORIO = REG.FIIDTERRITORIO
                            AND ZONA.FIIDZONA = REG.FIIDZONA
                      LEFT JOIN SCSISGES.TCFXSUCURSAL SUC
                         ON     REG.FIIDPAIS = SUC.FIIDPAIS
                            AND REG.FIIDTERRITORIO = SUC.FIIDTERRITORIO
                            AND REG.FIIDZONA = SUC.FIIDZONA
                            AND REG.FIIDREGION = SUC.FIIDREGION
                WHERE     PAIS.FIIDPAIS > CSG_0
                      AND TERR.FIIDTERRITORIO > CSG_0
                      AND ZONA.FIIDZONA > CSG_0
                      AND REG.FIIDREGION > CSG_0
                      AND SUC.FINUMCECOSUC = PA_CECO;
         WHEN pa_funcionsap IN (csG_8033)
         THEN                                  --funciones sap para regionales
            OPEN pa_curs FOR
               SELECT vl_perfil fiidperfil,
                      PAIS.FIIDPAIS,
                      PAIS.FCNOMPAIS FCDESCPAIS,
                      TERR.FIIDTERRITORIO,
                      TERR.FCDESCTERRIRORIO,
                      ZONA.FIIDZONA,
                      ZONA.FCDESCZONAS,
                      REG.FIIDREGION,
                      REG.FCDESCREGION,
                      NULL FIIDSUCURSAL,
                      NULL FCNOMBRESUC,
                      NULL FIIDCANAL,
                      NULL FCCANAL
                 FROM SCSISGES.TCPAIS PAIS
                      INNER JOIN SCSISGES.TAFXTERRITORIOS TERR
                         ON PAIS.FIIDPAIS = TERR.FIIDPAIS
                      INNER JOIN SCSISGES.TAFXZONAS ZONA
                         ON TERR.FIIDPAIS = ZONA.FIIDPAIS
                            AND TERR.FIIDTERRITORIO = ZONA.FIIDTERRITORIO
                      INNER JOIN SCSISGES.TAFXREGIONES REG
                         ON     ZONA.FIIDPAIS = REG.FIIDPAIS
                            AND ZONA.FIIDTERRITORIO = REG.FIIDTERRITORIO
                            AND ZONA.FIIDZONA = REG.FIIDZONA
                WHERE     PAIS.FIIDPAIS > CSG_0
                      AND TERR.FIIDTERRITORIO > CSG_0
                      AND ZONA.FIIDZONA > CSG_0
                      AND REG.FIIDREGION = PA_CECO;
         WHEN pa_funcionsap IN (csG_8032)
         THEN                                     --funciones sap para zonales
            OPEN pa_curs FOR
               SELECT vl_perfil fiidperfil,
                      PAIS.FIIDPAIS,
                      PAIS.FCNOMPAIS fcdescpais,
                      TERR.FIIDTERRITORIO,
                      TERR.FCDESCTERRIRORIO,
                      ZONA.FIIDZONA,
                      ZONA.FCDESCZONAS,
                      NULL FIIDREGION,
                      NULL FCDESCREGION,
                      NULL FIIDSUCURSAL,
                      NULL FCNOMBRESUC,
                      NULL FIIDCANAL,
                      NULL FCCANAL
                 FROM SCSISGES.TCPAIS PAIS
                      INNER JOIN SCSISGES.TAFXTERRITORIOS TERR
                         ON PAIS.FIIDPAIS = TERR.FIIDPAIS
                      INNER JOIN SCSISGES.TAFXZONAS ZONA
                         ON TERR.FIIDPAIS = ZONA.FIIDPAIS
                            AND TERR.FIIDTERRITORIO = ZONA.FIIDTERRITORIO
                WHERE     PAIS.FIIDPAIS > CSG_0
                      AND TERR.FIIDTERRITORIO > CSG_0
                      AND ZONA.FIIDZONA = PA_CECO;
         WHEN pa_funcionsap IN (csG_6666)
         THEN                               --funciones sap para territoriales
            OPEN pa_curs FOR
               SELECT vl_perfil fiidperfil,
                      PAIS.FIIDPAIS,
                      PAIS.FCNOMPAIS FCDESCPAIS,
                      TERR.FIIDTERRITORIO,
                      TERR.FCDESCTERRIRORIO,
                      NULL FIIDZONA,
                      NULL FCDESCZONAS,
                      NULL FIIDREGION,
                      NULL FCDESCREGION,
                      NULL FIIDSUCURSAL,
                      NULL FCNOMBRESUC,
                      NULL FIIDCANAL,
                      NULL FCCANAL
                 FROM    SCSISGES.TCPAIS PAIS
                      INNER JOIN
                         SCSISGES.TAFXTERRITORIOS TERR
                      ON PAIS.FIIDPAIS = TERR.FIIDPAIS
                WHERE PAIS.FIIDPAIS > CSG_0 AND TERR.FIIDTERRITORIO = PA_CECO;
         WHEN pa_funcionsap IS NULL OR PA_CECO IS NULL
         THEN
            OPEN pa_curs FOR
               SELECT NULL fiidperfil,
                      NULL fiidpais,
                      NULL fcdescpais,
                      NULL FIIDTERRITORIO,
                      NULL FCDESCTERRIRORIO,
                      NULL fiidzona,
                      NULL fcdesczonas,
                      NULL fiidregion,
                      NULL fcdescregion,
                      NULL fiidsucursal,
                      NULL fcnombresuc,
                      NULL fiidcanal,
                      NULL fccanal
                 FROM DUAL;
         ELSE                                   -- cualquier otro se va a pais
            OPEN pa_curs FOR
               SELECT vl_perfil fiidperfil,
                      PAIS.FIIDPAIS,
                      PAIS.FCNOMPAIS FCDESCPAIS,
                      NULL FIIDTERRITORIO,
                      NULL FCDESCTERRIRORIO,
                      NULL FIIDZONA,
                      NULL FCDESCZONAS,
                      NULL FIIDREGION,
                      NULL FCDESCREGION,
                      NULL FIIDSUCURSAL,
                      NULL FCNOMBRESUC,
                      NULL FIIDCANAL,
                      NULL FCCANAL
                 FROM SCSISGES.TCPAIS PAIS
                WHERE PAIS.FIIDPAIS = csg_1;
      END CASE;

      pa_coderror := csg_0;
      pa_deserror := 'OK';
   EXCEPTION
      WHEN OTHERS
      THEN
         OPEN pa_curs FOR
            SELECT NULL fiidperfil,
                   NULL fiidpais,
                   NULL fcdescpais,
                   NULL FIIDTERRITORIO,
                   NULL FCDESCTERRIRORIO,
                   NULL fiidzona,
                   NULL fcdesczonas,
                   NULL fiidregion,
                   NULL fcdescregion,
                   NULL fiidsucursal,
                   NULL fcnombresuc,
                   NULL fiidcanal,
                   NULL fccanal
              FROM DUAL;

         scsisges.sperrores (SYSDATE,
                             SQLCODE,
                             SUBSTR (SQLERRM, csG_0, csG_200),
                             'PAGEOGRAFIA.SPCUREMPLEADO');

         pa_coderror := SQLCODE;
         pa_deserror := SQLERRM;
   END spcurempleado;
END pageografia;

/

  GRANT EXECUTE ON "SCSISGES"."PAGEOGRAFIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGEOGRAFIA" TO "USRSISGES";
