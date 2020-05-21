--------------------------------------------------------
--  DDL for Package PQSBGESTION0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQSBGESTION0001" 
AS
    PROCEDURE spinscambaceo (
        pa_fcdescarchivo         scsisges.tccatcambaceo.fcdescarchivo%TYPE,
        pa_fcnombrearchivo       scsisges.tccatcambaceo.fcnombrearchivo%TYPE,
        pa_fclobiarchivo         scsisges.tccatcambaceo.fclobiarchivo%TYPE,
        pa_mimetype              scsisges.tccatcambaceo.fcmimetype%TYPE,
        pa_fcusrmodifico         scsisges.tccatcambaceo.fcusrmodifico%TYPE,
        pa_codigo            OUT INTEGER,
        pa_mensaje           OUT VARCHAR2);

 PROCEDURE spigestion (
        pa_fipais              IN     scsisges.tagestion.fipaiscu%TYPE,
        pa_ficanal             IN     scsisges.tagestion.ficanalcu%TYPE,
        pa_fisucursal          IN     scsisges.tagestion.fisucursalcu%TYPE,
        pa_fifolio             IN     scsisges.tagestion.fifoliocu%TYPE,
        pa_fcempnum            IN     scsisges.tagestion.fcempnum%TYPE,
        pa_fimediogestionid    IN     scsisges.tagestion.fimediogestionid%TYPE,
        pa_firesultgestionid   IN     scsisges.tagestion.firesultgestionid%TYPE,
        pa_fitipogestionid     IN     scsisges.tagestion.fitipogestionid%TYPE,
        pa_FiDescGestion       IN     scsisges.tagestion.FiDescGestion%TYPE,
        pa_fcnotas             IN     scsisges.tagestion.fcnotas%TYPE,
        pa_fipaisemp           IN     scsisges.tagestion.fipaisemp%TYPE,
        pa_ficanalemp          IN     scsisges.tagestion.ficanalemp%TYPE,
        pa_fisucursalemp       IN     scsisges.tagestion.fisucursalemp%TYPE,
        pa_ficampanaid         IN     scsisges.tagestion.ficampanaid%TYPE,
        pa_fcdesccampana       IN     scsisges.tagestion.FCDESCCAMPANA%TYPE,
        pa_figestionid            OUT scsisges.tagestion.figestionid%TYPE,
        pa_codigo                 OUT INTEGER,
        pa_mensaje                OUT VARCHAR2);

    PROCEDURE spugestion (
        pa_figestionid         IN     scsisges.tagestion.figestionid%TYPE,
        pa_fipais              IN     scsisges.tagestion.fipaiscu%TYPE,
        pa_ficanal             IN     scsisges.tagestion.ficanalcu%TYPE,
        pa_fisucursal          IN     scsisges.tagestion.fisucursalcu%TYPE,
        pa_fifolio             IN     scsisges.tagestion.fifoliocu%TYPE,
        pa_fcempnum            IN     scsisges.tagestion.fcempnum%TYPE,
        pa_fimediogestionid    IN     scsisges.tagestion.fimediogestionid%TYPE,
        pa_firesultgestionid   IN     scsisges.tagestion.firesultgestionid%TYPE,
        pa_fitipogestionid     IN     scsisges.tagestion.fitipogestionid%TYPE,
        pa_fcnotas             IN     scsisges.tagestion.fcnotas%TYPE,
        pa_codigo                 OUT INTEGER,
        pa_mensaje                OUT VARCHAR2);

    PROCEDURE spdgestion (
        pa_figestionid   IN     scsisges.tagestion.figestionid%TYPE,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2);

    PROCEDURE spcgestionxcu (
        pa_fipais       IN     scsisges.tagestion.fipaiscu%TYPE,
        pa_ficanal      IN     scsisges.tagestion.ficanalcu%TYPE,
        pa_fisucursal   IN     scsisges.tagestion.fisucursalcu%TYPE,
        pa_fifolio      IN     scsisges.tagestion.fifoliocu%TYPE,
        pa_datos           OUT scsisges.patypes.rcgcursor,
        pa_codigo          OUT INTEGER,
        pa_mensaje         OUT VARCHAR2);

    PROCEDURE spccatalogos (
        pa_fiopcion              NUMBER,
        pa_fitipogestionid       scsisges.tacgesopciones.fitipogestionid%TYPE DEFAULT NULL,
        pa_filineaid             scsisges.tacgesopciones.filineaid%TYPE DEFAULT NULL,
        pa_fiperiodoid           scsisges.tacgesopciones.fiperiodoid%TYPE DEFAULT NULL,
        pa_fipromocionid         scsisges.tacgesopciones.fipromocionid%TYPE DEFAULT NULL,
        pa_fipaisid              scsisges.tacgesopciones.fipaisid%TYPE DEFAULT NULL,
        pa_fiterritorioid        scsisges.tacgesopciones.fiterritorioid%TYPE DEFAULT NULL,
        pa_fizonaid              scsisges.tacgesopciones.fizonaid%TYPE DEFAULT NULL,
        pa_datos             OUT scsisges.patypes.rcgcursor,
        pa_codigo            OUT INTEGER,
        pa_mensaje           OUT VARCHAR2,
        pa_mensajeerror      OUT VARCHAR2);

    PROCEDURE spgetlastgestion (
        pa_fipais        IN     SCSISGES.TAGESTION.FIPAISCU%TYPE,
        pa_ficanal       IN     SCSISGES.TAGESTION.FICANALCU%TYPE,
        pa_fisucursal    IN     SCSISGES.TAGESTION.FISUCURSALCU%TYPE,
        pa_fifolio       IN     SCSISGES.TAGESTION.FIFOLIOCU%TYPE,
        pa_gestionado       OUT INTEGER,
        pa_idresult         OUT INTEGER,
        pa_desresult        OUT SCSISGES.TCRESULTGESTION.FCRESULTGESTIONDESC%TYPE,
        pa_dategestion      OUT SCSISGES.TAGESTION.FDCREACION%TYPE,
        pa_codmsg           OUT INTEGER,
        pa_msg              OUT VARCHAR2,
        pa_msgerror         OUT VARCHAR2);

           PROCEDURE sp3combo (
         pa_gestion      OUT scsisges.patypes.rcgcursor);
END pqsbgestion0001;

/****************************************************************/

/

  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0001" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0001" TO "USRVENTAST";
