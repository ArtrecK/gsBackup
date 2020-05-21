--------------------------------------------------------
--  DDL for Type TYHIJOREG_4376
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4376" UNDER TYTRANSACCION(
fipais  number(3),
ficanal  number(3),
fisucursal  number(5),
fifolio  number(10),
fncapacidadpago  number(9,2),
fncapacidadpagodisp  number(9,2),
fnmontolcr  number(9,2),
fiplazomax  number(5),
fnenganche1compra  number(9,2),
fidiapagounico  number(3),
fistatusautorizacion  number(3),
fdfechaultact  date,
fdfechaultaut  date,
fistatus  number(3),
filistanegra  number(3),
filocalizacion  number(3),
firmd  number(3),
filegal  number(3),
fidificilcobro  number(3),
fiaceptapp  number(3),
fipcj  number(3),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_4376(SELF IN OUT NOCOPY TYHIJOREG_4376, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4376" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4376
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_4376(SELF IN OUT NOCOPY TYHIJOREG_4376, pa_registerData XMLTYPE)
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
CSL_200 CONSTANT PLS_INTEGER :=200;
VL_USER CONSTANT VARCHAR2(13):='VENTASTIENDA';
VL_ORACOD NUMBER;
VL_ORADESC VARCHAR2(2000);

--INICIO DE LA FUNCION
BEGIN
  BEGIN
    VL_ERROR := 'ERROR AL INSERTAR EN CREDLINEACRED';
    MERGE INTO SCVENTASTIENDA.CREDLINEACRED C
        USING (SELECT PACABECERO.FIPAISID AS PAIS,
                      PACABECERO.FICANALID AS CANAL,
                      PACABECERO.FISUCURSALID AS SUCURSAL,
                      SELF.FIFOLIO AS FOLIO
                 FROM DUAL) TMP
           ON (TMP.PAIS = C.FIPAIS
               AND TMP.CANAL = C.FICANAL
               AND TMP.SUCURSAL = C.FISUCURSAL
               AND TMP.FOLIO = C.FIFOLIO
              )
   WHEN NOT MATCHED THEN
      INSERT (
              fipais,
              ficanal,
              fisucursal,
              fifolio,
              fncapacidadpago,
              fncapacidadpagodisp,
              fnmontolcr,
              fiplazomax,
              fnenganche1compra,
              fidiapagounico,
              fistatusautorizacion,
              fdfechaultact,
              fdfechaultaut,
              fistatus,
              fitranno,
              filistanegra,
              filocalizacion,
              firmd,
              filegal,
              fidificilcobro,
              fiaceptapp,
              fipcj,
              fdmodificacion,
              fcusrmodificacion
             )
      VALUES (PACABECERO.FIPAISID,
              PACABECERO.FICANALID,
              PACABECERO.FISUCURSALID,
              SELF.FIFOLIO,
              SELF.FNCAPACIDADPAGO,
              SELF.FNCAPACIDADPAGODISP,
              SELF.FNMONTOLCR,
              SELF.FIPLAZOMAX,
              SELF.FNENGANCHE1COMPRA,
              SELF.FIDIAPAGOUNICO,
              SELF.FISTATUSAUTORIZACION,
              SELF.FDFECHAULTACT,
              SELF.FDFECHAULTAUT,
              SELF.FISTATUS,
              PACABECERO.FITRANNO,
              SELF.FILISTANEGRA,
              SELF.FILOCALIZACION,
              SELF.FIRMD,
              SELF.FILEGAL,
              SELF.FIDIFICILCOBRO,
              SELF.FIACEPTAPP,
              SELF.FIPCJ,
              SYSDATE,
              VL_USER
              )
              WHEN MATCHED THEN
         UPDATE
            SET FISTATUS = SELF.FISTATUS;

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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_4376',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4376" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4376" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4376" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4376" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4376" TO "USRVENTAST";
