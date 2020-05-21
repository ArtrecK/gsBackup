--------------------------------------------------------
--  DDL for Package PAGOALS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAGOALS" 
AS
    /*************************************************************
    Proyecto: Sistema de Gestion
    Descripci�n: Paquete de objetivos Semanales y Diarios
    Par�metros de entrada: N/A
    Par�metros de salida: N/A
    Valor de retorno: Tipo de datos de usuario
    Par�metros de entrada-salida: N/A
    Precondiciones: N/A
    Creador: Cesar Ram
    irez Celaya
    Fecha de creaci�n: 08 - 05 - 2018
    *************************************************************/

    /*STORED PROCEDURE Que obtiene los objetivos por una sucursal de acuerdo a la fecha*/
    csl_0     CONSTANT INTEGER := 0;
    csl_1     CONSTANT INTEGER := 1;
    csl_2     CONSTANT INTEGER := 2;
    csl_4     CONSTANT INTEGER := 4;
    csl_52    CONSTANT INTEGER := 52;
    csl_200   CONSTANT INTEGER := 200;
    csl_n4    CONSTANT INTEGER := -4;
    csl_fun   CONSTANT INTEGER := 8067;
    csl_neg   CONSTANT VARCHAR2 (3) := 'EKT';
    csl_7     CONSTANT INTEGER := 7;

    PROCEDURE spgoalsweekly (
        pa_fidsucursal   IN     scsisges.taobjetivos.fnccosto%TYPE,
        pa_ffecha        IN     scsisges.taobjetivos.fdfecha%TYPE,
        cur_goals           OUT SYS_REFCURSOR,
        pa_code             OUT INTEGER,
        pa_message          OUT VARCHAR2);

    PROCEDURE spgoalsdaily (
        pa_fidsucursal   IN     scsisges.taobjetivos.fnccosto%TYPE,
        pa_ffecha        IN     scsisges.taobjetivos.fdfecha%TYPE,
        cur_goals           OUT SYS_REFCURSOR,
        pa_code             OUT INTEGER,
        pa_message          OUT VARCHAR2);

    PROCEDURE spgoalsCC (
        pa_fidsucursal   IN     scsisges.taobjetivos.fnccosto%TYPE,
        paCC                OUT SYS_REFCURSOR,
        pa_code             OUT INTEGER,
        pa_message          OUT VARCHAR2);


    PROCEDURE spGoalsEmp (pa_code OUT INTEGER, pa_message OUT VARCHAR2);

    PROCEDURE SP_DTL_TAVENTASACUM (pa_code      OUT INTEGER,
                                   pa_message   OUT VARCHAR2);
END pagoals;
/****************************************************************/

/****************************************************************/

/

  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAGOALS" TO "USRVENTAST";
