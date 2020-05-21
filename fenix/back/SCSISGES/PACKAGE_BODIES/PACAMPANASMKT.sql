--------------------------------------------------------
--  DDL for Package Body PACAMPANASMKT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PACAMPANASMKT" 
IS
   -- AUTHOR  : 149766
   -- CREATED : 26/03/2019 06:19:22 P. M.
   -- PURPOSE : PROCESAMIENTO DE CAMPANAS MARKETING

   CSG_0    CONSTANT INTEGER := 0;
   CSG_1    CONSTANT INTEGER := 1;
   CSG_N1   CONSTANT INTEGER := -1;
   CSG_2    CONSTANT INTEGER := 2;


   PROCEDURE SPPROCESAMKT (PA_PAIS           IN     NUMBER,
                           PA_NEGOCIO        IN     NUMBER,
                           PA_TAMANIOBULK    IN     NUMBER,
                           PA_FNFINALIZOWF      OUT NUMBER,
                           PA_FNFINALIZOSP      OUT NUMBER,
                           PA_CODERROR          OUT INTEGER,
                           PA_DESCERROR         OUT VARCHAR2)
   IS
      VL_TIPOGEOGRAFIA   NUMBER := 0;
      VL_STATUSWF        NUMBER := 0;
      VL_CODERROR        NUMBER := 0;
      VL_DESERROR        VARCHAR2 (200);
      VL_IDPROCESO       NUMBER := 0;
   BEGIN
      --VERIFICAMOS SI YA TERMINO EL MAPA DE MARKETING
      SCSISGES.SPCONSULTAPROC ('WF_FENIXCAMPMKT', CSG_0, VL_STATUSWF);

      IF VL_STATUSWF = CSG_1
      THEN
         PA_FNFINALIZOWF := CSG_1;               --INDICAMOS QUE FINALIZO MAPA

         --SE REGISTRA EL INICIO DEL PROCESO DE MARKETING BACK
         VL_IDPROCESO :=
            SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        'SPPROCESAMKT',
                                        SYSDATE,
                                        NULL,
                                        CSG_0,
                                        CSG_0,                --ID DEL PROCESO
                                        CSG_1                 --TIPO EJECUCION
                                             );

         --PRIMERO RESPALDAMOS LOS DATOS
         SCSISGES.PACAMPANASMKT.SPRESPALDO (PA_PAIS,
                                            PA_CODERROR,
                                            PA_DESCERROR);

         IF PA_CODERROR IS NULL
         THEN
            CASE
               WHEN PA_NEGOCIO = CSG_1
               THEN
                  VL_TIPOGEOGRAFIA := CSG_2;
               WHEN PA_NEGOCIO = CSG_2
               THEN
                  VL_TIPOGEOGRAFIA := CSG_1;
            END CASE;



            FOR CAMP
               IN (SELECT TCAMP.FIIDCAMPANA
                     FROM SCSISGES.TCCAMPANAMKT TCAMP
                    WHERE     TCAMP.FIIDTIPO = CSG_1            --CAMPANAS MKT
                          AND TCAMP.FIIDNEGOCIO = PA_NEGOCIO
                          AND TCAMP.FIIDPAIS = PA_PAIS)
            LOOP
               SCSISGES.PACAMPANASMKT.SPPROCESACAMP (PA_PAIS,
                                                     CAMP.FIIDCAMPANA,
                                                     PA_TAMANIOBULK,
                                                     PA_CODERROR,
                                                     PA_DESCERROR);

               IF PA_CODERROR IS NOT NULL
               THEN
                  VL_CODERROR := PA_CODERROR;
                  VL_DESERROR := PA_DESCERROR;
               END IF;
            END LOOP;



            PA_FNFINALIZOSP := CSG_1;
            --SE REGISTRA LA FINALIZACION DEL PROCESO
            VL_IDPROCESO :=
               SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                           EXTRACT (MONTH FROM SYSDATE),
                                           EXTRACT (DAY FROM SYSDATE),
                                           TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                           TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                           'SPPROCESAMKT',
                                           SYSDATE,
                                           NULL,
                                           CSG_1,
                                           VL_IDPROCESO,
                                           CSG_1           --TIPO DE EJECUCION
                                                );
         ELSE
            VL_CODERROR := PA_CODERROR;
            VL_DESERROR := PA_DESCERROR;
         END IF;
      ELSIF VL_STATUSWF = CSG_0
      THEN
         PA_FNFINALIZOWF := CSG_0;           --INDICAMOS QUE ESTA EN EJECUCION
      ELSIF VL_STATUSWF = CSG_2
      THEN
         PA_FNFINALIZOWF := CSG_2;                   --FINALIZO MAPA CON ERROR
      ELSIF VL_STATUSWF = CSG_N1
      THEN
         PA_FNFINALIZOWF := CSG_N1;                    --AUN NO INICIA EL MAPA
      END IF;

      PA_CODERROR := VL_CODERROR;
      PA_DESCERROR := VL_DESERROR;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         PA_CODERROR := SQLCODE;
         PA_DESCERROR := SUBSTR (SQLERRM, 0, 200);
         PA_FNFINALIZOSP := CSG_N1;
         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             PA_DESCERROR,
                             'PACAMPANASMKT.SPPROCESAMKT');
         --SE REGISTRA LA FINALIZACION CON ERROR DEL PROCESO DE GEOGRAFIAS
         VL_IDPROCESO :=
            SCSISGES.FNCONTROLPROCESOS (EXTRACT (YEAR FROM SYSDATE),
                                        EXTRACT (MONTH FROM SYSDATE),
                                        EXTRACT (DAY FROM SYSDATE),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        TO_CHAR (SYSDATE, 'HH:MI:SS'),
                                        'SPPROCESAMKT',
                                        SYSDATE,
                                        PA_DESCERROR,
                                        CSG_2,               --STATUS DE ERROR
                                        VL_IDPROCESO,
                                        CSG_1);
   END SPPROCESAMKT;

   PROCEDURE SPPROCESACAMP (PA_PAIS          IN     NUMBER,
                            PA_CAMPANA       IN     NUMBER,
                            PA_TAMANIOBULK   IN     NUMBER,
                            PA_CODERROR         OUT INTEGER,
                            PA_DESCERROR        OUT VARCHAR2)
   IS
      CURSOR CUR_DATOS IS
         SELECT CTEMKT.FIPAISCU                    AS FIPAIS,
                CTEMKT.FICANALCU                   AS FICANAL,
                CTEMKT.FISUCURSALCU                AS FISUCURSAL,
                CTEMKT.FIFOLIOCU                   AS FIFOLIO,
                NVL (CART.FIIDSUCURSAL, 0)         FIIDSUCURSAL, --SUCURSAL DEL EMPLEADO
                NVL (CART.FIIDEMPLEADO, 888888)    FIIDEMPLEADO, --NUMERO DE EMPLEADO
                NVL (CART.FNSTATUSCTE, -1)         FNSTATUSCTE, --STATUS DEL CLIENTE
                CTEMKT.FIIDCAMPANA,                            --ID DE CAMPANA
                NVL (TS.FIIDPAIS, 1)               FIIDPAIS,
                NVL (TS.FIIDTERRITORIO, 0)         FIIDTERRITORIO,
                NVL (TS.FIIDZONA, 0)               FIIDZONA,
                NVL (TS.FIIDREGION, 0)             FIIDREGION
           FROM SCSISGES.TAFXCAMPANASMKT  CTEMKT
                JOIN SCSISGES.TCCAMPANAMKT TCAMP
                   ON (    TCAMP.FIIDCAMPANA = CTEMKT.FIIDCAMPANA
                       AND TCAMP.FIIDCAMPANA = PA_CAMPANA)
                LEFT JOIN SCSISGES.TAFXCARTERAPF CART
                   ON (    --CART.FIIDSUCURSAL BETWEEN PA_SUCMIN AND PA_SUCMAX
                           CART.FIPAIS = CTEMKT.FIPAISCU
                       AND CART.FICANAL = CTEMKT.FICANALCU
                       AND CART.FISUCURSAL = CTEMKT.FISUCURSALCU
                       AND CART.FIFOLIO = CTEMKT.FIFOLIOCU
                       AND CART.FIPAIS = CART.FIPAIS + CSG_0
                       AND CART.FICANAL = CART.FICANAL + CSG_0
                       AND CART.FISUCURSAL = CART.FISUCURSAL + CSG_0
                       AND CART.FIFOLIO = CART.FIFOLIO + CSG_0
                       AND CART.FIPAIS >= CSG_0
                       AND CART.FICANAL >= CSG_0
                       AND CART.FISUCURSAL >= CSG_0
                       AND CART.FIFOLIO >= CSG_0
                       AND CART.FIIDSUCURSAL >= CSG_0)
                LEFT JOIN SCSISGES.TCFXSUCURSAL TS
                   ON (    TS.FIIDPAIS = PA_PAIS
                       AND TS.FIESTATUS = CSG_1                       --ACTIVO
                       AND TS.FIIDSUCURSAL = CART.FIIDSUCURSAL
                       AND TS.FIIDSUCURSAL = TS.FIIDSUCURSAL + CSG_0);

      --CREACION DEL TYPE E INSTANCIA QUE GUARDARA LOS DATOS DE CLIENTES
      TYPE TYP_CUR_CLIENTES IS TABLE OF CUR_DATOS%ROWTYPE
         INDEX BY PLS_INTEGER;

      VLCUR_DATOSCTE   TYP_CUR_CLIENTES;
      VL_NOERRORES     NUMBER := 0;
   BEGIN
      OPEN CUR_DATOS;

      LOOP
         BEGIN
            FETCH CUR_DATOS
               BULK COLLECT INTO VLCUR_DATOSCTE
               LIMIT PA_TAMANIOBULK;

            EXIT WHEN VLCUR_DATOSCTE.COUNT = CSG_0;

            FORALL VL_I IN VLCUR_DATOSCTE.FIRST .. VLCUR_DATOSCTE.COUNT
              SAVE EXCEPTIONS
               INSERT INTO SCSISGES.TACAMPANACTE (FIIDCAMPANA,
                                                  FIPAIS,
                                                  FICANAL,
                                                  FISUCURSAL,
                                                  FIFOLIO,
                                                  FIIDEMPLEADO,
                                                  FNSTATUSCTE,
                                                  FIIDPAIS,
                                                  FIIDTERRITORIO,
                                                  FIIDZONA,
                                                  FIIDREGION,
                                                  FIIDSUCURSAL,
                                                  FDMODIFICACION,
                                                  FCUSRMODIFICO)
                    VALUES (VLCUR_DATOSCTE (VL_I).FIIDCAMPANA,
                            VLCUR_DATOSCTE (VL_I).FIPAIS,
                            VLCUR_DATOSCTE (VL_I).FICANAL,
                            VLCUR_DATOSCTE (VL_I).FISUCURSAL,
                            VLCUR_DATOSCTE (VL_I).FIFOLIO,
                            VLCUR_DATOSCTE (VL_I).FIIDEMPLEADO,
                            VLCUR_DATOSCTE (VL_I).FNSTATUSCTE,
                            VLCUR_DATOSCTE (VL_I).FIIDPAIS,
                            VLCUR_DATOSCTE (VL_I).FIIDTERRITORIO,
                            VLCUR_DATOSCTE (VL_I).FIIDZONA,
                            VLCUR_DATOSCTE (VL_I).FIIDREGION,
                            VLCUR_DATOSCTE (VL_I).FIIDSUCURSAL,
                            SYSDATE,
                            USER);
         EXCEPTION
            WHEN OTHERS
            THEN
               VL_NOERRORES := SQL%BULK_EXCEPTIONS.COUNT;
               SCSISGES.SPERRORES (
                  SYSDATE,
                  SQLCODE,
                     'CAMPA�A: '
                  || PA_CAMPANA
                  || ' ERRORES:  '
                  || VL_NOERRORES
                  || ' '
                  || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE
                  || SQLERRM,
                  'PACAMPANASMKT.SPPROCESACAMP');
         END;

         COMMIT;
         VLCUR_DATOSCTE.DELETE;
      END LOOP;

      CLOSE CUR_DATOS;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         PA_CODERROR := SQLCODE;
         PA_DESCERROR := SUBSTR (SQLERRM, 0, 200);
         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             PA_DESCERROR,
                             'PACAMPANASMKT.SPPROCESACAMP');
   END SPPROCESACAMP;

   PROCEDURE SPRESPALDO (PA_PAIS        IN     NUMBER,
                         PA_CODERROR       OUT INTEGER,
                         PA_DESCERROR      OUT VARCHAR2)
   IS
      CURSOR CUR_DATOS (PA_CAMPANA IN NUMBER)
      IS
         SELECT FIIDCAMPANA,
                FIPAIS,
                FICANAL,
                FISUCURSAL,
                FIFOLIO,
                FIIDEMPLEADO,
                FNSTATUSCTE,
                FIIDPAIS,
                FIIDTERRITORIO,
                FIIDZONA,
                FIIDREGION,
                FIIDSUCURSAL,
                FDMODIFICACION,
                FCUSRMODIFICO
           FROM SCSISGES.TACAMPANACTE T
          WHERE     T.FIIDPAIS = PA_PAIS
                AND T.FIIDCAMPANA = PA_CAMPANA
                AND T.FIIDCAMPANA > CSG_0;

      CURSOR CUR_CAMPANAS IS
         SELECT DISTINCT CAMP.FIIDCAMPANA
           FROM SCSISGES.TACAMPANACTE CAMP
          WHERE CAMP.FIIDCAMPANA > CSG_0;

      --CREACION DEL TYPE E INSTANCIA QUE GUARDARA LOS DATOS DE CLIENTES
      TYPE TYP_CUR_CLIENTES IS TABLE OF CUR_DATOS%ROWTYPE
         INDEX BY PLS_INTEGER;

      VLCUR_DATOSCTE   TYP_CUR_CLIENTES;
   BEGIN
      --TRUNCAMOS TABLA TEMPORAL
      EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TTCAMPANACTE';

      FOR CUR IN CUR_CAMPANAS
      LOOP
         OPEN CUR_DATOS (CUR.FIIDCAMPANA);

         LOOP
            BEGIN
               FETCH CUR_DATOS BULK COLLECT INTO VLCUR_DATOSCTE;

               EXIT WHEN VLCUR_DATOSCTE.COUNT = CSG_0;

               FORALL VL_I IN VLCUR_DATOSCTE.FIRST .. VLCUR_DATOSCTE.COUNT
                 SAVE EXCEPTIONS
                  INSERT INTO SCSISGES.TTCAMPANACTE (FIIDCAMPANA,
                                                     FIPAIS,
                                                     FICANAL,
                                                     FISUCURSAL,
                                                     FIFOLIO,
                                                     FIIDEMPLEADO,
                                                     FNSTATUSCTE,
                                                     FIIDPAIS,
                                                     FIIDTERRITORIO,
                                                     FIIDZONA,
                                                     FIIDREGION,
                                                     FIIDSUCURSAL,
                                                     FDMODIFICACION,
                                                     FCUSRMODIFICO)
                       VALUES (VLCUR_DATOSCTE (VL_I).FIIDCAMPANA,
                               VLCUR_DATOSCTE (VL_I).FIPAIS,
                               VLCUR_DATOSCTE (VL_I).FICANAL,
                               VLCUR_DATOSCTE (VL_I).FISUCURSAL,
                               VLCUR_DATOSCTE (VL_I).FIFOLIO,
                               VLCUR_DATOSCTE (VL_I).FIIDEMPLEADO,
                               VLCUR_DATOSCTE (VL_I).FNSTATUSCTE,
                               VLCUR_DATOSCTE (VL_I).FIIDPAIS,
                               VLCUR_DATOSCTE (VL_I).FIIDTERRITORIO,
                               VLCUR_DATOSCTE (VL_I).FIIDZONA,
                               VLCUR_DATOSCTE (VL_I).FIIDREGION,
                               VLCUR_DATOSCTE (VL_I).FIIDSUCURSAL,
                               SYSDATE,
                               USER);
            EXCEPTION
               WHEN OTHERS
               THEN
                  NULL;
            END;

            COMMIT;
            VLCUR_DATOSCTE.DELETE;
         END LOOP;

         CLOSE CUR_DATOS;
      END LOOP;

      --SE TRUNCA TABLA DE CLIENTES EN CAMPANA
      EXECUTE IMMEDIATE 'TRUNCATE TABLE SCSISGES.TACAMPANACTE';
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         PA_CODERROR := SQLCODE;
         PA_DESCERROR := SUBSTR (SQLERRM, 0, 200);
         SCSISGES.SPERRORES (SYSDATE,
                             PA_CODERROR,
                             PA_DESCERROR,
                             'PACAMPANASMKT.SPRESPALDO');
   END SPRESPALDO;
END PACAMPANASMKT;

/

  GRANT EXECUTE ON "SCSISGES"."PACAMPANASMKT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PACAMPANASMKT" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PACAMPANASMKT" TO "USRSISGES";
