--------------------------------------------------------
--  DDL for Package PAALERTAS0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAALERTAS0001" 
AS
    /*************************************************************
    Descripci�n: SP para insertar o actualizar la informaci�n de 1 alerta
    Par�metros de entrada: PIFIALERTAID   - Identificador �nico de la alerta                                                  - OPCIONAL
                           PIFCTITULO     - T�tulo descripctivo de la alerta                                                  - OBLIGATORIO
                           PIFCALERTADESC - Descripcion detallada de la alrta                                                 - OBLIGATORIO
                           PIFDINICIO     - Fecha [y hora] en que se debe mostrar la alerta                                   - OBLIGATORIO
                           PIFDFIN        - Fecha [y hora] en que termina la alerta                                           - OBLIGATORIO
                           PIFISTATUS     - Campo de borrado l�gico                                                           - OBLIGATORIO
                           PIGEOALERTA    - Array con la informaci�n de la geograf�a para distribuir la alerta                - OBLIGATORIO
    Par�metros de salida:  POCODIGO       - Bandera que indica si se gener� una exepci�n
                           POMENSAJE      - Mensaje de salida
                           POMENSAJEERROR      - Mensaje de excepci�n en caso de ocurrir
    *************************************************************/
    PROCEDURE SPGUARDARALERTA (
        pa_FIALERTAID     IN     SCSISGES.TAALERTA.FIALERTAID%TYPE DEFAULT 0,
        pa_FIUSUARIOID    IN     SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
        pa_FCTITULO       IN     SCSISGES.TAALERTA.FCTITULO%TYPE,
        pa_FCALERTADESC   IN     SCSISGES.TAALERTA.FCALERTADESC%TYPE,
        pa_FDFECINICIAL   IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
        pa_FDFECTERMINO   IN     SCSISGES.TAALERTA.FDFECTERMINO%TYPE,
        pa_FISTATUS       IN     SCSISGES.TAALERTA.FISTATUS%TYPE DEFAULT 0,
        pa_FICANALID      IN     SCSISGES.TAALERTA.FICANALID%TYPE,
        pa_GEOALERTA      IN     SCSISGES.TBGEOALERTA,
        pa_FIALCANCEID    IN     SCSISGES.TAALERTA.FIALCANCEID%TYPE,
        pa_FIROLID        IN     SCSISGES.TAALERTA.FIROLID%TYPE,
        pa_FCTIPOALERTA   IN     SCSISGES.TAALERTA.FCTIPOALERTA%TYPE,
        pa_CODIGO            OUT INTEGER,
        pa_MENSAJE           OUT VARCHAR2,
        pa_MENSAJEERROR      OUT VARCHAR2);

    /*************************************************************
    Descripci�n: SP para consultar las alertas dadas de alta en el sistema
    Par�metros de entrada: PIFIALERTAID   - Identificador �nico de la alerta                                                  - OPCIONAL
                           PIFISTATUS     - Campo de borrado l�gico                                                           - OPCIONAL
    Par�metros de salida:  PODATOS        - Cursor de salida con las alertas
                           POCODIGO       - Bandera que indica si se gener� una exepci�n
                           POMENSAJE      - Mensaje de salida
                           POMENSAJEERROR      - Mensaje de excepci�n en caso de ocurrir
    *************************************************************/
    PROCEDURE SPCALERTAS (
        PA_FIEMPNUM         IN     SCSISGES.TAGEOALERTA.FIEMPNUM%TYPE,
        PA_FIPAISID         IN     SCSISGES.TAGEOALERTA.FIPAISID%TYPE,
        PA_FITERRITORIOID   IN     SCSISGES.TAGEOALERTA.FITERRITORIOID%TYPE,
        PA_FIZONAID         IN     SCSISGES.TAGEOALERTA.FIZONAID%TYPE,
        PA_FIREGIONID       IN     SCSISGES.TAGEOALERTA.FIREGIONID%TYPE,
        PA_FISUCURSALID     IN     SCSISGES.TAGEOALERTA.FISUCURSALID%TYPE,
        PA_FIROLID          IN     SCSISGES.TAALERTA.FIROLID%TYPE,
        pa_DATOS               OUT SCSISGES.PATYPES.RCGCURSOR,
        pa_CODIGO              OUT INTEGER,
        pa_MENSAJE             OUT VARCHAR2,
        pa_MENSAJEERROR        OUT VARCHAR2);

    PROCEDURE SPVISUALALERTAS (
        pa_FIEMPNUM       IN     SCSISGES.TAEMPALERTA.FIEMPNUM%TYPE,
        pa_FIALERTAID     IN     SCSISGES.TAEMPALERTA.FIALERTAID%TYPE,
        pa_CODIGO            OUT INTEGER,
        pa_MENSAJE           OUT VARCHAR2,
        pa_MENSAJEERROR      OUT VARCHAR2);

    /*************************************************************
    Descripci�n: SP para consultar las alertas para vista de hist�rico
    Par�metros de entrada: PIFDFECINICIAL   - fecha de inicio para la b�squeda por fecha inicial de la alerta
                           PIFDFECTERMINO     -  fecha de fin para la b�squeda por fecha inicial de la alerta
    Par�metros de salida:  PODATOS        - Cursor de salida con las alertas
                           POCODIGO       - Bandera que indica si se gener� una exepci�n
                           POMENSAJE      - Mensaje de salida
                           POMENSAJEERROR      - Mensaje de excepci�n en caso de ocurrir
    *************************************************************/
    PROCEDURE SPCALERTASHISTORICO (
        pa_FDFECINICIAL     IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
        pa_FDFECTERMINO     IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
        pa_FIUSUARIOID      IN     SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
        pa_FIALERTDESTINO   IN     SCSISGES.TAALERTA.FIALERTDESTINO%TYPE,
        pa_DATOS               OUT SCSISGES.PATYPES.RCGCURSOR,
        pa_CODIGO              OUT INTEGER,
        pa_MENSAJE             OUT VARCHAR2,
        pa_MENSAJEERROR        OUT VARCHAR2);

    PROCEDURE SPDEL (pa_FIALERTAID         SCSISGES.TAALERTA.FIALERTAID%TYPE,
                     pa_FCEMPNUM           SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
                     pa_CODIGO         OUT INTEGER,
                     pa_MENSAJE        OUT VARCHAR2,
                     pa_MENSAJEERROR   OUT VARCHAR2);


    PROCEDURE ACTUALIZA (
        pa_FIALERTAID         SCSISGES.TAALERTA.FIALERTAID%TYPE,
        pa_FCTIPOALERTA       SCSISGES.TAALERTA.FCTIPOALERTA%TYPE,
        pa_FCALERTADESC       SCSISGES.TAALERTA.FCALERTADESC%TYPE,
        pa_FDINICIO           SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
        pa_FDFIN              SCSISGES.TAALERTA.FDFECTERMINO%TYPE,
        pa_FISTATUS           SCSISGES.TAALERTA.FISTATUS%TYPE,
        pa_USRMODIFICO        SCSISGES.TAALERTA.USRMODIFICO%TYPE,
        pa_FICANALID          SCSISGES.TAALERTA.FICANALID%TYPE,
        pa_FCTITULO           SCSISGES.TAALERTA.FCTITULO%TYPE,
        pa_FIALCANCEID        SCSISGES.TAALERTA.FIALCANCEID%TYPE,
        pa_FIUSUARIOID        SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
        pa_FIROLID            SCSISGES.TAALERTA.FIROLID%TYPE,
        pa_CODIGO         OUT INTEGER,
        pa_MENSAJE        OUT VARCHAR2,
        pa_MENSAJEERROR   OUT VARCHAR2);
END PAALERTAS0001;

/

  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "USRVENTAST";
