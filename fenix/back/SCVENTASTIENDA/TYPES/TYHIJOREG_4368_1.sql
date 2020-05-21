--------------------------------------------------------
--  DDL for Type TYHIJOREG_4368
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4368" 
    UNDER TYTRANSACCION
    (
        fisolicitudid NUMBER (10),
        fitiposolicitud NUMBER (3),
        fifolioparam NUMBER (10),
        fdfecvisita DATE,
        fcinformante VARCHAR2 (60 CHAR),
        fistat NUMBER (3),
        fisubstat NUMBER (3),
        fdfecstat DATE,
        firechazoid NUMBER (3),
        fiidnegocio NUMBER (3),
        fiidtienda NUMBER (5),
        fiidcliente NUMBER (10),
        fcejecutivo VARCHAR2 (6 CHAR),
        fiaceptapp NUMBER (3),
        fitipoautorizacion NUMBER (5),
        fncapacidadpago NUMBER (9, 2),
        fiplazo NUMBER (10),
        fdfecsolicitud DATE,
        fdcreacion DATE,
        fdmodifico DATE,
        fcusrmodifico VARCHAR2 (30),
        CONSTRUCTOR FUNCTION TYHIJOREG_4368 (
            SELF              IN OUT NOCOPY TYHIJOREG_4368,
            pa_registerData                 XMLTYPE)
            RETURN SELF AS RESULT,
        OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
            PACABECERO   IN scventastienda.TYCABECEROTXN)
            RETURN INTEGER
    )
    NOT FINAL INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4368" 
AS
    /*************************************************************************************************
    Proyecto: Sistema de Gestion
    Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4368
    Creador: Cesar David Campos Garcia
    Fecha de creacion: 20/05/2019
    **************************************************************************************************/
    CONSTRUCTOR FUNCTION TYHIJOREG_4368 (
        SELF              IN OUT NOCOPY TYHIJOREG_4368,
        pa_registerData                 XMLTYPE)
        RETURN SELF AS RESULT
    AS
    BEGIN
        pa_registerData.TOOBJECT (SELF);
        RETURN;
    END;
    OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
        PACABECERO   IN scventastienda.TYCABECEROTXN)
        RETURN INTEGER
    AS
        VL_ERROR           VARCHAR2 (100);
        CSL_0     CONSTANT PLS_INTEGER := 0;
        CSL_1     CONSTANT PLS_INTEGER := 1;
        CSL_9     CONSTANT PLS_INTEGER := 9;
        CSL_19    CONSTANT PLS_INTEGER := 19;
        CSL_78    CONSTANT PLS_INTEGER := 78;
        CSL_200   CONSTANT PLS_INTEGER := 200;
        VL_ORACOD          NUMBER;
        VL_ORADESC         VARCHAR2 (2000);
        vlEstatus          NUMBER (5) := 0;
    --INICIO DE LA FUNCION
    BEGIN
        BEGIN
            BEGIN
                SELECT FISTAT
                  INTO vlEstatus
                  FROM SCVENTASTIENDA.TACREDSOLICITUD
                 WHERE     FIPAIS = PACABECERO.FIPAISID
                       AND FICANAL = PACABECERO.FICANALID
                       AND FISUCURSAL = PACABECERO.FISUCURSALID
                       AND FISOLICITUDID = SELF.FISOLICITUDID;
            EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                    vlEstatus := CSL_0;
            END;


            VL_ERROR := 'ERROR AL INSERTAR EN TACREDSOLICITUD';

            MERGE INTO SCVENTASTIENDA.TACREDSOLICITUD SOL
                 USING (SELECT PACABECERO.FIPAISID     AS PAIS,
                               PACABECERO.FICANALID    AS CANAL,
                               PACABECERO.FISUCURSALID AS SUCURSAL,
                               SELF.FISOLICITUDID      AS SOLICITUDID
                          FROM DUAL) TMP
                    ON (    TMP.PAIS = SOL.FIPAIS
                        AND TMP.CANAL = SOL.FICANAL
                        AND TMP.SUCURSAL = SOL.FISUCURSAL
                        AND TMP.SOLICITUDID = SOL.FISOLICITUDID)
            WHEN NOT MATCHED
            THEN
                INSERT     (FIPAIS,
                            FICANAL,
                            FISUCURSAL,
                            FIIDNEGOCIO,
                            FIIDTIENDA,
                            FIIDCLIENTE,
                            FISOLICITUDID,
                            FITIPOSOLICITUD,
                            FIFOLIOPARAM,
                            FDFECVISITA,
                            FCINFORMANTE,
                            FISTAT,
                            FISUBSTAT,
                            FDFECSTAT,
                            FIRECHAZOID,
                            FCEJECUTIVO,
                            FDFECSOLICITUD,
                            FITRANNO,
                            FIACEPTAPP,
                            FITIPOAUTORIZACION,
                            FNCAPACIDADPAGO,
                            FIPLAZO)
                    VALUES (PACABECERO.FIPAISID,
                            PACABECERO.FICANALID,
                            PACABECERO.FISUCURSALID,
                            SELF.FIIDNEGOCIO,
                            SELF.FIIDTIENDA,
                            SELF.FIIDCLIENTE,
                            SELF.FISOLICITUDID,
                            SELF.FITIPOSOLICITUD,
                            SELF.FIFOLIOPARAM,
                            SELF.FDFECVISITA,
                            SELF.FCINFORMANTE,
                            SELF.FISTAT,
                            SELF.FISUBSTAT,
                            SELF.FDFECSTAT,
                            SELF.FIRECHAZOID,
                            TRIM (SELF.FCEJECUTIVO),
                            SELF.FDFECSOLICITUD,
                            PACABECERO.FITRANNO,
                            SELF.FIACEPTAPP,
                            SELF.FITIPOAUTORIZACION,
                            SELF.FNCAPACIDADPAGO,
                            SELF.FIPLAZO)
            WHEN MATCHED
            THEN
                UPDATE SET
                    FDFECVISITA = SELF.FDFECVISITA,
                    FCINFORMANTE = SELF.FCINFORMANTE,
                    FDFECSTAT = SELF.FDFECSTAT,
                    FIRECHAZOID = SELF.FIRECHAZOID,
                    FCEJECUTIVO = TRIM (SELF.FCEJECUTIVO),
                    FIACEPTAPP = SELF.FIACEPTAPP,
                    FITIPOAUTORIZACION = SELF.FITIPOAUTORIZACION,
                    FNCAPACIDADPAGO = SELF.FNCAPACIDADPAGO,
                    FIPLAZO = SELF.FIPLAZO
                         WHERE     FIPAIS = PACABECERO.FIPAISID
                               AND FICANAL = PACABECERO.FICANALID
                               AND FISUCURSAL = PACABECERO.FISUCURSALID
                               AND FISOLICITUDID = SELF.FISOLICITUDID;

            IF (vlEstatus = CSL_19 AND SELF.FISTAT = CSL_9)
            THEN
                UPDATE SCVENTASTIENDA.TACREDSOLICITUD
                   SET FISTAT = SELF.FISTAT
                 WHERE     FIPAIS = PACABECERO.FIPAISID
                       AND FICANAL = PACABECERO.FICANALID
                       AND FISUCURSAL = PACABECERO.FISUCURSALID
                       AND FISOLICITUDID = SELF.FISOLICITUDID;
            END IF;

            VL_ERROR := 'ERROR AL INSERTAR EN TASOLICITUDES';

            MERGE INTO SCVENTASTIENDA.TASOLICITUDES SOLI
                 USING (SELECT PACABECERO.FIPAISID     AS PAIS,
                               PACABECERO.FICANALID    AS CANAL,
                               PACABECERO.FISUCURSALID AS SUCURSAL,
                               SELF.FISOLICITUDID      AS SOLICITUDID
                          FROM DUAL) TMP
                    ON (    TMP.PAIS = SOLI.FIPAIS
                        AND TMP.CANAL = SOLI.FICANAL
                        AND TMP.SUCURSAL = SOLI.FISUCURSAL
                        AND TMP.SOLICITUDID = SOLI.FISOLICITUDID)
            WHEN NOT MATCHED
            THEN
                INSERT     (FIPAIS,
                            FICANAL,
                            FISUCURSAL,
                            FIIDNEGOCIO,
                            FIIDTIENDA,
                            FIIDCLIENTE,
                            FISOLICITUDID,
                            FITIPOSOLICITUD,
                            FIFOLIOPARAM,
                            FCEMPNO,
                            FISUBSTAT,
                            FNMONTO)
                    VALUES (PACABECERO.FIPAISID,
                            PACABECERO.FICANALID,
                            PACABECERO.FISUCURSALID,
                            SELF.FIIDNEGOCIO,
                            SELF.FIIDTIENDA,
                            SELF.FIIDCLIENTE,
                            SELF.FISOLICITUDID,
                            SELF.FITIPOSOLICITUD,
                            SELF.FIFOLIOPARAM,
                            '',
                            SELF.FISUBSTAT,
                            (SELF.FNCAPACIDADPAGO * CSL_78));
        EXCEPTION
            WHEN OTHERS
            THEN
                ROLLBACK;
                VL_ORACOD := SQLCODE;
                VL_ORADESC := SUBSTR (SQLERRM, CSL_0, CSL_200);
                --LLAMAR AL SP PARA GUARDAR TXN EN ERROR
                SCVENTASTIENDA.SPTRANSACERROR (
                    PACABECERO.FIPAISID,
                    PACABECERO.FICANALID,
                    PACABECERO.FISUCURSALID,
                    PACABECERO.FITRANNO,
                    PACABECERO.FITRANTIPO,
                    PACABECERO.FICONSECTIPO,
                    PACABECERO.FDTRANSFECHR,
                    PACABECERO.FCTRANWS,
                    PACABECERO.FCTRANUSR,
                    FOBJDETALLE.ficonsdeta,
                    FOBJDETALLE.fitiporeg,
                    FOBJDETALLE.fcdatodeta,
                       VL_ERROR
                    || ' -> '
                    || VL_ORACOD
                    || '-'
                    || VL_ORADESC
                    || '-> TYHIJOREG_4368',
                    CSL_1,
                    VL_ORACOD,
                    VL_ORADESC);
        END;

        RETURN 0;
    END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4368" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4368" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4368" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4368" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4368" TO "USRVENTAST";
