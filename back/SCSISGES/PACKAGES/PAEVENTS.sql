--------------------------------------------------------
--  DDL for Package PAEVENTS
--------------------------------------------------------

CREATE OR REPLACE PACKAGE SCSISGES.PAEVENTS IS
/*************************************************************
Proyecto: Sistema de Gestion
Descripcion: Paquete events que contiene los tipos de eventos
Parametros de entrada: N/A
Parametros de salida: N/A
Valor de retorno: Tipo de datos de usuario
Parametros de entrada-salida: N/A
Precondiciones: N/A
Creador: Cesar Ramirez Celaya
Fecha de creacion: 25 - 04 - 2018
*************************************************************/
PROCEDURE spevents (
    pa_status           IN VARCHAR2,
    pa_evncursor        OUT SYS_REFCURSOR);

PROCEDURE speventsag (
    pa_fiusuarioid      IN VARCHAR2,
    pa_fctitulo         IN VARCHAR2,
    pa_fcnota           IN VARCHAR2,
    pa_fdhorainicio     IN VARCHAR2,
    pa_fdhorafin        IN VARCHAR2,
    pa_fievento         IN NUMBER,
    pa_fdfecha          IN VARCHAR2,
    pa_fiduracion       IN NUMBER,
    pa_fccliente        IN VARCHAR2,
    pa_ficliente        IN VARCHAR2,
    pa_codigo           OUT INTEGER,
    pa_mensaje          OUT VARCHAR2,
    pa_figestionid      IN scsisges.taeventgest.figestionid%TYPE DEFAULT NULL);

PROCEDURE speventsup (
    pa_fiidevento       IN INTEGER,
    pa_fiusuarioid      IN VARCHAR2,
    pa_fctitulo         IN VARCHAR2,
    pa_fcnota           IN VARCHAR2,
    pa_fdhorainicio     IN VARCHAR2,
    pa_fdhorafin        IN VARCHAR2,
    pa_fievento         IN NUMBER,
    pa_fdfecha          IN VARCHAR2,
    pa_fiduracion       IN NUMBER,
    pa_fccliente        IN VARCHAR2,
    pa_ficliente        IN VARCHAR2,
    pa_codigo           OUT INTEGER,
    pa_mensaje          OUT VARCHAR2);

PROCEDURE speventsdl (
    pa_fiidevento       IN INTEGER,
    pa_fiusuarioid      IN VARCHAR2,
    pa_codigo           OUT INTEGER,
    pa_mensaje          OUT VARCHAR2);

PROCEDURE speventsvw (
    pa_fiusuarioid      IN VARCHAR2,
    curevents           OUT SYS_REFCURSOR,
    pa_codigo           OUT INTEGER,
    pa_mensaje          OUT VARCHAR2);

END paevents;

/

  GRANT EXECUTE ON SCSISGES.PAEVENTS TO USRSISGES;
  GRANT EXECUTE ON SCSISGES.PAEVENTS TO USRVENTAST;
