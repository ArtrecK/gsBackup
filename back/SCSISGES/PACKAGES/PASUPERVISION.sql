--------------------------------------------------------
--  DDL for Package PASUPERVISION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PASUPERVISION" 
IS
    -- Author  : B643963
    -- Created : 02/08/2018 12:27:56 p.m.
    -- Purpose : Stored de consulta para perfil supervisor

    PROCEDURE spConVendedores (pa_sucursal      IN     VARCHAR2,
                               pa_curVendedor      OUT SYS_REFCURSOR);

    PROCEDURE spGetAgendados (pa_idSucursal   IN     NUMBER,
                              pa_idVendedor   IN     NUMBER,
                              pa_llamadas        OUT NUMBER,
                              pa_visitas         OUT NUMBER,
                              pa_cambaceo        OUT NUMBER,
                              pa_codError        OUT INTEGER,
                              pa_msgError        OUT VARCHAR2);

    PROCEDURE SPCONTALERNOVISTAS (
        pa_FIEMPNUM       IN     SCSISGES.TAGEOALERTA.FIEMPNUM%TYPE,
        pa_CONTEO            OUT NUMBER,
        pa_CODIGO            OUT INTEGER,
        pa_MENSAJE           OUT VARCHAR2,
        pa_MENSAJEERROR      OUT VARCHAR2);

    PROCEDURE SPPPTOSGESTIONADOS (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2);

    PROCEDURE SPPEDIDOSGESTIONADOS (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2);

    PROCEDURE SPSOLSGESTIONADAS (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2);

    PROCEDURE SpPromoGestionadas (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2);

    PROCEDURE SpReactivaGestionadas (
        pa_FIEMPNUM        IN     SCSISGES.TAGESTION.FCEMPNUM%TYPE,
        pa_FISUCURSALEMP   IN     SCSISGES.TAGESTION.FISUCURSALEMP%TYPE,
        pa_CONTEO             OUT NUMBER,
        pa_CODIGO             OUT INTEGER,
        pa_MENSAJE            OUT VARCHAR2,
        pa_MENSAJEERROR       OUT VARCHAR2);

    PROCEDURE spEventosDia (pa_idVendedor     IN     NUMBER,
                            pa_evenLLamadas      OUT NUMBER,
                            pa_evenVisitas       OUT NUMBER,
                            pa_evenCambaceo      OUT NUMBER,
                            pa_evenTotal         OUT NUMBER,
                            pa_codError          OUT INTEGER,
                            pa_msgError          OUT VARCHAR2);
END PASUPERVISION;

/

  GRANT EXECUTE ON "SCSISGES"."PASUPERVISION" TO "USRSISGES";
