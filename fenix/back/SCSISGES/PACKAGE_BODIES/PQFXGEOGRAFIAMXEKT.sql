--------------------------------------------------------
--  DDL for Package Body PQFXGEOGRAFIAMXEKT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQFXGEOGRAFIAMXEKT" 
IS
    -- Author  : 149766 - Arturo Lopez Patricio
    -- Created : 23/10/2018
    -- Purpose : proceso de geografias elektra para Mexico
    VG_CUENTA                      INTEGER;

    CSL_0                 CONSTANT INTEGER := 0;
    CSL_1                 CONSTANT INTEGER := 1;
    CSL_2                 CONSTANT INTEGER := 2;
    CSL_3                 CONSTANT INTEGER := 3;
    CSL_9                 CONSTANT INTEGER := 9;
    CSL_39                CONSTANT INTEGER := 39;
    CSL_MEXICO            CONSTANT VARCHAR2 (6) := 'MEXICO';
    CSL_LAM               CONSTANT VARCHAR2 (3) := 'LAM';
    CSL_SYR               CONSTANT VARCHAR2 (3) := 'SYR';
    CSL_TIENDA            CONSTANT VARCHAR2 (6) := 'TIENDA';
    CSL_BDR               CONSTANT VARCHAR2 (17) := 'BODEGA DE REMATES';
    CSL_TERCEROS          CONSTANT VARCHAR2 (8) := 'TERCEROS';
    CSL_DAZ               CONSTANT VARCHAR2 (13) := 'DINERO AZTECA';
    CSL_PRESTA            CONSTANT VARCHAR2 (13) := 'PRESTA PRENDA';
    CSL_CERR              CONSTANT VARCHAR2 (7) := 'CERRADO';
    CSL_CANC              CONSTANT VARCHAR2 (9) := 'CANCELADO';
    CSL_USRSISGES         CONSTANT VARCHAR2 (9) := 'USRSISGES';
    CSL_ACTIVO            CONSTANT VARCHAR2 (6) := 'ACTIVO';
    CSL_PORCERRAR         CONSTANT VARCHAR2 (10) := 'POR CERRAR';
    CSL_NOESPECIALIZADO   CONSTANT VARCHAR2 (7) := 'NO ESPE';

    PROCEDURE SPPROCESAPAIS (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        MERGE INTO SCSISGES.TCPAIS PS
             USING (SELECT DISTINCT
                           T.FIIDPAIS
                               AS FIIDPAIS,
                           CASE
                               WHEN T.FIIDPAIS = CSL_1 THEN CSL_1
                               ELSE CSL_2
                           END
                               AS FINUMPAIS,
                           T.FCPAIS
                               AS FCNOMPAIS,
                           TRUNC (SYSDATE)
                               AS FDFECACTUAL,
                           CASE
                               WHEN T.FIIDPAIS = CSL_1 THEN CSL_MEXICO
                               ELSE CSL_LAM
                           END
                               AS FCPAIS
                      FROM TABLE (PA_TBSUCURSALES) T
                     WHERE     T.FIIDENTIDAD = CSL_1
                           AND T.FCTIPOOP LIKE
                                   '%' || CSL_NOESPECIALIZADO || '%'
                           AND T.FCIDCANAL > CSL_0
                           AND T.FCSTATUS_DESC IN (CSL_ACTIVO, CSL_PORCERRAR)
                           AND T.FIIDPAIS = CSL_1) VP
                ON (PS.FIIDPAIS = VP.FIIDPAIS)
        WHEN MATCHED
        THEN
            UPDATE SET PS.FINUMPAIS = VP.FINUMPAIS,
                       PS.FCNOMPAIS = VP.FCNOMPAIS,
                       PS.FDFECACTUAL = VP.FDFECACTUAL,
                       PS.FCPAIS = VP.FCPAIS,
                       PS.FDMODIFICACION = SYSDATE,
                       PS.FCUSRMODIFICO = CSL_USRSISGES
        WHEN NOT MATCHED
        THEN
            INSERT     (FIIDPAIS,
                        FINUMPAIS,
                        FCNOMPAIS,
                        FDFECACTUAL,
                        FCPAIS,
                        FIESTATUS,
                        FCUSRMODIFICO)
                VALUES (VP.FIIDPAIS,
                        VP.FINUMPAIS,
                        VP.FCNOMPAIS,
                        VP.FDFECACTUAL,
                        VP.FCPAIS,
                        CSL_1,
                        CSL_USRSISGES);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPPROCESAPAIS');
    END SPPROCESAPAIS;


    PROCEDURE SPPROCTERRITORIO (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        MERGE INTO SCSISGES.TAFXTERRITORIOS TER
             USING (  SELECT DISTINCT
                             CG.FIIDCCBISABUELO AS FIIDTERRITORIO,
                             CG.FIIDPAIS        AS FIIDPAIS,
                             CG.FCNOMBREBISABUELO AS FCNOMTERRITORIO,
                             SYSDATE            AS ULTIMA_MODIFICACION,
                             CSL_USRSISGES      AS USUARIO_MODIFICO
                        FROM TABLE (PA_TBSUCURSALES) CG
                    ORDER BY FIIDPAIS, FIIDTERRITORIO) VP
                ON (    TER.FIIDTERRITORIO = VP.FIIDTERRITORIO
                    AND TER.FIIDPAIS = VP.FIIDPAIS)
        WHEN MATCHED
        THEN
            UPDATE SET
                TER.FCDESCTERRIRORIO = VP.FCNOMTERRITORIO,
                TER.FDMODIFICACION = VP.ULTIMA_MODIFICACION,
                TER.FCUSRMODIFICO = VP.USUARIO_MODIFICO
        WHEN NOT MATCHED
        THEN
            INSERT     (FIIDPAIS,
                        FIIDTERRITORIO,
                        FCDESCTERRIRORIO,
                        FIESTATUS,
                        FITIPOGEO,
                        FDMODIFICACION,
                        FCUSRMODIFICO)
                VALUES (VP.FIIDPAIS,
                        VP.FIIDTERRITORIO,
                        VP.FCNOMTERRITORIO,
                        CSL_1,
                        CSL_2,
                        VP.ULTIMA_MODIFICACION,
                        VP.USUARIO_MODIFICO);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPPROCTERRITORIO');
    END SPPROCTERRITORIO;

    PROCEDURE SPPROCZONAS (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        MERGE INTO SCSISGES.TAFXZONAS TZ
             USING (SELECT DISTINCT
                           (CG.FIIDCCABUELO)  AS FIIDZONA,
                           CG.FIIDPAIS        AS FIIDPAIS,
                           CG.FIIDCCBISABUELO AS FIIDTERRITORIO,
                           CG.FCNOMBREABUELO  AS FCDESCZONAS,
                           SYSDATE            AS ULTIMA_MODIFICACION,
                           CSL_USRSISGES      AS USUARIO_MODIFICO
                      FROM TABLE (PA_TBSUCURSALES) CG
                     WHERE     CG.FIIDPAIS >= CSL_0
                           AND CG.FIIDCCBISABUELO IS NOT NULL
                           AND CG.FIIDCCABUELO IS NOT NULL
                           AND CG.FIIDENTIDAD IS NOT NULL) VV
                ON (    TZ.FIIDTERRITORIO = VV.FIIDTERRITORIO
                    AND TZ.FIIDPAIS = VV.FIIDPAIS
                    AND TZ.FIIDZONA = VV.FIIDZONA)
        WHEN MATCHED
        THEN
            UPDATE SET
                TZ.FCDESCZONAS = VV.FCDESCZONAS,
                TZ.FDMODIFICACION = VV.ULTIMA_MODIFICACION,
                TZ.FCUSRMODIFICO = VV.USUARIO_MODIFICO
        WHEN NOT MATCHED
        THEN
            INSERT     (FIIDPAIS,
                        FIIDTERRITORIO,
                        FIIDZONA,
                        FCDESCZONAS,
                        FIESTATUS,
                        FDMODIFICACION,
                        FCUSRMODIFICO)
                VALUES (VV.FIIDPAIS,
                        VV.FIIDTERRITORIO,
                        VV.FIIDZONA,
                        VV.FCDESCZONAS,
                        CSL_1,
                        VV.ULTIMA_MODIFICACION,
                        VV.USUARIO_MODIFICO);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPPROCZONAS');
    END SPPROCZONAS;

    PROCEDURE SPPROCREGIONES (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        MERGE INTO SCSISGES.TAFXREGIONES TR
             USING (SELECT DISTINCT
                           (CG.FIIDCCPADRE)   AS FIIDREGION,
                           CG.FIIDPAIS        AS FIIDPAIS,
                           CG.FIIDCCBISABUELO AS FIIDTERRITORIO,
                           CG.FIIDCCABUELO    AS FIIDZONA,
                           CG.FCNOMBREPADRE   AS FCDESCREGION,
                           SYSDATE            AS ULTIMA_MODIFICACION,
                           CSL_USRSISGES      AS USUARIO_MODIFICO
                      FROM TABLE (PA_TBSUCURSALES) CG
                     WHERE     CG.FIIDCCBISABUELO IS NOT NULL
                           AND CG.FIIDCCABUELO IS NOT NULL
                           AND CG.FIIDCCPADRE IS NOT NULL) VD
                ON (    TR.FIIDTERRITORIO = VD.FIIDTERRITORIO
                    AND TR.FIIDPAIS = VD.FIIDPAIS
                    AND TR.FIIDZONA = VD.FIIDZONA
                    AND TR.FIIDREGION = VD.FIIDREGION)
        WHEN MATCHED
        THEN
            UPDATE SET
                TR.FCDESCREGION = VD.FCDESCREGION,
                TR.FDMODIFICACION = VD.ULTIMA_MODIFICACION,
                TR.FCUSRMODIFICO = VD.USUARIO_MODIFICO
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
                VALUES (VD.FIIDPAIS,
                        VD.FIIDTERRITORIO,
                        VD.FIIDZONA,
                        VD.FIIDREGION,
                        VD.FCDESCREGION,
                        CSL_1,
                        VD.ULTIMA_MODIFICACION,
                        VD.USUARIO_MODIFICO);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPPROCREGIONES');
    END SPPROCREGIONES;

    PROCEDURE SPPROCSUCURSALEKT (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT)
    IS
        CURSOR cur_sucursales
        IS
              SELECT DISTINCT
                     (FINUMECO)
                         AS FIIDSUCURSAL,
                     FCIDCANAL
                         AS FIIDCANAL,
                     CASE
                         WHEN FCIDCANAL = CSL_1 THEN CSL_TIENDA
                         WHEN FCIDCANAL = CSL_2 THEN CSL_BDR
                         WHEN FCIDCANAL = CSL_3 THEN CSL_SYR
                         WHEN FCIDCANAL = CSL_9 THEN CSL_DAZ
                         WHEN FCIDCANAL = CSL_39 THEN CSL_PRESTA
                         ELSE CSL_TERCEROS
                     END
                         AS FCTIPO,
                     FIIDPAIS,
                     FIIDCCBISABUELO
                         AS FIIDTERRITORIO,
                     FIIDCCABUELO
                         AS FIIDZONA,
                     FIIDCCPADRE
                         AS FIIDREGION,
                     FIIDCC
                         AS FINUMCECOSUC,
                     FCNOMECO
                         AS FCNOMBRESUC,
                     CASE
                         WHEN FCSTATUS_DESC IN (CSL_CERR, CSL_CANC) THEN CSL_0
                         ELSE CSL_1
                     END
                         AS FIESTATUS,
                     FDFECHAAPACT
                         AS FDINICIOOPERACIONES,
                     SYSDATE
                         AS FDFECACTUAL,
                     FIIDENTIDAD,
                     FCCALLE,
                     FCNUMEXT,
                     FCNUMINT,
                     FCCOLONIA,
                     FCMUNICIPIO,
                     FCESTADO,
                     FICP
                         AS FCCP,
                     FIIVA
                         AS FNIVA,
                     NULL
                         AS FIIDDIVISION,
                     SYSDATE
                         FDMODIFICACION,
                     CSL_USRSISGES
                         AS FCUSRMODIFICO
                FROM TABLE (PA_TBSUCURSALES)
            ORDER BY FIIDSUCURSAL;

        TYPE ty_sucursales IS TABLE OF cur_sucursales%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcoll_datosSuc   ty_sucursales;
    BEGIN
        OPEN cur_sucursales;

        FETCH cur_sucursales BULK COLLECT INTO vlcoll_datosSuc;

        LOOP
            BEGIN
                EXIT WHEN vlcoll_datosSuc.COUNT = 0;

                FOR vl_i IN vlcoll_datosSuc.FIRST .. vlcoll_datosSuc.LAST
                LOOP
                    SELECT COUNT (1)
                      INTO VG_CUENTA
                      FROM SCSISGES.TCFXSUCURSAL TS
                     WHERE     TS.FIIDSUCURSAL =
                               TO_NUMBER (
                                   vlcoll_datosSuc (vl_i).FIIDSUCURSAL)
                           AND TS.FIIDTERRITORIO IN
                                   (SELECT T.FIIDTERRITORIO
                                      FROM SCSISGES.TAFXTERRITORIOS T
                                     WHERE T.FITIPOGEO = CSL_2);


                    IF VG_CUENTA <> CSL_0
                    THEN
                        UPDATE SCSISGES.TCFXSUCURSAL TS
                           SET TS.FIIDCANAL =
                                   vlcoll_datosSuc (vl_i).FIIDCANAL,
                               TS.FIIDPAIS = vlcoll_datosSuc (vl_i).FIIDPAIS,
                               TS.FIIDTERRITORIO =
                                   vlcoll_datosSuc (vl_i).FIIDTERRITORIO,
                               TS.FIIDZONA = vlcoll_datosSuc (vl_i).FIIDZONA,
                               TS.FIIDREGION =
                                   vlcoll_datosSuc (vl_i).FIIDREGION,
                               TS.FCNOMBRESUC =
                                   vlcoll_datosSuc (vl_i).fcnombresuc,
                               TS.FDFECACTUAL =
                                   vlcoll_datosSuc (vl_i).fdfecactual,
                               TS.FCTIPO = vlcoll_datosSuc (vl_i).fctipo,
                               TS.FDINICIOOPERACIONES =
                                   vlcoll_datosSuc (vl_i).fdiniciooperaciones,
                               TS.FNIVA = vlcoll_datosSuc (vl_i).FNIVA,
                               TS.FIESTATUS =
                                   vlcoll_datosSuc (vl_i).fiestatus,
                               TS.FCCALLE = vlcoll_datosSuc (vl_i).FCCALLE,
                               TS.FCNUMEXT = vlcoll_datosSuc (vl_i).FCNUMEXT,
                               TS.FCNUMINT = vlcoll_datosSuc (vl_i).FCNUMINT,
                               TS.FCCOLONIA =
                                   vlcoll_datosSuc (vl_i).FCCOLONIA,
                               TS.FCMUNICIPIO =
                                   vlcoll_datosSuc (vl_i).FCMUNICIPIO,
                               TS.FCESTADO = vlcoll_datosSuc (vl_i).FCESTADO,
                               TS.FCCP = vlcoll_datosSuc (vl_i).FCCP,
                               TS.FDMODIFICACION =
                                   vlcoll_datosSuc (vl_i).FDMODIFICACION,
                               TS.FCUSRMODIFICO =
                                   vlcoll_datosSuc (vl_i).FCUSRMODIFICO
                         WHERE     TS.FIIDSUCURSAL =
                                   TO_NUMBER (
                                       vlcoll_datosSuc (vl_i).FIIDSUCURSAL)
                               AND TS.FIIDTERRITORIO IN
                                       (SELECT T.FIIDTERRITORIO
                                          FROM SCSISGES.TAFXTERRITORIOS T
                                         WHERE T.FITIPOGEO = CSL_2);

                        COMMIT;
                    ELSE
                        INSERT INTO SCSISGES.TCFXSUCURSAL (
                                        FIIDPAIS,
                                        FIIDTERRITORIO,
                                        FIIDZONA,
                                        FIIDREGION,
                                        FIIDSUCURSAL,
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
                                 VALUES (
                                            vlcoll_datosSuc (vl_i).FIIDPAIS,
                                            vlcoll_datosSuc (vl_i).FIIDTERRITORIO,
                                            vlcoll_datosSuc (vl_i).FIIDZONA,
                                            vlcoll_datosSuc (vl_i).FIIDREGION,
                                            vlcoll_datosSuc (vl_i).FIIDSUCURSAL,
                                            vlcoll_datosSuc (vl_i).FIIDCANAL,
                                            vlcoll_datosSuc (vl_i).FINUMCECOSUC,
                                            vlcoll_datosSuc (vl_i).FCNOMBRESUC,
                                            vlcoll_datosSuc (vl_i).FDFECACTUAL,
                                            vlcoll_datosSuc (vl_i).FCTIPO,
                                            vlcoll_datosSuc (vl_i).FDINICIOOPERACIONES,
                                            vlcoll_datosSuc (vl_i).FNIVA,
                                            vlcoll_datosSuc (vl_i).FIESTATUS,
                                            vlcoll_datosSuc (vl_i).FIIDDIVISION,
                                            vlcoll_datosSuc (vl_i).FCCALLE,
                                            vlcoll_datosSuc (vl_i).FCNUMEXT,
                                            vlcoll_datosSuc (vl_i).FCNUMINT,
                                            vlcoll_datosSuc (vl_i).FCCOLONIA,
                                            vlcoll_datosSuc (vl_i).FCMUNICIPIO,
                                            vlcoll_datosSuc (vl_i).FCESTADO,
                                            vlcoll_datosSuc (vl_i).FCCP,
                                            vlcoll_datosSuc (vl_i).FIIDENTIDAD,
                                            vlcoll_datosSuc (vl_i).FDMODIFICACION,
                                            vlcoll_datosSuc (vl_i).FCUSRMODIFICO);

                        COMMIT;
                    END IF;
                END LOOP;

                COMMIT;
                vlcoll_datosSuc.DELETE;
            END;
        END LOOP;

        CLOSE cur_sucursales;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPPROCSUCURSALEKT');
    END SPPROCSUCURSALEKT;

    PROCEDURE SPPROCSUCCERRADA (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT)
    IS
        /*obtener todas las sucursales que ya no existan en la descarga de ceco*/
        CURSOR CUR_SUC
        IS
            SELECT TS.FIIDSUCURSAL,
                   TS.FIIDTERRITORIO,
                   TS.FIIDREGION,
                   TS.FIIDZONA,
                   TS.FIIDPAIS
              FROM SCSISGES.TCFXSUCURSAL TS
             WHERE     TS.FIIDSUCURSAL NOT IN
                           (SELECT EKT.FINUMECO
                              FROM TABLE (PA_TBSUCUREKT) EKT)
                   AND TS.FIESTATUS = CSL_1
                   AND TS.FIIDTERRITORIO IN
                           (SELECT T.FIIDTERRITORIO
                              FROM SCSISGES.TAFXTERRITORIOS T
                             WHERE T.FITIPOGEO = CSL_2);

        TYPE typ_curs_suc IS TABLE OF CUR_SUC%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcurs_suc   typ_curs_suc;
    BEGIN
        OPEN CUR_SUC;

        LOOP
            BEGIN
                FETCH CUR_SUC BULK COLLECT INTO vlcurs_suc;

                EXIT WHEN vlcurs_suc.COUNT = 0;

                FORALL vl_i IN vlcurs_suc.FIRST .. vlcurs_suc.LAST
                    UPDATE SCSISGES.TCFXSUCURSAL T
                       SET T.FIESTATUS = CSL_0
                     WHERE     T.FIIDSUCURSAL =
                               vlcurs_suc (vl_i).FIIDSUCURSAL
                           AND T.FIIDTERRITORIO =
                               vlcurs_suc (vl_i).FIIDTERRITORIO
                           AND T.FIIDZONA = vlcurs_suc (vl_i).FIIDZONA
                           AND T.FIIDREGION = vlcurs_suc (vl_i).FIIDREGION
                           AND T.FIIDPAIS = vlcurs_suc (vl_i).FIIDPAIS;
            END;

            vlcurs_suc.DELETE;
        END LOOP;

        CLOSE CUR_SUC;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPPROCSUCCERRADA');
    END SPPROCSUCCERRADA;

    PROCEDURE SPBAJATERRITORIO (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        --APLICAR BORRADO LOGICO
        UPDATE SCSISGES.TAFXTERRITORIOS TE
           SET TE.FIESTATUS = CSL_0,
               TE.FCUSRMODIFICO = CSL_USRSISGES,
               TE.FDMODIFICACION = SYSDATE
         WHERE     NOT EXISTS
                       (SELECT EKT.FIIDPAIS, EKT.FIIDCCBISABUELO
                          FROM TABLE (PA_TBSUCUREKT) EKT
                         WHERE     EKT.FIIDPAIS = TE.FIIDPAIS
                               AND EKT.FIIDCCBISABUELO = TE.FIIDTERRITORIO)
               AND TE.FITIPOGEO = CSL_2;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPBAJATERRITORIO');
    END SPBAJATERRITORIO;

    PROCEDURE SPBAJAZONAS (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        UPDATE SCSISGES.TAFXZONAS TZ
           SET TZ.FIESTATUS = CSL_0,
               TZ.FCUSRMODIFICO = CSL_USRSISGES,
               TZ.FDMODIFICACION = SYSDATE
         WHERE     NOT EXISTS
                       (SELECT EKT.FIIDPAIS,
                               EKT.FIIDCCBISABUELO,
                               EKT.FIIDCCABUELO
                          FROM TABLE (PA_TBSUCUREKT) EKT
                         WHERE     EKT.FIIDPAIS = TZ.FIIDPAIS
                               AND EKT.FIIDCCBISABUELO = TZ.FIIDTERRITORIO
                               AND EKT.FIIDCCABUELO = TZ.FIIDZONA)
               AND TZ.FIIDTERRITORIO IN
                       (SELECT T.FIIDTERRITORIO
                          FROM SCSISGES.TAFXTERRITORIOS T
                         WHERE T.FITIPOGEO = CSL_2 AND T.FIIDPAIS = CSL_1);

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPBAJAZONAS');
    END SPBAJAZONAS;

    PROCEDURE SPBAJAREGIONES (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT)
    IS
    BEGIN
        --BORRADO LOGICO
        UPDATE SCSISGES.TAFXREGIONES TREG
           SET TREG.FIESTATUS = CSL_0,
               TREG.FDMODIFICACION = SYSDATE,
               TREG.FCUSRMODIFICO = CSL_USRSISGES
         WHERE     NOT EXISTS
                       (SELECT EKT.FIIDPAIS,
                               EKT.FIIDCCBISABUELO,
                               EKT.FIIDCCABUELO,
                               EKT.FIIDCCPADRE
                          FROM TABLE (PA_TBSUCUREKT) EKT
                         WHERE     EKT.FIIDPAIS = TREG.FIIDPAIS
                               AND EKT.FIIDCCBISABUELO = TREG.FIIDTERRITORIO
                               AND EKT.FIIDCCABUELO = TREG.FIIDZONA
                               AND EKT.FIIDCCPADRE = TREG.FIIDREGION)
               AND TREG.FIIDTERRITORIO IN
                       (SELECT T.FIIDTERRITORIO
                          FROM SCSISGES.TAFXTERRITORIOS T
                         WHERE T.FITIPOGEO = CSL_2 AND T.FIIDPAIS = CSL_1);


        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'PQFXGEOGRAFIAMXEKT.SPBAJAREGIONES');
    END SPBAJAREGIONES;

    PROCEDURE SPPROCESAEKT (PA_NOMBREPROC   IN     VARCHAR2,
                            PA_CODERROR        OUT INTEGER,
                            PA_DESERROR        OUT VARCHAR2)
    IS
        CURSOR cur_sucElektra
        IS
            SELECT FINUMECO,
                   FCIDCANAL,
                   FCCANAL,
                   FIIDPAIS,
                   FCPAIS,
                   FIIDCCBISABUELO,
                   FCNOMBREBISABUELO,
                   FIIDCCABUELO,
                   FCNOMBREABUELO,
                   FIIDCCPADRE,
                   FCNOMBREPADRE,
                   FIIDCC,
                   REGEXP_REPLACE (FCNOMECO, '(Ñ)', '�') AS FCNOMECO,
                   FITIPOABUELO,
                   FDFECHAAPACT,
                   FCTIPOOP,
                   FIIDENTIDAD,
                   FCNOMBREENTIDAD,
                   FCCALLE,
                   FCNUMEXT,
                   FCNUMINT,
                   FCCOLONIA,
                   FCMUNICIPIO,
                   FCESTADO,
                   FICP,
                   FIIVA
              FROM (  SELECT FINUMECO,
                             FCIDCANAL,
                             FCCANAL,
                             FIIDPAIS,
                             FCPAIS,
                             FIIDCCBISABUELO,
                             FCNOMBREBISABUELO,
                             FIIDCCABUELO,
                             FCNOMBREABUELO,
                             FIIDCCPADRE,
                             FCNOMBREPADRE,
                             FIIDCC,
                             FCNOMECO,
                             MAX (FITIPOABUELO)  AS FITIPOABUELO,
                             MAX (FDFECHAAPACT)  AS FDFECHAAPACT,
                             MAX (FCTIPOOP)      AS FCTIPOOP,
                             MAX (FIIDENTIDAD)   AS FIIDENTIDAD,
                             MAX (FCNOMBREENTIDAD) AS FCNOMBREENTIDAD,
                             MAX (FCCALLE)       AS FCCALLE,
                             MAX (FCNUMEXT)      AS FCNUMEXT,
                             MAX (FCNUMINT)      AS FCNUMINT,
                             MAX (FCCOLONIA)     AS FCCOLONIA,
                             MAX (FCMUNICIPIO)   AS FCMUNICIPIO,
                             MAX (FCESTADO)      AS FCESTADO,
                             MAX (FICP)          AS FICP,
                             MAX (FIIVA)         AS FIIVA
                        FROM (SELECT DISTINCT FINUMECO,
                                              FCIDCANAL,
                                              FCCANAL,
                                              FIIDPAIS,
                                              FCPAIS,
                                              FIIDCCBISABUELO,
                                              FCNOMBREBISABUELO,
                                              FIIDCCABUELO,
                                              FITIPOABUELO,
                                              FCNOMBREABUELO,
                                              FIIDCCPADRE,
                                              FCNOMBREPADRE,
                                              FIIDCC,
                                              FCNOMECO,
                                              FDFECHAAPACT,
                                              FCTIPOOP,
                                              FIIDENTIDAD,
                                              FCNOMBREENTIDAD,
                                              FCCALLE,
                                              FCNUMEXT,
                                              FCNUMINT,
                                              FCCOLONIA,
                                              FCMUNICIPIO,
                                              FCESTADO,
                                              FICP,
                                              FIIVA
                                FROM SCSISGES.TAGEOGRAFBAZEKT T
                               WHERE     T.FIIDENTIDAD = CSL_1
                                     AND T.FCTIPOOP LIKE
                                             '%' || CSL_NOESPECIALIZADO || '%'
                                     AND T.FCIDCANAL > CSL_0
                                     AND T.FCSTATUS_DESC IN
                                             (CSL_ACTIVO, CSL_PORCERRAR)
                                     AND T.FIIDPAIS = CSL_1) TT
                    GROUP BY FINUMECO,
                             FCIDCANAL,
                             FCCANAL,
                             FIIDPAIS,
                             FCPAIS,
                             FIIDCCBISABUELO,
                             FCNOMBREBISABUELO,
                             FIIDCCABUELO,
                             FCNOMBREABUELO,
                             FIIDCCPADRE,
                             FCNOMBREPADRE,
                             FIIDCC,
                             FCNOMECO);

        TYPE typ_Cur_SucElektra IS TABLE OF cur_sucElektra%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcur_SucElektra   typ_Cur_SucElektra;

        vltab_datosEkt     SCSISGES.TYTBGEOGRAFIAEKT;

        vl_idproceso       NUMBER := 0;
    BEGIN
        --se registra el inicio del proceso de geografias
        vl_idproceso :=
            SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        PA_NOMBREPROC,
                                        SYSDATE,
                                        NULL,
                                        CSL_0,
                                        CSL_0,                --id del proceso
                                        CSL_1                 --tipo ejecucion
                                             );
        --pasar a collection las sucursales elektra
        vltab_datosEkt := NEW SCSISGES.TYTBGEOGRAFIAEKT ();

        OPEN cur_sucElektra;

        LOOP
            FETCH cur_sucElektra BULK COLLECT INTO vlcur_SucElektra;

            EXIT WHEN vlcur_SucElektra.COUNT = 0;

            FOR vl_i IN vlcur_SucElektra.FIRST .. vlcur_SucElektra.LAST
            LOOP
                vltab_datosEkt.EXTEND;
                vltab_datosEkt (vltab_datosEkt.LAST) :=
                    NEW SCSISGES.TYOBJGEOGRAFIAEKT (
                            vlcur_SucElektra (vl_i).FCIDCANAL,
                            vlcur_SucElektra (vl_i).FCCANAL,
                            vlcur_SucElektra (vl_i).FIIDPAIS,
                            vlcur_SucElektra (vl_i).FCPAIS,
                            vlcur_SucElektra (vl_i).FIIDCCBISABUELO,
                            NULL,                                 --TIPOABUELO
                            vlcur_SucElektra (vl_i).FCNOMBREBISABUELO,
                            vlcur_SucElektra (vl_i).FIIDCCABUELO,
                            vlcur_SucElektra (vl_i).FITIPOABUELO,
                            vlcur_SucElektra (vl_i).FCNOMBREABUELO,
                            vlcur_SucElektra (vl_i).FIIDCCPADRE,
                            NULL,                                --FITIPOPADRE
                            vlcur_SucElektra (vl_i).FCNOMBREPADRE,
                            vlcur_SucElektra (vl_i).FINUMECO,
                            vlcur_SucElektra (vl_i).FIIDCC,
                            vlcur_SucElektra (vl_i).FCNOMECO,
                            CSL_ACTIVO,                        --FCSTATUS_DESC
                            vlcur_SucElektra (vl_i).FDFECHAAPACT,
                            NULL,                               --FECHA CIERRE
                            vlcur_SucElektra (vl_i).FCTIPOOP,
                            vlcur_SucElektra (vl_i).FIIDENTIDAD,
                            vlcur_SucElektra (vl_i).FCNOMBREENTIDAD,
                            vlcur_SucElektra (vl_i).FCCALLE,
                            vlcur_SucElektra (vl_i).FCNUMEXT,
                            vlcur_SucElektra (vl_i).FCNUMINT,
                            vlcur_SucElektra (vl_i).FCCOLONIA,
                            vlcur_SucElektra (vl_i).FCMUNICIPIO,
                            vlcur_SucElektra (vl_i).FCESTADO,
                            vlcur_SucElektra (vl_i).FICP,
                            vlcur_SucElektra (vl_i).FIIVA);
            END LOOP;
        END LOOP;

        CLOSE cur_sucElektra;



        --alta de paises
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPPROCESAPAIS (vltab_datosEkt);
        --alta y actualizacion de territorios
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPPROCTERRITORIO (vltab_datosEkt);
        --procesar bajas de territorios
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPBAJATERRITORIO (vltab_datosEkt);

        --alta y actualizacion de zonas
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPPROCZONAS (vltab_datosEkt);
        --dar de baja zonas que ya no existan
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPBAJAZONAS (vltab_datosEkt);
        --alta y actualizacion de regiones
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPPROCREGIONES (vltab_datosEkt);
        --dar de baja regiones que ya no existen
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPBAJAREGIONES (vltab_datosEkt);
        --alta y actualizacion de sucursales
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPPROCSUCURSALEKT (vltab_datosEkt);
        SCSISGES.PQFXGEOGRAFIAMXEKT.SPPROCSUCCERRADA (vltab_datosEkt);
        --liberar memoria
        vltab_datosEkt.DELETE;

        --se registra la finalizacion del proceso de geografias
        vl_idproceso :=
            SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        PA_NOMBREPROC,
                                        SYSDATE,
                                        NULL,
                                        CSL_1,
                                        vl_idproceso,
                                        CSL_1              --tipo de ejecucion
                                             );
        --indicar que finalizo con exito
        pa_codError := CSL_1;
    EXCEPTION
        WHEN OTHERS
        THEN
            pa_codError := SQLCODE;
            pa_desError := SUBSTR (SQLERRM, 0, 200);
            SCSISGES.SPERRORES (SYSDATE,
                                pa_codError,
                                pa_desError,
                                'PQFXGEOGRAFIAMXEKT.SPPROCESAEKTBAZ');
            --se registra la finalizacion con error del proceso de geografias
            vl_idproceso :=
                SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                            EXTRACT (MONTH FROM SYSDATE),
                                            EXTRACT (DAY FROM SYSDATE),
                                            TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                            TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                            PA_NOMBREPROC,
                                            SYSDATE,
                                            pa_desError,
                                            CSL_2,           --status de error
                                            vl_idproceso,
                                            CSL_1);
    END SPPROCESAEKT;
END PQFXGEOGRAFIAMXEKT;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXGEOGRAFIAMXEKT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXGEOGRAFIAMXEKT" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQFXGEOGRAFIAMXEKT" TO "USRSISGES";
