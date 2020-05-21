--------------------------------------------------------
--  DDL for Package Body PAALERTAS0001
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAALERTAS0001" 
AS
    csl_0     CONSTANT INTEGER := 0;
    csl_1     CONSTANT INTEGER := 1;
    csl_2     CONSTANT INTEGER := 2;
    csl_500   CONSTANT INTEGER := 500;
    vl_FECHAINI        DATE;
    vl_FECHAFIN        DATE;
    vl_DATE            DATE := SYSDATE;
    vl_USER            VARCHAR2 (30) := USER;

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
        pa_MENSAJEERROR      OUT VARCHAR2)
    AS
        vl_FIALERTAID      INTEGER := pa_FIALERTAID;
        vl_FIGEOALERTAID   INTEGER;
    BEGIN
        IF vl_FIALERTAID IS NULL OR vl_FIALERTAID = csl_0
        THEN
            --Insert alerta nueva
            vl_FIALERTAID := SCSISGES.SEQALERTA.NEXTVAL;

            INSERT INTO SCSISGES.TAALERTA (FIALERTAID,
                                           FCTIPOALERTA,
                                           FCALERTADESC,
                                           FDFECINICIAL,
                                           FDFECTERMINO,
                                           FISTATUS,
                                           FDMODIFICACION,
                                           USRMODIFICO,
                                           FICANALID,
                                           FCTITULO,
                                           FIALCANCEID,
                                           FIUSUARIOID,
                                           FDCREACION,
                                           FIROLID)
                 VALUES (vl_FIALERTAID,
                         pa_FCTIPOALERTA,
                         pa_FCALERTADESC,
                         pa_FDFECINICIAL,
                         pa_FDFECTERMINO,
                         csl_1,
                         vl_DATE,
                         vl_USER,
                         pa_FICANALID,
                         pa_FCTITULO,
                         pa_FIALCANCEID,
                         pa_FIUSUARIOID,
                         vl_DATE,
                         pa_FIROLID);

            --SE INSERTA LISTA DE GEOGRAF�AS (ACOTADAS) DONDE APLICA LA ALERTA
            FOR I IN 1 .. NVL (pa_GEOALERTA, SCSISGES.TBGEOALERTA ()).COUNT
            LOOP
                VL_FIGEOALERTAID := SCSISGES.SEQGEOALERTA.NEXTVAL;

                INSERT INTO SCSISGES.TAGEOALERTA (FIGEOALERTAID,
                                                  FIALERTAID,
                                                  FIPAISID,
                                                  FITERRITORIOID,
                                                  FIZONAID,
                                                  FIREGIONID,
                                                  FISUCURSALID,
                                                  FIEMPNUM)
                     VALUES (VL_FIGEOALERTAID,
                             vl_FIALERTAID,
                             pa_GEOALERTA (I).FIPAISID,
                             pa_GEOALERTA (I).FITERRITORIOID,
                             pa_GEOALERTA (I).FIZONAID,
                             pa_GEOALERTA (I).FIREGIONID,
                             pa_GEOALERTA (I).FISUCURSALID,
                             pa_GEOALERTA (I).FIEMPNUM);
            END LOOP;
        ELSE
            --Update alerta existente
            UPDATE SCSISGES.TAALERTA
               SET FIUSUARIOID = COALESCE (pa_FIUSUARIOID, FIUSUARIOID),
                   FCTITULO = COALESCE (pa_FCTITULO, FCTITULO),
                   FCALERTADESC = COALESCE (pa_FCALERTADESC, FCALERTADESC),
                   FDFECINICIAL = COALESCE (pa_FDFECINICIAL, FDFECINICIAL),
                   FDFECTERMINO = COALESCE (pa_FDFECTERMINO, FDFECTERMINO),
                   USRMODIFICO = COALESCE (pa_FIUSUARIOID, FIUSUARIOID),
                   FDMODIFICACION = vl_DATE,
                   FISTATUS = pa_FISTATUS
             WHERE FIALERTAID = vl_FIALERTAID;
        END IF;

        COMMIT;
        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAALERTAS0001.SPGUARDARALERTA');
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL REALIZAR EL GUARDADO DE INFORMACI�N';
            pa_MENSAJEERROR :=
                   SQLCODE
                || '-'
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.SPGUARDARALERTA';
    END;

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
        pa_MENSAJEERROR        OUT VARCHAR2)
    AS
        CSL_VIGENCIAVISTO   CONSTANT VARCHAR2 (21) := 'ALERTA_VIGENCIA_VISTO';
        VL_NUMDIASVISTO              NUMBER := 0;
    BEGIN
        /*obtener el numero de dias de visto*/
        BEGIN
            SELECT TO_NUMBER (FCVALOR)
              INTO VL_NUMDIASVISTO
              FROM SCSISGES.TAPARAMETROS T
             WHERE     TRIM (T.FCDESCRIPCION) = CSL_VIGENCIAVISTO
                   AND T.FIACTIVO = CSL_1;
        /*si ocurre una excepcion entonces dar dos dias*/
        EXCEPTION
            WHEN OTHERS
            THEN
                VL_NUMDIASVISTO := CSL_2;
        END;

        OPEN PA_DATOS FOR
              SELECT FIALERTAID,
                     FIUSUARIOID,
                     FCTITULO,
                     FCALERTADESC,
                     FDFECINICIAL,
                     FDFECTERMINO,
                     FDCREACION,
                     FISTATUS,
                     FCTIPOALERTA,
                     FIFIVISTO
                FROM (SELECT TA.FIALERTAID,
                             TA.FIUSUARIOID,
                             TA.FCTITULO,
                             TA.FCALERTADESC,
                             TA.FDFECINICIAL,
                             TA.FDFECTERMINO,
                             TA.FDCREACION,
                             TA.FISTATUS,
                             TA.FCTIPOALERTA,
                             CASE
                                 WHEN (SELECT COUNT (1)
                                         FROM SCSISGES.TAEMPALERTA
                                        WHERE     FIALERTAID =
                                                  EMPALERTA.FIALERTAID
                                              AND EMPALERTA.FIEMPNUM =
                                                  PA_FIEMPNUM) >
                                      csl_0
                                 THEN
                                     csl_1
                                 ELSE
                                     csl_0
                             END
                                 AS FIFIVISTO
                        FROM SCSISGES.TAALERTA TA
                             JOIN SCSISGES.TAGEOALERTA TAGEO
                                 ON     TA.FIALERTAID = TAGEO.FIALERTAID
                                    AND TA.FIROLID > csl_0
                             LEFT JOIN
                             (SELECT TAL.FIALERTAID,
                                     TEMPA.FIEMPNUM,
                                     TAL.FDFECTERMINO,
                                     TEMPA.FDVISTO
                                FROM SCSISGES.TAALERTA TAL
                                     INNER JOIN SCSISGES.TAGEOALERTA TAG
                                         ON     TAL.FIALERTAID = TAG.FIALERTAID
                                            AND TAL.FIROLID > csl_0
                                     LEFT JOIN SCSISGES.TAEMPALERTA TEMPA
                                         ON TEMPA.FIALERTAID = TAL.FIALERTAID
                               WHERE     TAG.FIGEOALERTAID > CSL_0
                                     AND TAG.FIALERTAID > CSL_0
                                     AND TAG.FIEMPNUM = PA_FIEMPNUM) EMPALERTA
                                 ON     TAGEO.FIALERTAID = EMPALERTA.FIALERTAID
                                    AND TAGEO.FIEMPNUM = EMPALERTA.FIEMPNUM
                       WHERE     TAGEO.FIGEOALERTAID > CSL_0
                             AND TAGEO.FIEMPNUM = PA_FIEMPNUM
                             AND TA.FIROLID = CSL_500
                             AND TA.FIROLID = TA.FIROLID + CSL_0
                             AND TA.FIALERTAID = TA.FIALERTAID + CSL_0
                             AND (   TRUNC (EMPALERTA.FDVISTO) IS NULL
                                  OR SYSDATE <=
                                     (EMPALERTA.FDVISTO + VL_NUMDIASVISTO)))
            ORDER BY FIFIVISTO;


        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAALERTAS0001.SPCALERTAS');
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SUBSTR (SQLERRM, 0, 200)
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.SPCALERTAS';
    END;

    PROCEDURE SPVISUALALERTAS (
        pa_FIEMPNUM       IN     SCSISGES.TAEMPALERTA.FIEMPNUM%TYPE,
        pa_FIALERTAID     IN     SCSISGES.TAEMPALERTA.FIALERTAID%TYPE,
        pa_CODIGO            OUT INTEGER,
        pa_MENSAJE           OUT VARCHAR2,
        pa_MENSAJEERROR      OUT VARCHAR2)
    AS
    BEGIN
        IF pa_FIEMPNUM IS NOT NULL AND pa_FIALERTAID IS NOT NULL
        THEN
            INSERT INTO SCSISGES.TAEMPALERTA (FIALERTAID,
                                              FIEMPNUM,
                                              FDVISTO,
                                              FCUSRMODIFICO,
                                              FDULTMADIFICACION)
                 VALUES (pa_FIALERTAID,
                         pa_FIEMPNUM,
                         SYSDATE,
                         vl_USER,
                         SYSDATE);

            COMMIT;
            pa_CODIGO := csl_0;
            pa_MENSAJE := 'OK';
            pa_MENSAJEERROR := '';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAALERTAS0001.SPVISUALALERTAS');

            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL REALIZAR EL GUARDADO DE INFORMACI�N';
            pa_MENSAJEERROR :=
                   SQLCODE
                || '-'
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.SPVISUALALERTAS';
    END;

    PROCEDURE SPCALERTASHISTORICO (
        pa_FDFECINICIAL     IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
        pa_FDFECTERMINO     IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
        pa_FIUSUARIOID      IN     SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
        pa_FIALERTDESTINO   IN     SCSISGES.TAALERTA.FIALERTDESTINO%TYPE,
        pa_DATOS               OUT SCSISGES.PATYPES.RCGCURSOR,
        pa_CODIGO              OUT INTEGER,
        pa_MENSAJE             OUT VARCHAR2,
        pa_MENSAJEERROR        OUT VARCHAR2)
    AS
    BEGIN
        OPEN pa_DATOS FOR
            SELECT A.FIALERTAID,
                   A.FCTITULO,
                   A.FCALERTADESC,
                   A.FDFECINICIAL - A.FDFECTERMINO DIASACTIVO,
                   A.FDFECINICIAL,
                   A.FDFECTERMINO,
                   A.FICANALID,
                   A.FIUSUARIOID,
                   A.FIALERTDESTINO,
                   A.FIROLID,
                   A.FDCREACION,
                   A.FCTIPOALERTA,
                   A.FIALCANCEID,
                   G.FIPAISID,
                   G.FIZONAID,
                   G.FIREGIONID,
                   G.FISUCURSALID,
                   G.FIEMPNUM,
                   A.FISTATUS
              FROM SCSISGES.TAALERTA  A
                   JOIN SCSISGES.TAGEOALERTA G ON A.FIALERTAID = G.FIALERTAID
             WHERE     A.FDCREACION BETWEEN pa_FDFECINICIAL
                                        AND pa_FDFECTERMINO
                   AND A.FIUSUARIOID = pa_FIUSUARIOID
                   AND A.FIALERTDESTINO = pa_FIALERTDESTINO
                   AND A.FIROLID > CSL_0
                   AND G.FIGEOALERTAID > CSL_0
                   AND G.FIALERTAID > CSL_0;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAALERTAS0001.SPCALERTASHISTORICO');
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.SPCALERTASHISTORICO';
    END;

    PROCEDURE SPDEL (pa_FIALERTAID         SCSISGES.TAALERTA.FIALERTAID%TYPE,
                     pa_FCEMPNUM           SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
                     pa_CODIGO         OUT INTEGER,
                     pa_MENSAJE        OUT VARCHAR2,
                     pa_MENSAJEERROR   OUT VARCHAR2)
    AS
    BEGIN
        UPDATE SCSISGES.TAALERTA
           SET FISTATUS = csl_2, USRMODIFICO = pa_FCEMPNUM
         WHERE FIALERTAID = pa_FIALERTAID AND FIUSUARIOID = pa_FCEMPNUM;


        COMMIT;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAALERTAS0001.SPDEL');
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL ELIMINAR LA ALERTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SQLERRM
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.SPDEL';
    END SPDEL;

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
        pa_MENSAJEERROR   OUT VARCHAR2)
    AS
    BEGIN
        UPDATE SCSISGES.TAALERTA
           SET FCTIPOALERTA = COALESCE (pa_FCTIPOALERTA, FCTIPOALERTA),
               FCALERTADESC = COALESCE (pa_FCALERTADESC, FCALERTADESC),
               FDFECINICIAL = COALESCE (pa_FDINICIO, FDFECINICIAL),
               FDFECTERMINO = COALESCE (pa_FDFIN, FDFECTERMINO),
               FISTATUS = COALESCE (pa_FISTATUS, FISTATUS),
               FDMODIFICACION = vl_DATE,
               USRMODIFICO = COALESCE (pa_USRMODIFICO, USRMODIFICO),
               FICANALID = COALESCE (pa_FICANALID, FICANALID),
               FCTITULO = COALESCE (pa_FCTITULO, FCTITULO),
               FIALCANCEID = COALESCE (pa_FIALCANCEID, FIALCANCEID),
               FIUSUARIOID = COALESCE (pa_FIUSUARIOID, FIUSUARIOID),
               FDCREACION = vl_DATE,
               FIROLID = COALESCE (pa_FIROLID, FIROLID)
         WHERE FIALERTAID = pa_FIALERTAID;

        COMMIT;

        pa_CODIGO := csl_0;
        pa_MENSAJE := 'OK';
        pa_MENSAJEERROR := '';
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            SCSISGES.SPERRORES (SYSDATE,
                                SQLCODE,
                                SUBSTR (SQLERRM, 0, 200),
                                'SCSISGES.PAALERTAS0001.ACTUALIZA');
            pa_CODIGO := csl_1;
            pa_MENSAJE := 'FALL� AL ACTUALIZAR LA ALERTA';
            pa_MENSAJEERROR :=
                   SQLCODE
                || ' '
                || SUBSTR (SQLERRM, 0, 200)
                || '-'
                || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
                || ' - SCSISGES.PAALERTAS0001.ACTUALIZA';
    END ACTUALIZA;
END PAALERTAS0001;

/

  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAALERTAS0001" TO "USRVENTAST";
