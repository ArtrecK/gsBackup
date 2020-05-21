--------------------------------------------------------
--  DDL for Type TYHIJOREG_4361
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4361" 
    UNDER TYTRANSACCION
    (
        fiidnegocio NUMBER (3),
        fiidtienda NUMBER (5),
        fiidcliente NUMBER (10),
        fiidpersona NUMBER (10),
        fitipocliente NUMBER (3),
        fifismor NUMBER (3),
        fdcreacion DATE,
        fdmodifico DATE,
        fcusrmodifico VARCHAR2 (30),
        CONSTRUCTOR FUNCTION TYHIJOREG_4361 (
            SELF              IN OUT NOCOPY TYHIJOREG_4361,
            pa_registerData                 XMLTYPE)
            RETURN SELF AS RESULT,
        OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
            PACABECERO   IN scventastienda.TYCABECEROTXN)
            RETURN INTEGER
    )
    NOT FINAL INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4361" 
AS
    /*************************************************************************************************
    Proyecto: Sistema de Gestion
    Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4361
    Creador: Cesar David Campos Garcia
    Fecha de creacion: 20/05/2019
    **************************************************************************************************/
    CONSTRUCTOR FUNCTION TYHIJOREG_4361 (
        SELF              IN OUT NOCOPY TYHIJOREG_4361,
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
        CSL_200   CONSTANT PLS_INTEGER := 200;
        VL_ORACOD          NUMBER;
        VL_ORADESC         VARCHAR2 (2000);
    --INICIO DE LA FUNCION
    BEGIN
        BEGIN
            VL_ERROR := 'ERROR AL INSERTAR EN TACREDCLIENTES';

            MERGE INTO SCVENTASTIENDA.TACREDCLIENTES CLI
                 USING (SELECT PACABECERO.FIPAISID     AS PAIS,
                               PACABECERO.FICANALID    AS CANAL,
                               PACABECERO.FISUCURSALID AS SUCURSAL,
                               SELF.FIIDNEGOCIO        AS IDNEGOCIO,
                               SELF.FIIDTIENDA         AS IDTIENDA,
                               SELF.FIIDCLIENTE        AS IDCLIENTE
                          FROM DUAL) TMP
                    ON (    TMP.PAIS = CLI.FIPAIS
                        AND TMP.CANAL = CLI.FICANAL
                        AND TMP.SUCURSAL = CLI.FISUCURSAL
                        AND TMP.IDNEGOCIO = CLI.FIIDNEGOCIO
                        AND TMP.IDTIENDA = CLI.FIIDTIENDA
                        AND TMP.IDCLIENTE = CLI.FIIDCLIENTE)
            WHEN NOT MATCHED
            THEN
                INSERT     (FIPAIS,
                            FICANAL,
                            FISUCURSAL,
                            FIIDNEGOCIO,
                            FIIDTIENDA,
                            FIIDCLIENTE,
                            FIIDPERSONA,
                            FITIPOCLIENTE,
                            FIFISMOR,
                            FDFECHAALTA,
                            FITRANNO)
                    VALUES (PACABECERO.FIPAISID,
                            PACABECERO.FICANALID,
                            PACABECERO.FISUCURSALID,
                            SELF.FIIDNEGOCIO,
                            SELF.FIIDTIENDA,
                            SELF.FIIDCLIENTE,
                            SELF.FIIDPERSONA,
                            SELF.FITIPOCLIENTE,
                            SELF.FIFISMOR,
                            SYSDATE,
                            PACABECERO.FITRANNO)
            WHEN MATCHED
            THEN
                UPDATE SET
                    FITIPOCLIENTE = SELF.FITIPOCLIENTE,
                    FIFISMOR = SELF.FIFISMOR,
                    FITRANNO = PACABECERO.FITRANNO
                         WHERE     FIPAIS = PACABECERO.FIPAISID
                               AND FICANAL = PACABECERO.FICANALID
                               AND FISUCURSAL = PACABECERO.FISUCURSALID
                               AND FIIDNEGOCIO = SELF.FIIDNEGOCIO
                               AND FIIDTIENDA = SELF.FIIDTIENDA
                               AND FIIDCLIENTE = SELF.FIIDCLIENTE;
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
                    || '-> TYHIJOREG_4361',
                    CSL_1,
                    VL_ORACOD,
                    VL_ORADESC);
        END;

        RETURN 0;
    END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4361" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4361" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4361" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4361" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4361" TO "USRVENTAST";
