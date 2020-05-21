--------------------------------------------------------
--  DDL for Type TYHIJOREG_4462
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4462" UNDER TYTRANSACCION(
fipais  number(3),
ficanal  number(3),
fisucursal  number(5),
fifolio  number(10),
fingcioid  number(3),
finotienda  number(5),
ficteid  number(10),
fidigitover  number(3),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_4462(SELF IN OUT NOCOPY TYHIJOREG_4462, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4462" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4462
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_4462(SELF IN OUT NOCOPY TYHIJOREG_4462, pa_registerData XMLTYPE)
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

--INICIO DE LA FUNCION
BEGIN
  BEGIN
VL_ERROR := 'ERROR AL INSERTAR EN TACENCTETIENDA';
   MERGE INTO SCVENTASTIENDA.TACENCTETIENDA C
        USING (SELECT PACABECERO.FIPAISID AS PAIS,
                      PACABECERO.FICANALID AS CANAL,
                      PACABECERO.FISUCURSALID AS SUCURSAL,
                      SELF.FINGCIOID AS NGCIOID,
                      SELF.FINOTIENDA AS NOTIENDA,
                      SELF.FICTEID AS CTEID,
                      SELF.FIDIGITOVER AS DIGITOVER,
                      SELF.FIFOLIO AS FOLIO
                 FROM DUAL) TMP
           ON (TMP.PAIS = C.FIPAIS
               AND TMP.CANAL = C.FICANAL
               AND TMP.SUCURSAL = C.FISUCURSAL
               AND TMP.NGCIOID = C.FINGCIOID
               AND TMP.NOTIENDA = C.FINOTIENDA
               AND TMP.CTEID = C.FICTEID
               AND TMP.DIGITOVER = C.FIDIGITOVER
               AND TMP.FOLIO = C.FIFOLIO
              )
   WHEN NOT MATCHED THEN
      INSERT (
              FIPAIS,
              FICANAL,
              FISUCURSAL,
              FIPAISCU,
              FICANALCU,
              FISUCURSALCU,
              FINGCIOID,
              FINOTIENDA,
              FICTEID,
              FIDIGITOVER,
              FIFOLIO,
              FDFECHAALTA
             )
      VALUES (PACABECERO.FIPAISID,
              PACABECERO.FICANALID,
              PACABECERO.FISUCURSALID,
              SELF.FIPAIS,
              SELF.FICANAL,
              SELF.FISUCURSAL,
              SELF.FINGCIOID,
              SELF.FINOTIENDA,
              SELF.FICTEID,
              SELF.FIDIGITOVER,
              SELF.FIFOLIO,
              SYSDATE
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_4462',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4462" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4462" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4462" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4462" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4462" TO "USRVENTAST";
