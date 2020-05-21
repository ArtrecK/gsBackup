CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PQSISGESALERTAS"
AS
   csl_0                CONSTANT INTEGER := 0;
   csl_1                CONSTANT INTEGER := 1;
   csl_2                CONSTANT INTEGER := 2;
   csl_7                CONSTANT INTEGER := 7;
   csl_500              CONSTANT INTEGER := 500;
   csl_desc             CONSTANT VARCHAR2 (50) := 'VIGENCIA_ALERTAS';
   csl_OK               CONSTANT VARCHAR2 (5) := 'OK';
   vl_DATE                       DATE := SYSDATE;
   vl_USER                       VARCHAR2 (30) := USER;
   csl_ALERT_LIBERADA   CONSTANT VARCHAR2 (30) := 'ALERT_LIBERADA';
   csl_ID_ALERT         CONSTANT NUMBER := 31;

   PROCEDURE SPGUARDARALERTA (
      pa_FIALERTAID     IN     SCSISGES.TAALERTA.FIALERTAID%TYPE,
      pa_FIUSUARIOID    IN     SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
      pa_FCTITULO       IN     SCSISGES.TAALERTA.FCTITULO%TYPE,
      pa_FCALERTADESC   IN     SCSISGES.TAALERTA.FCALERTADESC%TYPE,
      pa_FDFECINICIAL   IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
      pa_FDFECTERMINO   IN     SCSISGES.TAALERTA.FDFECTERMINO%TYPE,
      pa_FICANALID      IN     SCSISGES.TAALERTA.FICANALID%TYPE,
      pa_GEOALERTA      IN     SCSISGES.TBGEOALERTA,
      PA_PERFILES       IN     SCSISGES.TYTPERFILALERTA,
      pa_CODIGO            OUT INTEGER,
      pa_MENSAJE           OUT VARCHAR2,
      pa_MENSAJEERROR      OUT VARCHAR2)
   AS
      vl_FIALERTAID      INTEGER := pa_FIALERTAID;
      vl_FIGEOALERTAID   INTEGER;
   BEGIN
      IF vl_FIALERTAID IS NULL OR vl_FIALERTAID = csl_0
      THEN
         vl_FIALERTAID := SCSISGES.SEQALERTA.NEXTVAL;

         INSERT INTO SCSISGES.TAALERTA (FIALERTAID,
                                        FCALERTADESC,
                                        FDFECINICIAL,
                                        FDFECTERMINO,
                                        FISTATUS,
                                        FDMODIFICACION,
                                        USRMODIFICO,
                                        FICANALID,
                                        FCTITULO,
                                        FIUSUARIOID,
                                        FDCREACION,
                                        FITIPOALERTA)
              VALUES (vl_FIALERTAID,
                      pa_FCALERTADESC,
                      pa_FDFECINICIAL,
                      pa_FDFECTERMINO,
                      csl_1,
                      SYSDATE,
                      USER,
                      pa_FICANALID,
                      pa_FCTITULO,
                      pa_FIUSUARIOID,
                      SYSDATE,
                      CSL_2);

         FOR I IN 1 .. NVL (pa_GEOALERTA, SCSISGES.TBGEOALERTA ()).COUNT
         LOOP
            VL_FIGEOALERTAID := SCSISGES.SEQGEOALERTA.NEXTVAL;

            INSERT INTO SCSISGES.TAGEOALERTA (FIGEOALERTAID,
                                              FIALERTAID,
                                              FIPAISID,
                                              FITERRITORIOID,
                                              FIZONAID,
                                              FIREGIONID,
                                              FISUCURSALID)
                 VALUES (VL_FIGEOALERTAID,
                         vl_FIALERTAID,
                         pa_GEOALERTA (I).FIPAISID,
                         pa_GEOALERTA (I).FITERRITORIOID,
                         pa_GEOALERTA (I).FIZONAID,
                         pa_GEOALERTA (I).FIREGIONID,
                         pa_GEOALERTA (I).FISUCURSALID);
         END LOOP;

         FOR i IN 1 .. NVL (PA_PERFILES, SCSISGES.TYTPERFILALERTA ()).COUNT
         LOOP
            INSERT INTO SCSISGES.TAPERFALERTA (FIALERTAID,
                                               FIPERFILID,
                                               FNINACTIVO,
                                               FDCREACION,
                                               FCUSRCREACION,
                                               FDMODIFICO,
                                               FCUSRMODIFICO)
                 VALUES (vl_FIALERTAID,
                         PA_PERFILES (i),
                         csl_0,
                         SYSDATE,
                         pa_FIUSUARIOID,
                         SYSDATE,
                         pa_FIUSUARIOID);
         END LOOP;

         COMMIT;
      END IF;

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
                             'SCSISGES.PQSISGESALERTAS.SPGUARDARALERTA');
         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALL� AL REALIZAR EL GUARDADO DE INFORMACI�N';
         pa_MENSAJEERROR :=
               SQLCODE
            || '-'
            || SQLERRM
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PQSISGESALERTAS.SPGUARDARALERTA';
   END;


   PROCEDURE SPCONSULTALERTAS (
      PA_FIEMPNUM         IN     SCSISGES.TAGEOALERTA.FIEMPNUM%TYPE,
      PA_FIPAISID         IN     SCSISGES.TAGEOALERTA.FIPAISID%TYPE,
      PA_FITERRITORIOID   IN     SCSISGES.TAGEOALERTA.FITERRITORIOID%TYPE,
      PA_FIZONAID         IN     SCSISGES.TAGEOALERTA.FIZONAID%TYPE,
      PA_FIREGIONID       IN     SCSISGES.TAGEOALERTA.FIREGIONID%TYPE,
      PA_FISUCURSALID     IN     SCSISGES.TAGEOALERTA.FISUCURSALID%TYPE,
      PA_FICANALID        IN     SCSISGES.TAALERTA.FICANALID%TYPE,
      PA_FIFUNCION        IN     SCSISGES.TAGEOALERTA.FIFUNCION%TYPE,
      pa_DATOS               OUT SCSISGES.PATYPES.RCGCURSOR,
      pa_CODIGO              OUT INTEGER,
      pa_MENSAJE             OUT VARCHAR2,
      pa_MENSAJEERROR        OUT VARCHAR2)
   IS
      VL_FIIDPERFIL                NUMBER := 0;
      CSL_VIGENCIAVISTO   CONSTANT VARCHAR2 (21) := 'ALERTA_VIGENCIA_VISTO';
      VL_NUMDIASVISTO              NUMBER := 0;
      vl_status                    NUMBER;
   BEGIN
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

      SELECT T.FIIDPERFIL
        INTO VL_FIIDPERFIL
        FROM SCSISGES.TCPERFILESEMP T
       WHERE T.FNFUNCIONSAP = PA_FIFUNCION;

      BEGIN
         SELECT TO_NUMBER (FCVALOR)
           INTO vl_status
           FROM SCSISGES.TAPARAMETROS
          WHERE     FIIDPARAMETRO = csl_ID_ALERT
                AND FCDESCRIPCION = csl_ALERT_LIBERADA
                AND FIACTIVO = CSL_1;
      EXCEPTION
         WHEN OTHERS
         THEN
            vl_status := CSL_1;
      END;

      OPEN PA_DATOS FOR
         SELECT AT.FIALERTAID,
                AT.FIUSUARIOID,
                AT.FCTITULO,
                AT.FCALERTADESC,
                AT.FDFECINICIAL,
                AT.FDFECTERMINO,
                AT.FDCREACION,
                AT.FISTATUS,
                AT.FIFIVISTO
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
                                CSL_0
                           THEN
                              CSL_1
                           ELSE
                              CSL_0
                        END   AS FIFIVISTO
                   FROM SCSISGES.TAALERTA  TA
                        JOIN SCSISGES.TAALERTAPERSONA TAALP
                           ON     TA.FIALERTAID = TAALP.FIALERTAID
                              AND TA.FIROLID > CSL_0
                        LEFT JOIN
                        (SELECT TAL.FIALERTAID,
                                TEMPA.FIEMPNUM,
                                TAL.FDFECTERMINO,
                                TEMPA.FDVISTO
                           FROM SCSISGES.TAALERTA  TAL
                                INNER JOIN SCSISGES.TAALERTAPERSONA TAG
                                   ON     TAL.FIALERTAID = TAG.FIALERTAID
                                      AND TAL.FIROLID > CSL_0
                                LEFT JOIN SCSISGES.TAEMPALERTA TEMPA
                                   ON TEMPA.FIALERTAID = TAL.FIALERTAID
                          WHERE     TAG.FIALERTAID > CSL_0
                                AND TAG.FIEMPNUM = PA_FIEMPNUM) EMPALERTA
                           ON     TAALP.FIALERTAID = EMPALERTA.FIALERTAID
                              AND TAALP.FIEMPNUM = EMPALERTA.FIEMPNUM
                  WHERE     TAALP.FIEMPNUM = PA_FIEMPNUM
                        AND TA.FIROLID = CSL_500
                        AND TA.FIROLID = TA.FIROLID + CSL_0
                        AND TA.FIALERTAID = TA.FIALERTAID + CSL_0
                        AND (   TRUNC (EMPALERTA.FDVISTO) IS NULL
                             OR SYSDATE <=
                                (EMPALERTA.FDVISTO + VL_NUMDIASVISTO))) AT
         UNION
         SELECT AM.FIALERTAID,
                AM.FIUSUARIOID,
                AM.FCTITULO,
                AM.FCALERTADESC,
                AM.FDFECINICIAL,
                AM.FDFECTERMINO,
                AM.FDCREACION,
                AM.FISTATUS,
                AM.FIFIVISTO
           FROM (SELECT TA.FIALERTAID,
                        TA.FIUSUARIOID,
                        TA.FCTITULO,
                        TA.FCALERTADESC,
                        TA.FDFECINICIAL,
                        TA.FDFECTERMINO,
                        TA.FDCREACION,
                        TA.FISTATUS,
                        CASE
                           WHEN (SELECT COUNT (1)
                                   FROM SCSISGES.TAEMPALERTA
                                  WHERE     FIALERTAID = EMPALERTA.FIALERTAID
                                        AND EMPALERTA.FIEMPNUM = PA_FIEMPNUM) >
                                CSL_0
                           THEN
                              CSL_1
                           ELSE
                              CSL_0
                        END   AS FIFIVISTO
                   FROM SCSISGES.TAALERTA  TA
                        LEFT JOIN scsisges.taperfalerta perfalert
                           ON ta.FIALERTAID = perfalert.FIALERTAID
                        JOIN SCSISGES.TAGEOALERTA TAGEO
                           ON TA.FIALERTAID = TAGEO.FIALERTAID
                        LEFT JOIN
                        (SELECT TAL.FIALERTAID,
                                TEMPA.FIEMPNUM,
                                TAL.FDFECTERMINO,
                                TEMPA.FDVISTO
                           FROM SCSISGES.TAALERTA  TAL
                                INNER JOIN SCSISGES.TAGEOALERTA TAG
                                   ON TAL.FIALERTAID = TAG.FIALERTAID
                                LEFT JOIN SCSISGES.TAEMPALERTA TEMPA
                                   ON TEMPA.FIALERTAID = TAL.FIALERTAID
                          WHERE     TAG.FIGEOALERTAID > CSL_0
                                AND TAG.FIALERTAID > CSL_0) EMPALERTA
                           ON     TAGEO.FIALERTAID = EMPALERTA.FIALERTAID
                              AND TAGEO.FIEMPNUM = EMPALERTA.FIEMPNUM
                  WHERE     TA.FITIPOALERTA = CSL_2           -- ALERTAS ADMON
                        AND TAGEO.FIGEOALERTAID > CSL_0
                        AND NVL (TAGEO.FIEMPNUM, PA_FIEMPNUM) = PA_FIEMPNUM
                        AND TAGEO.FIPAISID = PA_FIPAISID
                        AND NVL (TAGEO.FITERRITORIOID, PA_FITERRITORIOID) =
                            PA_FITERRITORIOID
                        AND NVL (TAGEO.FIZONAID, PA_FIZONAID) = PA_FIZONAID
                        AND NVL (TAGEO.FIREGIONID, PA_FIREGIONID) =
                            PA_FIREGIONID
                        AND NVL (TAGEO.FISUCURSALID, PA_FISUCURSALID) =
                            PA_FISUCURSALID
                        AND NVL (perfalert.FIPERFILid, VL_FIIDPERFIL) =
                            VL_FIIDPERFIL
                        AND NVL (TA.FICANALID, PA_FICANALID) = PA_FICANALID
                        AND TA.FNSTATALERT = vl_status
                        AND TRUNC (TA.FDFECINICIAL) <= TRUNC (SYSDATE)
                        AND TRUNC (TA.FDFECTERMINO) > TRUNC (SYSDATE)
                        AND (   TRUNC (EMPALERTA.FDVISTO) IS NULL
                             OR EMPALERTA.FDVISTO <= EMPALERTA.FDFECTERMINO))
                AM
         ORDER BY FIFIVISTO;

      pa_CODIGO := csl_0;
      pa_MENSAJE := 'OK';
      pa_MENSAJEERROR := '';
   EXCEPTION
      WHEN OTHERS
      THEN
      	OPEN PA_DATOS FOR
            SELECT NULL FIALERTAID,
                   NULL FIUSUARIOID,
                   NULL FCTITULO,
                   NULL FCALERTADESC,
                   TO_DATE ('01/01/1901') FDFECINICIAL,
                   TO_DATE ('01/01/1901') FDFECTERMINO,
                   NULL FDCREACION,
                   NULL FISTATUS,
                   NULL FIFIVISTO
              FROM DUAL;
         SCSISGES.SPERRORES (SYSDATE,
                             SQLCODE,
                             SUBSTR (SQLERRM, 0, 200),
                             'SCSISGES.PQSISGESALERTAS.SPCALERTAS');
         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALLÓ AL EJECUTAR LA CONSULTA';
         pa_MENSAJEERROR :=
               SQLCODE
            || ' '
            || SUBSTR (SQLERRM, 0, 200)
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PQSISGESALERTAS.SPCALERTAS';
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
                      vl_DATE,
                      vl_USER,
                      vl_DATE);

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
                             'SCSISGES.PQSISGESALERTAS.SPVISUALALERTAS');

         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALL� AL REALIZAR EL GUARDADO DE INFORMACI�N';
         pa_MENSAJEERROR :=
               SQLCODE
            || '-'
            || SQLERRM
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PQSISGESALERTAS.SPVISUALALERTAS';
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
                A.FDFECINICIAL - A.FDFECTERMINO    DIASACTIVO,
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
          WHERE     A.FDCREACION BETWEEN pa_FDFECINICIAL AND pa_FDFECTERMINO
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
                             'SCSISGES.PQSISGESALERTAS.SPCALERTASHISTORICO');
         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALL� AL EJECUTAR LA CONSULTA';
         pa_MENSAJEERROR :=
               SQLCODE
            || ' '
            || SQLERRM
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PQSISGESALERTAS.SPCALERTASHISTORICO';
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
                             'SCSISGES.PQSISGESALERTAS.SPDEL');
         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALL� AL ELIMINAR LA ALERTA';
         pa_MENSAJEERROR :=
               SQLCODE
            || ' '
            || SQLERRM
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PQSISGESALERTAS.SPDEL';
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
                             'SCSISGES.PQSISGESALERTAS.ACTUALIZA');
         pa_CODIGO := csl_1;
         pa_MENSAJE := 'FALL� AL ACTUALIZAR LA ALERTA';
         pa_MENSAJEERROR :=
               SQLCODE
            || ' '
            || SUBSTR (SQLERRM, 0, 200)
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PQSISGESALERTAS.ACTUALIZA';
   END ACTUALIZA;

   PROCEDURE SPALTAALERTAAUTOM (
      pa_FIALERTAID      IN     SCSISGES.TAALERTA.FIALERTAID%TYPE,
      pa_FIUSUARIOID     IN     SCSISGES.TAALERTA.FIUSUARIOID%TYPE,
      pa_FCTITULO        IN     SCSISGES.TAALERTA.FCTITULO%TYPE,
      pa_FCALERTADESC    IN     SCSISGES.TAALERTA.FCALERTADESC%TYPE,
      pa_FDFECINICIAL    IN     SCSISGES.TAALERTA.FDFECINICIAL%TYPE,
      pa_FDFECTERMINO    IN     SCSISGES.TAALERTA.FDFECTERMINO%TYPE,
      pa_FICANALID       IN     SCSISGES.TAALERTA.FICANALID%TYPE,
      PA_FITIPOALERTA    IN     SCSISGES.TAALERTA.FITIPOALERTA%TYPE,
      PA_FIEMPNUM        IN     SCSISGES.TAALERTAPERSONA.FIEMPNUM%TYPE,
      PA_FICATALERTAID   IN     SCSISGES.TAALERTAPERSONA.FICATALERTAID%TYPE,
      PA_FIPAIS          IN     SCSISGES.TAALERTACLIENTE.FIPAIS%TYPE,
      PA_FICANAL         IN     SCSISGES.TAALERTACLIENTE.FICANAL%TYPE,
      PA_FISUCURSAL      IN     SCSISGES.TAALERTACLIENTE.FISUCURSAL%TYPE,
      PA_FIFOLIO         IN     SCSISGES.TAALERTACLIENTE.FIFOLIO%TYPE,
      PA_FNVALOR         IN     SCSISGES.TAALERTACLIENTE.FNVALOR%TYPE,
      pa_CODIGO             OUT INTEGER,
      pa_MENSAJE            OUT VARCHAR2,
      pa_MENSAJEERROR       OUT VARCHAR2)
   IS
      vl_FIALERTAID   INTEGER := pa_FIALERTAID;
      VL_ROLID        NUMBER := 500;
      VL_TIPO         VARCHAR2 (2) := 'C';
   BEGIN
      IF vl_FIALERTAID IS NULL OR vl_FIALERTAID = csl_0
      THEN
         vl_FIALERTAID := SCSISGES.SEQALERTA.NEXTVAL;

         INSERT INTO SCSISGES.TAALERTA (fialertaid,
                                        fctipoalerta,
                                        fcalertadesc,
                                        fdfecinicial,
                                        fdfectermino,
                                        fistatus,
                                        fdmodificacion,
                                        usrmodifico,
                                        ficanalid,
                                        fctitulo,
                                        fialcanceid,
                                        fiusuarioid,
                                        fdcreacion,
                                        firolid,
                                        fitipoalerta)
              VALUES (vl_FIALERTAID,
                      VL_TIPO,
                      pa_FCALERTADESC,
                      pa_FDFECINICIAL,
                      pa_FDFECTERMINO,
                      csl_1,
                      SYSDATE,
                      vl_USER,
                      pa_FICANALID,
                      pa_FCTITULO,
                      CSL_0,
                      pa_FIUSUARIOID,
                      SYSDATE,
                      VL_ROLID,
                      PA_FITIPOALERTA);

         INSERT INTO SCSISGES.TAALERTAPERSONA (fialertaid,
                                               fiempnum,
                                               ficatalertaid,
                                               fnstatus,
                                               fdmodificacion,
                                               fcusrmodifico)
              VALUES (vl_FIALERTAID,
                      PA_FIEMPNUM,
                      PA_FICATALERTAID,
                      CSL_1,
                      SYSDATE,
                      USER);

         IF     PA_FIPAIS IS NOT NULL
            AND PA_FICANAL IS NOT NULL
            AND PA_FISUCURSAL IS NOT NULL
            AND PA_FIFOLIO IS NOT NULL
         THEN
            INSERT INTO SCSISGES.TAALERTACLIENTE (FIALERTAID,
                                                  FIPAIS,
                                                  FICANAL,
                                                  FISUCURSAL,
                                                  FIFOLIO,
                                                  FNVALOR,
                                                  FNSTATUS,
                                                  FDCREACION,
                                                  FCUSRCREACION,
                                                  FDMODIFICO,
                                                  FCUSRMOFIDICO)
                 VALUES (vl_FIALERTAID,
                         PA_FIPAIS,
                         PA_FICANAL,
                         PA_FISUCURSAL,
                         PA_FIFOLIO,
                         PA_FNVALOR,
                         csl_1,
                         SYSDATE,
                         USER,
                         SYSDATE,
                         USER);
         END IF;

         COMMIT;
      END IF;

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
   END SPALTAALERTAAUTOM;

   PROCEDURE SPCONSULTADETALLEALERTA (
      pa_FIALERTAID   IN     SCSISGES.TAALERTACLIENTE.FIALERTAID%TYPE,
      pa_DETAIL          OUT SCSISGES.PATYPES.RCGCURSOR,
      pa_MENSAJE         OUT VARCHAR2,
      pa_CODERROR        OUT VARCHAR2,
      pa_DESERROR        OUT VARCHAR2)
   AS
   BEGIN
      OPEN pa_DETAIL FOR SELECT TA.FIALERTAID,
                                TA.FIPAIS,
                                TA.FICANAL,
                                TA.FISUCURSAL,
                                TA.FIFOLIO,
                                TA.FNVALOR,
                                TA.FNSTATUS,
                                TA.FDCREACION,
                                TA.FCUSRCREACION,
                                TA.FDMODIFICO,
                                TA.FCUSRMOFIDICO
                           FROM SCSISGES.TAALERTACLIENTE TA
                          WHERE FIALERTAID = pa_FIALERTAID;
   EXCEPTION
      WHEN OTHERS
      THEN
         ROLLBACK;
         SCSISGES.SPERRORES (
            SYSDATE,
            SQLCODE,
            SUBSTR (SQLERRM, 0, 200),
            'SCSISGES.PAALERTAS0001.SPCONSULTADETALLEALERTA');
         pa_CODERROR := csl_1;
         pa_MENSAJE := 'FALL� AL CONSULTAR EL DETALLE DE LA ALERTA';
         pa_DESERROR :=
               SQLCODE
            || ' '
            || SUBSTR (SQLERRM, 0, 200)
            || '-'
            || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE ()
            || ' - SCSISGES.PAALERTAS0001.SPCONSULTADETALLEALERTA';
   END SPCONSULTADETALLEALERTA;
END PQSISGESALERTAS;
/

GRANT EXECUTE ON "SCSISGES"."PQSISGESALERTAS" TO "SCVENTASTIENDA";
GRANT EXECUTE ON "SCSISGES"."PQSISGESALERTAS" TO "USRSISGES";