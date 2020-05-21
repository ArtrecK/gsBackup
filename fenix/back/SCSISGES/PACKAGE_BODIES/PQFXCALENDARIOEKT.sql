--------------------------------------------------------
--  DDL for Package Body PQFXCALENDARIOEKT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQFXCALENDARIOEKT" is

  -- Author  : 149766 - Arturo Lopez Patricio
  -- Created : 09/10/2018
  -- Purpose : stores para procesar calendario

  CSG_0     CONSTANT INTEGER := 0;
  CSG_1     CONSTANT INTEGER:=1;
  CSG_2     CONSTANT INTEGER:=2;
  CSG_3     CONSTANT INTEGER:=3;
  CSG_4     CONSTANT INTEGER:=4;
  CSG_6     CONSTANT INTEGER:=6;
  CSG_7     CONSTANT INTEGER := 7;
  CSG_USRSISGES CONSTANT VARCHAR2(9):='USRSISGES';

FUNCTION FNCALPRELIMINAR(
  PA_FECHAINI VARCHAR2,
  PA_FECHAFINAL VARCHAR2,
  PA_ANIO NUMBER
  ) RETURN  SCSISGES.TYTBCALENDARIO IS

 vl_fdfechaIni date;
 vl_fdfechaFinal date;

 vltab_datosCal SCSISGES.TYTBCALENDARIO;

 vl_numDiasAnio number;
 vl_anio number;
 vl_fechaActual date;
 vl_fisemana number:=1;
 vl_factor number:=0;
BEGIN
    vl_fdfechaIni:=to_date(PA_FECHAINI,'DD/MM/YYYY');

    --obtener el ultimo dia del mes diciembre
    SELECT LAST_DAY(TO_DATE(PA_FECHAFINAL,'DD/MM/YYYY'))
    into vl_fdfechaFinal
    FROM DUAL;

    --obtener numero de dias entre las dos fechas
    vl_numDiasAnio:=trunc(vl_fdfechaFinal)-trunc(vl_fdfechaIni);

    vl_anio:=PA_ANIO;

    --inicializar coleccion
    vltab_datosCal:=NEW SCSISGES.TYTBCALENDARIO();

    vl_fechaActual:=vl_fdfechaIni-csg_1;
    FOR vl_i IN CSG_1 .. (vl_numDiasAnio +csg_1)
      LOOP


        if vl_factor>=csg_7 then
          vl_factor:=csg_0;
          vl_fisemana:=vl_fisemana+csg_1;
        end if;
         vl_factor:=vl_factor+csg_1;

        vltab_datosCal.EXTEND;
        vltab_datosCal(vltab_datosCal.LAST):=NEW
             SCSISGES.TYOBJCALENDARIO(
             vl_anio,
             vl_fisemana,
            TO_CHAR( (vl_fechaActual+vl_i),'DD/MM/YYYY')
             );

      END LOOP;

    RETURN vltab_datosCal;

EXCEPTION
  WHEN OTHERS THEN
     SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXCALENDARIOEKT.FNCALPRELIMINAR');
     RETURN NULL;
END FNCALPRELIMINAR;
PROCEDURE SPGENERACALEKT
  (
   PA_FECHAINI VARCHAR2,
   PA_FECHAFINAL VARCHAR2,
   PA_ANIO NUMBER
  ) IS
  vltab_datosCal SCSISGES.TYTBCALENDARIO;
BEGIN
  EXECUTE IMMEDIATE ('alter session set nls_date_format = ''DD/MM/YYYY HH24:MI:SS''');
  --LLENAR COLECCION CON CALENDARIO PRELIMINAR
  vltab_datosCal:=SCSISGES.PQFXCALENDARIOEKT.FNCALPRELIMINAR(
    PA_FECHAINI,
    PA_FECHAFINAL,
    PA_ANIO
  );
  --eliminar los registros del anio actual
  DELETE FROM  SCSISGES.TCCALENDARIOEKT T
  WHERE T.FIANIO=PA_ANIO;
  COMMIT;

  --insertar en tabla solo semanas integras
  FOR fechas IN (SELECT TP.FISEMANA,
                   TP.FCFECHA,
                   TP.FIANIO
                  FROM TABLE (vltab_datosCal) TP,
                  (SELECT FISEMANA,COUNT(1)
                  FROM TABLE (vltab_datosCal)
                  GROUP BY FISEMANA
                  HAVING COUNT(1)=CSG_7)TS
                  WHERE TP.FISEMANA=TS.FISEMANA
                  ORDER BY TP.FISEMANA)
    LOOP
      INSERT INTO SCSISGES.TCCALENDARIOEKT(
            fianio, 
            fisemana, 
            fdfecha, 
            fdcreacion, 
            fdmodificacion, 
            fcusrmodifico
      )
      VALUES(fechas.FIANIO,
             fechas.FISEMANA,
             fechas.FCFECHA,
             SYSDATE,
             SYSDATE,
             CSG_USRSISGES
      );
    END LOOP;
    COMMIT;

    --genera calendario faltante
    SCSISGES.PQFXCALENDARIOEKT.SPGENERACALFALTANTE(
     vltab_datosCal
    );

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
        SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXCALENDARIOEKT.SPGENERACALEKT');
END SPGENERACALEKT;

PROCEDURE SPGENERACALFALTANTE
  (
   PA_CALPRELIMINAR SCSISGES.TYTBCALENDARIO
  ) IS
vl_fechaSiguiente DATE;
vl_conteoFechas NUMBER;

--datos iniciales
vl_fechaInicialCal DATE;
vl_fisemanaCal     NUMBER;
vl_fianioCal       NUMBER;
vl_fcfecha VARCHAR2(15);

BEGIN
  --BLOQUE DE CONTROL
    BEGIN
      --SACAR UN CONTEO DE FECHAS DE LA SEMANA FALTANTE CUANDO SEA MAYOR A 4 DIAS
      SELECT CONTEO
      INTO vl_conteoFechas
      FROM
      (SELECT
             FISEMANA,
             COUNT(1) as CONTEO
      FROM TABLE(PA_CALPRELIMINAR)
      GROUP BY FISEMANA
      HAVING COUNT(1) BETWEEN CSG_4 AND CSG_6);
    EXCEPTION
      WHEN OTHERS THEN
        vl_conteoFechas:=0;
    END;
IF vl_conteoFechas<>CSG_0 THEN

  --obtener datos de la primera fecha de la semana faltante
    SELECT FISEMANA,
           FDFECHA,
           FIANIO
    INTO vl_fisemanaCal,vl_fechaInicialCal,vl_fianioCal
    FROM
    (SELECT TP.FISEMANA,
           TO_DATE(TP.FCFECHA,'DD/MM/YYYY') AS FDFECHA,
           TP.FIANIO
    FROM TABLE(PA_CALPRELIMINAR) TP,
    (SELECT
           FISEMANA,
           COUNT(1)
    FROM TABLE(PA_CALPRELIMINAR)
    GROUP BY FISEMANA
    HAVING COUNT(1) BETWEEN CSG_4 AND CSG_6)TS
    WHERE TP.FISEMANA=TS.FISEMANA
    ORDER BY TO_DATE(TP.FCFECHA,'DD/MM/YYYY') ASC)
   WHERE ROWNUM<=CSG_1;

 --restar uno para no omitir ninguna fecha
 vl_fechaInicialCal:=vl_fechaInicialCal-CSG_1;
  FOR vl_i IN CSG_1 .. CSG_7
    LOOP
 --obtener la fecha siguiente
      vl_fechaSiguiente:=vl_fechaInicialCal+vl_i;
      vl_fcfecha:= TO_CHAR(vl_fechaSiguiente,'DD/MM/YYYY');
          INSERT INTO SCSISGES.TCCALENDARIOEKT(
                    fianio, 
                    fisemana, 
                    fdfecha, 
                    fdcreacion, 
                    fdmodificacion, 
                    fcusrmodifico
          )VALUES(
                    vl_fianioCal,
                    vl_fisemanaCal,
                    vl_fcfecha,
                    SYSDATE,
                    SYSDATE,
                    CSG_USRSISGES
          );


    END LOOP;
    COMMIT;
END IF;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
        SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXCALENDARIOEKT.SPGENERACALFALTANTE');
END SPGENERACALFALTANTE;
PROCEDURE SPDEPURACALENDARIO
(
          PA_OPCION NUMBER
         ,PA_ANIO NUMBER
         ,PA_SEMANA NUMBER
         ,PA_FECHA VARCHAR2
         ,PA_CURS         OUT SYS_REFCURSOR
) IS
VL_DESCRIPCION VARCHAR2(100);
VL_DESERROR VARCHAR2(100);
BEGIN
 CASE PA_OPCION
   WHEN CSG_1 THEN
     DELETE FROM SCSISGES.TCCALENDARIOEKT T
     WHERE T.FIANIO=PA_ANIO
      AND  T.FISEMANA>CSG_0;
     COMMIT;

     VL_DESCRIPCION:= 'SE ELIMINARON REGISTROS DEL ANIO CORRECTAMENTE';
   WHEN CSG_2 THEN
     DELETE FROM SCSISGES.TCCALENDARIOEKT T
     WHERE T.FISEMANA=PA_SEMANA
      AND  T.FIANIO=PA_ANIO;
     COMMIT;

     VL_DESCRIPCION:= 'SE ELIMINARON REGISTROS DE LA SEMANA '
                      ||PA_SEMANA||' DEL ANIO ' ||PA_ANIO||'CORRECTAMENTE';
   WHEN CSG_3 THEN
     DELETE FROM SCSISGES.TCCALENDARIOEKT T
     WHERE TRUNC(T.FDFECHA)=TRUNC(TO_DATE(PA_FECHA,'DD/MM/YYYY'));
     COMMIT;

     VL_DESCRIPCION:= 'SE ELIMINARON REGISTROS DE LA FECHA '
                      ||PA_FECHA||'CORRECTAMENTE';
  ELSE
    VL_DESCRIPCION:= 'OPCION INVALIDA';
 END CASE;

  OPEN PA_CURS FOR
               SELECT VL_DESCRIPCION AS FCDESCRIPCION
               FROM DUAL;


  EXCEPTION
      WHEN OTHERS THEN
      ROLLBACK;
      VL_DESERROR:=SUBSTR(SQLERRM,0,200);
     SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXCALENDARIOEKT.SPDEPURACALENDARIO');
      OPEN PA_CURS FOR
               SELECT VL_DESERROR AS FCDESCRIPCION
               FROM DUAL;
END SPDEPURACALENDARIO;
PROCEDURE SPCONSULTACAL
(
 PA_ANIO NUMBER,
 PA_CURS         OUT SYS_REFCURSOR
) IS

BEGIN

      OPEN PA_CURS FOR
      SELECT  fdfecha,
              fianio, 
              fisemana,  
              fdcreacion, 
              fdmodificacion, 
              fcusrmodifico
      FROM SCSISGES.TCCALENDARIOEKT T
      WHERE T.FIANIO=PA_ANIO
      ORDER BY T.FISEMANA,T.FDFECHA;


  EXCEPTION
      WHEN OTHERS THEN
             SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXCALENDARIOEKT.SPCONSULTACAL');
END SPCONSULTACAL;
end PQFXCALENDARIOEKT;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXCALENDARIOEKT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXCALENDARIOEKT" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQFXCALENDARIOEKT" TO "USRSISGES";
