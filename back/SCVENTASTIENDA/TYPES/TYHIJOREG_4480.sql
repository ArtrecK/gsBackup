--------------------------------------------------------
--  DDL for Type TYHIJOREG_4480
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4480" UNDER TYTRANSACCION(
fipais  number(3),
ficanal  number(3),
fisucursal  number(5),
fifolio  number(10),
fipaisgestor  number(3),
ficanalgestor  number(3),
fisucursalgestora  number(5),
fistatus  number(3),
fdfechaalta  date,
fdfechaact  date,
fingcioid  number(3),
finotienda  number(5),
ficteid  number(10),
fidigitover  number(3),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_4480(SELF IN OUT NOCOPY TYHIJOREG_4480, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4480" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4480
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_4480(SELF IN OUT NOCOPY TYHIJOREG_4480, pa_registerData XMLTYPE)
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
VL_ORACOD NUMBER;
VL_ORADESC VARCHAR2(2000);
VL_USER VARCHAR2(13):='VENTASTIENDA';

--INICIO DE LA FUNCION
BEGIN
  BEGIN
   VL_ERROR := 'ERROR AL INSERTAR EN CENLINEACRED';
   MERGE INTO SCVENTASTIENDA.cenlineacred CEN
        USING (SELECT SELF.FIPAIS AS PAIS,
                      SELF.FICANAL AS CANAL,
                      SELF.FISUCURSAL AS SUCURSAL,
                      SELF.FIFOLIO AS FOLIO,
                      SELF.FINGCIOID AS NGCIOID,
                      SELF.FINOTIENDA AS NOTIENDA,
                      SELF.FICTEID AS CTEID,
                      SELF.FIDIGITOVER AS DIGITOVER
                 FROM DUAL) TMP
           ON (TMP.PAIS = CEN.FIPAIS
               AND TMP.CANAL = CEN.FICANAL
               AND TMP.SUCURSAL = CEN.FISUCURSAL
               AND TMP.NGCIOID = CEN.FINGCIOID
               AND TMP.NOTIENDA = CEN.FINOTIENDA
               AND TMP.CTEID = CEN.FICTEID
               AND TMP.DIGITOVER = CEN.FIDIGITOVER
               AND TMP.FOLIO = CEN.FIFOLIO
              )
   WHEN NOT MATCHED THEN
      INSERT (
              fipais,
              ficanal,
              fisucursal,
              fifolio,
              fipaisgestor,
              ficanalgestor,
              fisucursalgestora,
              fistatus,
              fdfechaalta,
              fdfechaact,
              fingcioid,
              finotienda,
              ficteid,
              fidigitover,
              fistscu,
              fdmodificacion,
              fcusrmodificacion
             )
      VALUES (SELF.FIPAIS,
              SELF.FICANAL,
              SELF.FISUCURSAL,
              SELF.FIFOLIO,
              SELF.FIPAISGESTOR,
              SELF.FICANALGESTOR,
              SELF.FISUCURSALGESTORA,
              SELF.FISTATUS,
              SELF.FDFECHAALTA,
              SELF.FDFECHAACT,
              SELF.FINGCIOID,
              SELF.FINOTIENDA,
              SELF.FICTEID,
              SELF.FIDIGITOVER,
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_4480',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4480" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4480" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4480" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4480" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4480" TO "USRVENTAST";
