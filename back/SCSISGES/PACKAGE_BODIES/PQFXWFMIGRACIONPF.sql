--------------------------------------------------------
--  DDL for Package Body PQFXWFMIGRACIONPF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQFXWFMIGRACIONPF" is

  -- Author  : 149766 - Arturo Lopez Patricio
  -- Created : 03/09/2018
  -- Purpose : stores para mapas de migracion de Productos Financieros a Sistemas Gestion Fenix

  CSG_0     CONSTANT INTEGER := 0;
  CSG_1     CONSTANT INTEGER := 1;
  CSG_2     CONSTANT INTEGER :=2;

PROCEDURE SPFXTRUNCACAMPANAS IS

BEGIN

    --SE TRUNCA LA TABLA DE LA GEOGRAFIA
    EXECUTE IMMEDIATE('TRUNCATE TABLE SCSISGES.TAFXCAMPANASPF');

EXCEPTION
  WHEN OTHERS THEN
     SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPFXTRUNCACAMPANAS');
END SPFXTRUNCACAMPANAS;

--PROCESO PARA HACER DELETE EN LA TABLA DE GEOGRAFIA
PROCEDURE SPFXDEPURACAMP IS

BEGIN

  DELETE  FROM SCSISGES.TAFXCAMPANASPF T
  WHERE T.FIIDCAMPANA>CSG_0;
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END SPFXDEPURACAMP;

 --SE TRUNCA LA TABLA DE LA CARTERA
PROCEDURE SPFXTRUNCACARTERA IS

BEGIN

    EXECUTE IMMEDIATE('TRUNCATE TABLE SCSISGES.TAFXCARTERAPF');

END SPFXTRUNCACARTERA;

--ELIMINA TODOS LOS REGISTROS DE LA TABLA DE LA CARTERA
PROCEDURE SPFXDEPURACART IS

BEGIN

  DELETE  FROM SCSISGES.TAFXCARTERAPF T
  WHERE T.FIIDSUCURSAL>CSG_0;
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END SPFXDEPURACART;
 --SE TRUNCA LA TABLA DE USUARIOS
PROCEDURE SPFXTRUNCAUSU IS

BEGIN

    EXECUTE IMMEDIATE('TRUNCATE TABLE SCSISGES.TAFXUSUARIOSPF');

EXCEPTION
  WHEN OTHERS THEN
     SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPFXTRUNCAUSU');
END SPFXTRUNCAUSU;

--ELIMINA TODOS LOS REGISTROS DE LA TABLA DE USUARIOS
PROCEDURE SPFXDEPURAUSU IS

BEGIN

  DELETE  FROM SCSISGES.TAFXUSUARIOSPF T
  WHERE T.FIIDUSUARIO>CSG_0;

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;

END SPFXDEPURAUSU;
 --SE TRUNCA LA TABLA DE CLIENTES
PROCEDURE SPFXTRUNCACLIENTES IS

BEGIN

    EXECUTE IMMEDIATE('TRUNCATE TABLE SCSISGES.TAFXCLIENTESPF');

EXCEPTION
  WHEN OTHERS THEN
     SCSISGES.SPERRORES(SYSDATE,SQLCODE,
         SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPFXTRUNCACLIENTES');
END SPFXTRUNCACLIENTES;

--ELIMINA TODOS LOS REGISTROS DE LA TABLA DE CLIENTES
PROCEDURE SPFXDEPURACTES IS

BEGIN

  DELETE  FROM SCSISGES.TAFXCLIENTESPF T
  WHERE T.FIIDCLIENTE>CSG_0;
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;

END SPFXDEPURACTES;

--PROCESO PARA TRUNCAR LA TABLA TAGEOGRAFBAZEKT
PROCEDURE SPFXTRUNCAGEOBAZEKT IS


 VL_BANDERA NUMBER;

BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE SCSISGES.TAGEOGRAFBAZEKT');
    VL_BANDERA := SCSISGES.fncontrolprocesos(
    EXTRACT (YEAR FROM SYSDATE),
                                    EXTRACT (MONTH FROM SYSDATE),
                                    EXTRACT (DAY FROM SYSDATE),
                                 TO_CHAR (SYSDATE, 'HH:MI:SS'), /*hora de inicio del proceso*/
                                TO_CHAR (SYSDATE, 'HH:MI:SS'),/*hora fin del proceso*/
                               'WF_FENIXGEOCECO',
                               SYSDATE, /*FECHA DE EJECUCION*/
                               NULL,/*DESCRIPCION DEL ERROR*/
                               CSG_0,/*STATUS, INDICAR INICIO DE MAPA*/
                               CSG_0,/*ID DEL PROCESO*/
                               CSG_2 /*indicamos el inicio de un mapa*/);

EXCEPTION
  WHEN OTHERS THEN
    SCSISGES.SPERRORES(SYSDATE,SQLCODE,
                     SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPFXTRUNCAGEOBAZEKT');

END SPFXTRUNCAGEOBAZEKT;

--PROCEDURE PARA DEPURAR LA TABLA TAGEOGRAFBAZEKT
PROCEDURE SPFXDEPURABAZEKT IS

BEGIN
     DELETE SCSISGES.TAGEOGRAFBAZEKT
      WHERE FIIDPAIS > CSG_0;
     COMMIT;

EXCEPTION
  WHEN OTHERS THEN
  ROLLBACK;

END SPFXDEPURABAZEKT;

--PROCESO QUE REGISTRA EL FIN DE UN PROCESO
PROCEDURE SPREGISTRAFINPROC IS
   VL_BANDERA NUMBER;
BEGIN
  --REGISTRAR FINALIZACION DE PROCESO
  VL_BANDERA := SCSISGES.fncontrolprocesos(
  EXTRACT (YEAR FROM SYSDATE),
  EXTRACT (MONTH FROM SYSDATE),
  EXTRACT (DAY FROM SYSDATE),
  TO_CHAR (SYSDATE, 'HH:MI:SS'), /*hora de inicio del proceso*/
  TO_CHAR (SYSDATE, 'HH:MI:SS'),/*hora fin del proceso*/
   'WF_FENIXGEOCECO',
   SYSDATE, /*FECHA DE EJECUCION*/
   NULL,/*DESCRIPCION DEL ERROR*/
   CSG_1,/*STATUS, INDICAR FINAL DE MAPA*/
   CSG_1,/*ID DEL PROCESO*/
   CSG_2 /*indicamos el inicio de un mapa*/);

EXCEPTION
  WHEN OTHERS THEN
    SCSISGES.SPERRORES(SYSDATE,SQLCODE,
                 SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPREGISTRAFINPROC');


 END     SPREGISTRAFINPROC;
 PROCEDURE SPFXTRUNCACAMPAMKT IS


 VL_BANDERA NUMBER;

BEGIN
  EXECUTE IMMEDIATE ('TRUNCATE TABLE SCSISGES.TAFXCAMPANASMKT');
    VL_BANDERA := SCSISGES.fncontrolprocesos(
    EXTRACT (YEAR FROM SYSDATE),
                                    EXTRACT (MONTH FROM SYSDATE),
                                    EXTRACT (DAY FROM SYSDATE),
                                 TO_CHAR (SYSDATE, 'HH:MI:SS'), /*hora de inicio del proceso*/
                                TO_CHAR (SYSDATE, 'HH:MI:SS'),/*hora fin del proceso*/
                               'WF_FENIXCAMPMKT',
                               SYSDATE, /*FECHA DE EJECUCION*/
                               NULL,/*DESCRIPCION DEL ERROR*/
                               CSG_0,/*STATUS, INDICAR INICIO DE MAPA*/
                               CSG_0,/*ID DEL PROCESO*/
                               CSG_2 /*indicamos el inicio de un mapa*/);

EXCEPTION
  WHEN OTHERS THEN
    SCSISGES.SPERRORES(SYSDATE,SQLCODE,
                     SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPFXTRUNCACAMPAMKT');

END SPFXTRUNCACAMPAMKT;
PROCEDURE SPREGISTRAFINCAMP IS
   VL_BANDERA NUMBER;
BEGIN
  --REGISTRAR FINALIZACION DE PROCESO
  VL_BANDERA := SCSISGES.fncontrolprocesos(
  EXTRACT (YEAR FROM SYSDATE),
  EXTRACT (MONTH FROM SYSDATE),
  EXTRACT (DAY FROM SYSDATE),
  TO_CHAR (SYSDATE, 'HH:MI:SS'), /*hora de inicio del proceso*/
  TO_CHAR (SYSDATE, 'HH:MI:SS'),/*hora fin del proceso*/
   'WF_FENIXCAMPMKT',
   SYSDATE, /*FECHA DE EJECUCION*/
   NULL,/*DESCRIPCION DEL ERROR*/
   CSG_1,/*STATUS, INDICAR FINAL DE MAPA*/
   CSG_1,/*ID DEL PROCESO*/
   CSG_2 /*indicamos el inicio de un mapa*/);

EXCEPTION
  WHEN OTHERS THEN
    SCSISGES.SPERRORES(SYSDATE,SQLCODE,
                 SUBSTR(SQLERRM,0,200),'PQFXWFMIGRACIONPF.SPREGISTRAFINPROC');


 END     SPREGISTRAFINCAMP;
end PQFXWFMIGRACIONPF;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXWFMIGRACIONPF" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXWFMIGRACIONPF" TO "USRINFSISGES";
