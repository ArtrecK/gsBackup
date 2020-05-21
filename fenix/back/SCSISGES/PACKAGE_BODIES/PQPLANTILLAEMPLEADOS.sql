--------------------------------------------------------
--  DDL for Package Body PQPLANTILLAEMPLEADOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQPLANTILLAEMPLEADOS" 
IS
    CSG_0     CONSTANT PLS_INTEGER := 0;
    CSG_1     CONSTANT PLS_INTEGER := 1;
    CSG_2     CONSTANT PLS_INTEGER := 2;
    CSG_3     CONSTANT PLS_INTEGER := 3;
    VL_USER   CONSTANT VARCHAR2 (10) := 'USRSISGES';

    PROCEDURE SPCARGAPLANTILLA (PA_FNNEGOCIO    IN     VARCHAR2,
                                PA_FNCODERROR      OUT INTEGER,
                                PA_FCDESERROR      OUT VARCHAR2)
    IS
        --CURSOR QUE TRAE LAS ALTAS
        CURSOR cur_EmpAltas
        IS
            SELECT DISTINCT
                   T.FNEMPLEADO,
                   T.fcnombre,
                   T.fcapaterno,
                   T.fcamaterno,
                   T.fnfuncion,
                   T.fnempleadojefe,
                   T.fncc,
                   T.fcnegocio,
                   (SELECT TC.FIIDLABORA
                      FROM SCSISGES.TCLABORADESC TC
                     WHERE T.FNLABORA = TC.FIIDLABORA)
                       AS FNLABORA,
                   T.fdalta,
                   T.fisituacion,
                   SC.FIIDSUCURSAL
                       AS SUCURSAL,
                   (     SELECT TPS.FIIDPERFIL
                           FROM SCSISGES.TCPERFILESEMP TPS
                          WHERE     TPS.FNFUNCIONSAP = T.FNFUNCION
                                AND TPS.FNTIPOPERFIL = CSG_1
                    FETCH FIRST 1 ROW ONLY)
                       AS PERFIL
              FROM SCSISGES.TAEMPLEADO t, SCSISGES.TCFXSUCURSAL SC
             WHERE     T.fcnegocio = PA_FNNEGOCIO
                   AND t.FISITUACION = CSG_1
                   AND SC.FINUMCECOSUC = T.FNCC
                   AND SC.FIIDCANAL > CSG_0
                   AND T.FNCC > CSG_0
                   AND T.FNEMPLEADO > CSG_0
                   AND T.FNFUNCION IN
                           (SELECT DISTINCT TP.FNFUNCIONSAP
                              FROM SCSISGES.TCPERFILESEMP TP
                             WHERE     TP.FIIDPERFIL IN (CSG_1, CSG_2, CSG_3)
                                   AND TP.FNTIPOPERFIL = CSG_1)
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM SCSISGES.TAEMPLEADOPF te
                             WHERE TE.FNEMPLEADO = t.fnempleado);

        --CURSOR QUE TRAE LAS BAJAS
        CURSOR cur_EmpBajas (
            PA_SEMANA    NUMBER,
            PA_ANIO      NUMBER)
        IS
            SELECT TQ.FNEMPLEADO,
                   TQ.FCNOMBRE,
                   TQ.FCAPATERNO,
                   TQ.FCAMATERNO,
                   TQ.FNFUNCION,
                   TQ.FNEMPLEADOJEFE,
                   TQ.FNCC,
                   TQ.FCNEGOCIO,
                   TQ.FNLABORA,
                   TQ.FDBAJA,
                   TQ.FDALTA,
                   TQ.FISITUACION,
                   TQ.SUCURSAL,
                   TQ.PERFIL,
                   TQ.SEMANA,
                   TQ.ANIO
              FROM (SELECT DISTINCT
                           T.FNEMPLEADO,
                           T.fcnombre,
                           T.fcapaterno,
                           T.fcamaterno,
                           T.fnfuncion,
                           T.fnempleadojefe,
                           T.fncc,
                           T.fcnegocio,
                           T.fnlabora,
                           CASE
                               WHEN T.FDBAJA IS NULL
                               THEN
                                   SYSDATE
                               WHEN TRUNC (T.FDBAJA) =
                                    TO_DATE ('01/01/1901', 'DD/MM/YYYY')
                               THEN
                                   SYSDATE
                               ELSE
                                   T.FDBAJA
                           END
                               AS FDBAJA,
                           T.fdalta,
                           T.fisituacion,
                           (SELECT FIIDSUCURSAL
                              FROM SCSISGES.TCFXSUCURSAL SC
                             WHERE SC.FINUMCECOSUC = T.FNCC)
                               AS SUCURSAL,
                           (     SELECT TPS.FIIDPERFIL
                                   FROM SCSISGES.TCPERFILESEMP TPS
                                  WHERE     TPS.FNFUNCIONSAP = T.FNFUNCION
                                        AND TPS.FNTIPOPERFIL = CSG_1
                            FETCH FIRST 1 ROW ONLY)
                               AS PERFIL,
                           PA_SEMANA
                               AS SEMANA,
                           PA_ANIO
                               AS ANIO
                      FROM SCSISGES.TAEMPLEADO t
                     WHERE     T.fcnegocio = PA_FNNEGOCIO
                           AND t.FISITUACION = CSG_2
                           AND t.fncc > CSG_0
                           AND T.FNFUNCION IN
                                   (SELECT DISTINCT TP.FNFUNCIONSAP
                                      FROM SCSISGES.TCPERFILESEMP TP
                                     WHERE TP.FIIDPERFIL IN
                                               (CSG_1, CSG_2, CSG_3))
                           AND EXISTS
                                   (SELECT NULL
                                      FROM SCSISGES.TAEMPLEADOPF TD
                                     WHERE TD.FNEMPLEADO = T.FNEMPLEADO)) TQ
            UNION
            SELECT DISTINCT TE.fnempleado,
                            TE.fcnombre,
                            TE.fcapaterno,
                            TE.fcamaterno,
                            TE.fnfuncionsap AS FNFUNCION,
                            TE.fnempleadojefe,
                            TE.fncc,
                            TE.fcnegocio,
                            TE.fiidlabora   AS FNLABORA,
                            TE.fdbaja,
                            TE.fdalta,
                            TE.fisituacion,
                            TE.fiidsucursal AS SUCURSAL,
                            TE.fiidperfil   AS PERFIL,
                            PA_SEMANA       SEMANA,
                            PA_ANIO         ANIO
              FROM SCSISGES.TAEMPLEADOPF TE
             WHERE     TE.FISITUACION = CSG_1
                   AND TE.FCNEGOCIO = PA_FNNEGOCIO
                   AND TE.FNCC > CSG_0
                   AND TE.FIIDSUCURSAL > CSG_0
                   AND NOT EXISTS
                           (SELECT NULL
                              FROM SCSISGES.TAEMPLEADO TD
                             WHERE TD.FNEMPLEADO = TE.FNEMPLEADO);

        --CURSOR QUE ACTUALIZA LOS CAMBIOS
        CURSOR cur_cambios (
            PA_SEMANA    NUMBER,
            PA_ANIO      NUMBER)
        IS
            SELECT DISTINCT
                   FNEMPLEADO,
                   fcnombre,
                   fcapaterno,
                   fcamaterno,
                   fnfuncion,
                   fncc,
                   fcnegocio,
                   fnlabora,
                   FDBAJA,
                   fdalta,
                   fisituacion,
                   FNEMPLEADOJEFE,
                   SC.FIIDSUCURSAL
                       AS SUCURSAL,
                   (     SELECT TPS.FIIDPERFIL
                           FROM SCSISGES.TCPERFILESEMP TPS
                          WHERE     TPS.FNFUNCIONSAP = FNFUNCION
                                AND TPS.FNTIPOPERFIL = CSG_1
                    FETCH FIRST 1 ROW ONLY)
                       AS PERFIL,
                   PA_SEMANA
                       AS SEMANA,
                   PA_ANIO
                       AS ANIO
              FROM SCSISGES.TCFXSUCURSAL  SC,
                   (SELECT DISTINCT
                           T.FNEMPLEADO,
                           t.fcnombre,
                           t.fcapaterno,
                           t.fcamaterno,
                           CASE
                               WHEN T.fnfuncion <> PF.FNFUNCIONSAP THEN CSG_1
                               ELSE CSG_0
                           END
                               AS INDFUNCION,
                           T.fnempleadojefe,
                           CASE
                               WHEN T.fncc <> PF.FNCC THEN CSG_1
                               ELSE CSG_0
                           END
                               AS INDCECO,
                           CASE
                               WHEN T.fcnegocio <> PF.FCNEGOCIO THEN CSG_1
                               ELSE CSG_0
                           END
                               AS INDNEGOCIO,
                           CASE
                               WHEN T.fnlabora <> PF.FIIDLABORA THEN CSG_1
                               ELSE CSG_0
                           END
                               AS INDLABORA,
                           CASE
                               WHEN T.FNEMPLEADOJEFE IS NULL
                               THEN
                                   CSG_0
                               WHEN T.FNEMPLEADOJEFE <> PF.FNEMPLEADOJEFE
                               THEN
                                   CSG_1
                               ELSE
                                   CSG_0
                           END
                               INDJEFE,
                           T.fnfuncion,
                           T.fncc,
                           T.fcnegocio,
                           T.fnlabora,
                           T.FDBAJA,
                           T.fdalta,
                           T.fisituacion
                      FROM SCSISGES.TAEMPLEADO t, SCSISGES.TAEMPLEADOPF PF
                     WHERE     T.FNEMPLEADO = PF.FNEMPLEADO
                           AND T.FNCC = pf.fncc + CSG_0
                           AND t.fcnegocio = PA_FNNEGOCIO
                           AND T.FISITUACION = CSG_1
                           AND T.FNEMPLEADO > CSG_0
                           AND t.fncc > CSG_0
                           AND t.fnempleadojefe > CSG_0
                           AND pf.fnempleado > CSG_0
                           AND pf.fiidsucursal > CSG_0
                           AND t.fnfuncion IN
                                   (SELECT TP.FNFUNCIONSAP
                                      FROM SCSISGES.TCPERFILESEMP TP
                                     WHERE     TP.FIIDPERFIL IN
                                                   (CSG_1, CSG_2, CSG_3)
                                           AND TP.FNTIPOPERFIL = CSG_1))
             WHERE     SC.FINUMCECOSUC = FNCC
                   AND (   INDFUNCION = CSG_1
                        OR INDCECO = CSG_1
                        OR INDNEGOCIO = CSG_1
                        OR INDJEFE = CSG_1
                        OR INDLABORA = CSG_1);

        TYPE typ_CurEmpAltas IS TABLE OF cur_EmpAltas%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcur_EmpAltas     typ_CurEmpAltas;

        TYPE typ_CurBajas IS TABLE OF cur_EmpBajas%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcur_EmpBajas     typ_CurBajas;

        TYPE typ_curCambios IS TABLE OF cur_Cambios%ROWTYPE
            INDEX BY PLS_INTEGER;

        vlcur_EmpCambios   typ_curCambios;

        VL_SEMANA          NUMBER := CSG_0;
        VL_ANIO            NUMBER := CSG_0;
        VL_BANDERA         NUMBER := 0;
    --inicia la funcion
    BEGIN
        BEGIN
            --REGISTRAR FINALIZACION DE PROCESO
            VL_BANDERA :=
                SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                            EXTRACT (MONTH FROM SYSDATE),
                                            EXTRACT (DAY FROM SYSDATE),
                                            TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora de inicio del proceso
                                            TO_CHAR (SYSDATE, 'HH:MI:SS'), --hora fin del proceso
                                            'PKPTEMPLEADOS',
                                            SYSDATE,      --FECHA DE EJECUCION
                                            NULL,      --DESCRIPCION DEL ERROR
                                            CSG_0, --STATUS, INDICAR FINAL DE MAPA
                                            CSG_0,            --ID DEL PROCESO
                                            CSG_1 --indicamos el inicio de un mapa
                                                 );
        EXCEPTION
            WHEN OTHERS
            THEN
                SCSISGES.SPERRORES (SYSDATE,
                                    SQLCODE,
                                    SUBSTR (SQLERRM, 0, 200),
                                    'PQPLANTILLAEMPLEADOS.SPCARGAPLANTILLA');
        END;

        SELECT FISEMANA, FIANIO
          INTO VL_SEMANA, VL_ANIO
          FROM SCSISGES.TCCALENDARIOEKT
         WHERE TRUNC (FDFECHA) = TRUNC (SYSDATE);

        --CURSOR DE ALTAS
        OPEN cur_EmpAltas;

        LOOP
            BEGIN
                FETCH cur_EmpAltas BULK COLLECT INTO vlcur_EmpAltas;

                EXIT WHEN vlcur_EmpAltas.COUNT = 0;

                FORALL vl_i IN vlcur_EmpAltas.FIRST .. vlcur_EmpAltas.COUNT
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.TAEMPLEADOPF (fnempleado,
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
                         VALUES (vlcur_EmpAltas (vl_i).FNEMPLEADO,
                                 vlcur_EmpAltas (vl_i).fcnombre,
                                 vlcur_EmpAltas (vl_i).fcapaterno,
                                 vlcur_EmpAltas (vl_i).fcamaterno,
                                 vlcur_EmpAltas (vl_i).fnfuncion,
                                 vlcur_EmpAltas (vl_i).fnempleadojefe,
                                 vlcur_EmpAltas (vl_i).fncc,
                                 vlcur_EmpAltas (vl_i).fcnegocio,
                                 vlcur_EmpAltas (vl_i).fnlabora,
                                 SYSDATE,
                                 SYSDATE,
                                 vlcur_EmpAltas (vl_i).fdalta,
                                 vlcur_EmpAltas (vl_i).fisituacion,
                                 vlcur_EmpAltas (vl_i).SUCURSAL,
                                 vlcur_EmpAltas (vl_i).PERFIL,
                                 CSG_1,
                                 VL_USER,
                                 SYSDATE,
                                 VL_USER,
                                 SYSDATE);

                COMMIT;
                vlcur_EmpAltas.DELETE;
            EXCEPTION
                WHEN OTHERS
                THEN
                    PA_FNCODERROR := SQLCODE;
                    PA_FCDESERROR := SUBSTR (SQLERRM, 0, 200);
                    SCSISGES.SPERRORES (
                        SYSDATE,
                        SQLCODE,
                        SUBSTR (SQLERRM, 0, 200),
                        'PQPLANTILLAEMPLEADOS.SPCARGAPLANTILLA');
            END;
        END LOOP;

        CLOSE cur_EmpAltas;

        --CURSOS DE BAJAS
        OPEN cur_EmpBajas (VL_SEMANA, VL_ANIO);

        LOOP
            BEGIN
                FETCH cur_EmpBajas BULK COLLECT INTO vlcur_EmpBajas;

                EXIT WHEN vlcur_EmpBajas.COUNT = 0;

                FORALL vl_i IN vlcur_EmpBajas.FIRST .. vlcur_EmpBajas.COUNT
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.THEMPLEADOPF (fnempleado,
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
                                                       FDFECHAREGISTRO,
                                                       FNSEMANA,
                                                       FNANIO,
                                                       fcusrcreacion,
                                                       fdcreacion,
                                                       fcusrmodifico,
                                                       fdmodifico)
                         VALUES (vlcur_EmpBajas (vl_i).FNEMPLEADO,
                                 vlcur_EmpBajas (vl_i).fcnombre,
                                 vlcur_EmpBajas (vl_i).fcapaterno,
                                 vlcur_EmpBajas (vl_i).fcamaterno,
                                 vlcur_EmpBajas (vl_i).fnfuncion,
                                 vlcur_EmpBajas (vl_i).fnempleadojefe,
                                 vlcur_EmpBajas (vl_i).fncc,
                                 vlcur_EmpBajas (vl_i).fcnegocio,
                                 vlcur_EmpBajas (vl_i).fnlabora,
                                 SYSDATE,
                                 vlcur_EmpBajas (vl_i).fdbaja,
                                 vlcur_EmpBajas (vl_i).fdalta,
                                 vlcur_EmpBajas (vl_i).fisituacion,
                                 vlcur_EmpBajas (vl_i).SUCURSAL,
                                 vlcur_EmpBajas (vl_i).PERFIL,
                                 CSG_1,
                                 SYSDATE,
                                 vlcur_EmpBajas (vl_i).SEMANA,
                                 vlcur_EmpBajas (vl_i).ANIO,
                                 VL_USER,
                                 SYSDATE,
                                 VL_USER,
                                 SYSDATE);

                COMMIT;

                FORALL vl_i IN vlcur_EmpBajas.FIRST .. vlcur_EmpBajas.COUNT
                    DELETE FROM SCSISGES.TAEMPLEADOPF P
                          WHERE P.FNEMPLEADO =
                                vlcur_EmpBajas (vl_i).FNEMPLEADO;

                COMMIT;
                vlcur_EmpBajas.DELETE;
            EXCEPTION
                WHEN OTHERS
                THEN
                    PA_FNCODERROR := SQLCODE;
                    PA_FCDESERROR := SUBSTR (SQLERRM, 0, 200);
                    SCSISGES.SPERRORES (
                        SYSDATE,
                        PA_FNCODERROR,
                        PA_FCDESERROR,
                        'PQPLANTILLAEMPLEADOS.SPCARGAPLANTILLA');
            END;
        END LOOP;

        CLOSE cur_EmpBajas;

        --CURSOR DE CAMBIOS
        OPEN cur_cambios (VL_SEMANA, VL_ANIO);

        LOOP
            BEGIN
                FETCH cur_cambios BULK COLLECT INTO vlcur_EmpCambios;

                EXIT WHEN vlcur_EmpCambios.COUNT = 0;

                FORALL vl_i
                    IN vlcur_EmpCambios.FIRST .. vlcur_EmpCambios.COUNT
                    UPDATE SCSISGES.TAEMPLEADOPF PF
                       SET PF.FNFUNCIONSAP =
                               vlcur_EmpCambios (vl_i).fnfuncion,
                           PF.FNEMPLEADOJEFE =
                               vlcur_EmpCambios (vl_i).fnempleadojefe,
                           PF.FNCC = vlcur_EmpCambios (vl_i).fncc,
                           PF.FIIDLABORA = vlcur_EmpCambios (vl_i).fnlabora
                     WHERE pf.fnempleado = vlcur_EmpCambios (vl_i).FNEMPLEADO;

                COMMIT;

                FORALL vl_i
                    IN vlcur_EmpCambios.FIRST .. vlcur_EmpCambios.COUNT
                    --SE INSERTA EN LA TABLA
                    INSERT INTO SCSISGES.THEMPLEADOPF (fnempleado,
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
                                                       FDFECHAREGISTRO,
                                                       FNSEMANA,
                                                       FNANIO,
                                                       fcusrcreacion,
                                                       fdcreacion,
                                                       fcusrmodifico,
                                                       fdmodifico)
                         VALUES (vlcur_EmpCambios (vl_i).FNEMPLEADO,
                                 vlcur_EmpCambios (vl_i).fcnombre,
                                 vlcur_EmpCambios (vl_i).fcapaterno,
                                 vlcur_EmpCambios (vl_i).fcamaterno,
                                 vlcur_EmpCambios (vl_i).fnfuncion,
                                 vlcur_EmpCambios (vl_i).fnempleadojefe,
                                 vlcur_EmpCambios (vl_i).fncc,
                                 vlcur_EmpCambios (vl_i).fcnegocio,
                                 vlcur_EmpCambios (vl_i).fnlabora,
                                 SYSDATE,
                                 vlcur_EmpCambios (vl_i).fdbaja,
                                 vlcur_EmpCambios (vl_i).fdalta,
                                 vlcur_EmpCambios (vl_i).fisituacion,
                                 vlcur_EmpCambios (vl_i).SUCURSAL,
                                 vlcur_EmpCambios (vl_i).PERFIL,
                                 CSG_1,
                                 SYSDATE,
                                 vlcur_EmpCambios (vl_i).SEMANA,
                                 vlcur_EmpCambios (vl_i).ANIO,
                                 VL_USER,
                                 SYSDATE,
                                 VL_USER,
                                 SYSDATE);

                COMMIT;
                vlcur_EmpCambios.DELETE;
            EXCEPTION
                WHEN OTHERS
                THEN
                    PA_FNCODERROR := SQLCODE;
                    PA_FCDESERROR := SUBSTR (SQLERRM, 0, 200);
                    SCSISGES.SPERRORES (
                        SYSDATE,
                        PA_FNCODERROR,
                        PA_FCDESERROR,
                        'PQPLANTILLAEMPLEADOS.SPCARGAPLANTILLA');
            END;
        END LOOP;

        CLOSE cur_cambios;

        --se registra la finalizacion del proceso
        VL_BANDERA :=
            SCSISGES.fncontrolprocesos (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        'PKPTEMPLEADOS',
                                        SYSDATE,
                                        NULL,          --DESCRIPCION DEL ERROR
                                        CSG_1, --STATUS, INDICAR FINAL DE MAPA
                                        VL_BANDERA,           --ID DEL PROCESO
                                        CSG_1);

        --indicar que finalizo con exito
        PA_FNCODERROR := CSG_1;
        PA_FCDESERROR := 'OK';
    EXCEPTION
        WHEN OTHERS
        THEN
            PA_FNCODERROR := CSG_2;
            PA_FCDESERROR := 'FAIL';
            SCSISGES.SPERRORES (SYSDATE,
                                PA_FNCODERROR,
                                PA_FCDESERROR,
                                'PQPLANTILLAEMPLEADOS.SPCARGAPLANTILLA');

            --se registra la finalizacion con error del proceso
            VL_BANDERA :=
                SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                            EXTRACT (MONTH FROM SYSDATE),
                                            EXTRACT (DAY FROM SYSDATE),
                                            TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                            TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                            'PKPTEMPLEADOS',
                                            SYSDATE,
                                            PA_FCDESERROR,
                                            CSG_2,           --status de error
                                            VL_BANDERA,
                                            CSG_1);
    END SPCARGAPLANTILLA;
END PQPLANTILLAEMPLEADOS;

/

  GRANT EXECUTE ON "SCSISGES"."PQPLANTILLAEMPLEADOS" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PQPLANTILLAEMPLEADOS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQPLANTILLAEMPLEADOS" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQPLANTILLAEMPLEADOS" TO "USRSISGES";
