--------------------------------------------------------
--  DDL for Type TYHIJOREG_2320
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_2320" UNDER TYTRANSACCION(
finopedido  number(10),
fipais  number(3),
ficanal  number(3),
fisucursal  number(5),
fifolio  number(10),
fiperiodopago  number(3),
finopromo  number(5),
fitir  number(3),
fistscarteravendida  number(3),
fitirnewp  number(5),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_2320(SELF IN OUT NOCOPY TYHIJOREG_2320, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_2320" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 2320
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_2320(SELF IN OUT NOCOPY TYHIJOREG_2320, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT AS

BEGIN
  pa_registerData.TOOBJECT(SELF);
    RETURN;
END;

OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN)
RETURN INTEGER AS

VL_ERROR VARCHAR2(100);
CSL_0 CONSTANT PLS_INTEGER :=0;
CSL_1 CONSTANT PLS_INTEGER :=1;
VL_USER CONSTANT VARCHAR2(13):='VENTASTIENDA';
CSL_200 CONSTANT PLS_INTEGER :=200;
VL_ORACOD NUMBER;
VL_ORADESC VARCHAR2(2000);

--INICIO DE LA FUNCION
BEGIN
  BEGIN
   VL_ERROR := 'ERROR AL INSERTAR EN CRECTEUNICPED';
   MERGE INTO SCVENTASTIENDA.CRECTEUNICPED C
        USING (SELECT PACABECERO.FIPAISID AS PAIS,
                      PACABECERO.FICANALID AS CANAL,
                      PACABECERO.FISUCURSALID AS SUCURSAL,
                      SELF.FINOPEDIDO AS FINOPEDIDO
                 FROM DUAL) TMP
           ON (TMP.PAIS = C.FIPAIS AND
               TMP.CANAL = C.FICANAL AND
               TMP.SUCURSAL = C.FISUCURSAL AND
               TMP.FINOPEDIDO = C.FINOPEDIDO
              )
   WHEN NOT MATCHED THEN
      INSERT (
              FIPAIS,
              FICANAL,
              FISUCURSAL,
              FINOPEDIDO,
              FIPAISCU,
              FICANALCU,
              FISUCURSALCU,
              FIFOLIO,
              FIPERIODOPAGO,
              FINOPROMO,
              FITIR,
              FISTSCARTERAVENDIDA,
              FISTATUSREGIONAL,
              FDMODIFICACION,
              FCUSRMODIFICACION
             )
      VALUES (PACABECERO.FIPAISID,
              PACABECERO.FICANALID,
              PACABECERO.FISUCURSALID,
              SELF.FINOPEDIDO,
              SELF.FIPAIS,
              SELF.FICANAL,
              SELF.FISUCURSAL,
              SELF.FIFOLIO,
              SELF.FIPERIODOPAGO,
              SELF.FINOPROMO,
              SELF.FITIRNEWP,
              SELF.FISTSCARTERAVENDIDA,
              CSL_1,
              SYSDATE,
              VL_USER
              );


  EXCEPTION
       WHEN OTHERS THEN
         ROLLBACK;
         VL_ORACOD :=SQLCODE;
         VL_ORADESC :=  SUBSTR(SQLERRM, CSL_0,CSL_200);
       --LLAMAR AL SP PARA GUARDAR TXN EN ERROR
         SCVENTASTIENDA.SPTRANSACERROR(PACABECERO.FIPAISID,
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_2320',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2320" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2320" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2320" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2320" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2320" TO "USRVENTAST";
