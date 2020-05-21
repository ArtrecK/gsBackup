--------------------------------------------------------
--  DDL for Package Body PQFXMDGEOGRAFIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQFXMDGEOGRAFIA" 
IS
    -- Author  : 149766 - Arturo Lopez Patricio
    -- Created : 03/12/2018
    -- Purpose : geografias para aplicativo fenix


    CSL_0   CONSTANT INTEGER := 0;
    CSL_1   CONSTANT INTEGER := 1;

    PROCEDURE SPCONSULGEOGRAFIA (PA_TIPOGEOGRAFIA   IN     NUMBER,
                                 PA_FNPAIS          IN     NUMBER,
                                 PA_CURDATOS           OUT SYS_REFCURSOR,
                                 PA_FNCODERROR         OUT INTEGER,
                                 PA_FCDESERROR         OUT VARCHAR2)
    IS
    BEGIN
        OPEN PA_CURDATOS FOR
              SELECT TC.FIIDTERRITORIO,
                     TC.FIIDTERRITORIO || ' - ' || TR.FCDESCTERRIRORIO
                         AS FCDESCTERRIRORIO,
                     TC.FIIDZONA,
                     TC.FIIDZONA || ' - ' || TZO.FCDESCZONAS
                         AS FCDESCZONAS,
                     TC.FIIDREGION,
                     TC.FIIDREGION || ' - ' || TREG.FCDESCREGION
                         AS FCDESCREGION,
                     TC.FIIDSUCURSAL,
                     TC.FIIDSUCURSAL || ' - ' || TC.FCNOMBRESUC
                         AS FCNOMBRESUC,
                     TC.FIIDCANAL,
                     TC.FCTIPO
                         AS FCCANAL
                FROM SCSISGES.TCFXSUCURSAL   TC,
                     SCSISGES.TAFXTERRITORIOS TR,
                     SCSISGES.TAFXZONAS      TZO,
                     SCSISGES.TAFXREGIONES   TREG,
                     SCSISGES.TCPAIS         TP
               WHERE     TR.FITIPOGEO = PA_TIPOGEOGRAFIA    -- 1: BAZ | 2: EKT
                     AND TC.FIIDPAIS = PA_FNPAIS
                     AND TC.FIESTATUS = CSL_1
                     AND TC.FIIDPAIS = TP.FIIDPAIS
                     AND TC.FIIDTERRITORIO = TR.FIIDTERRITORIO
                     AND TC.FIIDPAIS = TR.FIIDPAIS
                     AND TC.FIIDZONA = TZO.FIIDZONA
                     AND TC.FIIDPAIS = TZO.FIIDPAIS
                     AND TC.FIIDTERRITORIO = TZO.FIIDTERRITORIO
                     AND TC.FIIDPAIS = TREG.FIIDPAIS
                     AND TC.FIIDTERRITORIO = TREG.FIIDTERRITORIO
                     AND TC.FIIDZONA = TREG.FIIDZONA
                     AND TC.FIIDREGION = TREG.FIIDREGION
                     AND TREG.FIESTATUS = CSL_1
                     AND TC.FIIDTERRITORIO = TC.FIIDTERRITORIO + CSL_0
                     AND TC.FIIDPAIS = TC.FIIDPAIS + CSL_0
                     AND TC.FIIDZONA = TC.FIIDZONA + CSL_0
                     AND TC.FIIDREGION = TC.FIIDREGION + CSL_0
                     AND TC.FIIDSUCURSAL = TC.FIIDSUCURSAL + CSL_0
            ORDER BY TC.FIIDTERRITORIO,
                     TC.FIIDZONA,
                     TC.FIIDREGION,
                     TC.FIIDSUCURSAL;
    EXCEPTION
        WHEN OTHERS
        THEN
            PA_FNCODERROR := SQLCODE;
            PA_FCDESERROR := SUBSTR (SQLERRM, 0, 200);
            SCSISGES.SPERRORES (SYSDATE,
                                PA_FNCODERROR,
                                PA_FCDESERROR,
                                'PQFXMDGEOGRAFIA.SPCONSULGEOGRAFIA');
    END SPCONSULGEOGRAFIA;

    PROCEDURE SPCONSULPAISES (PA_CURDATOS     OUT SYS_REFCURSOR,
                              PA_FNCODERROR   OUT INTEGER,
                              PA_FCDESERROR   OUT VARCHAR2)
    IS
    BEGIN
        OPEN PA_CURDATOS FOR   SELECT T.FIIDPAIS, T.FCNOMPAIS
                                 FROM SCSISGES.TCPAIS T
                                WHERE T.FIESTATUS = CSL_1
                             ORDER BY T.FIIDPAIS;
    EXCEPTION
        WHEN OTHERS
        THEN
            PA_FNCODERROR := SQLCODE;
            PA_FCDESERROR := SUBSTR (SQLERRM, 0, 200);
            SCSISGES.SPERRORES (SYSDATE,
                                PA_FNCODERROR,
                                PA_FCDESERROR,
                                'PQFXMDGEOGRAFIA.SPCONSULPAISES');
    END SPCONSULPAISES;

    PROCEDURE SPCONSULCANALES (PA_CURDATOS     OUT SYS_REFCURSOR,
                               PA_FNCODERROR   OUT INTEGER,
                               PA_FCDESERROR   OUT VARCHAR2)
    IS
    BEGIN
        OPEN PA_CURDATOS FOR
              SELECT DISTINCT T.FIIDCANAL, T.FCTIPO
                FROM SCSISGES.TCFXSUCURSAL T
               WHERE     T.FIESTATUS = CSL_1
                     AND T.FIIDPAIS = CSL_1
                     AND T.FIIDTERRITORIO = T.FIIDTERRITORIO + CSL_0
                     AND T.FIIDPAIS = T.FIIDPAIS + CSL_0
                     AND T.FIIDZONA = T.FIIDZONA + CSL_0
                     AND T.FIIDREGION = T.FIIDREGION + CSL_0
                     AND T.FIIDSUCURSAL = T.FIIDSUCURSAL + CSL_0
            ORDER BY T.FIIDCANAL;
    EXCEPTION
        WHEN OTHERS
        THEN
            PA_FNCODERROR := SQLCODE;
            PA_FCDESERROR := SUBSTR (SQLERRM, 0, 200);
            SCSISGES.SPERRORES (SYSDATE,
                                PA_FNCODERROR,
                                PA_FCDESERROR,
                                'PQFXMDGEOGRAFIA.SPCONSULPAISES');
    END SPCONSULCANALES;
END PQFXMDGEOGRAFIA;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXMDGEOGRAFIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXMDGEOGRAFIA" TO "USRSISGES";
