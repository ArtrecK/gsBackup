--------------------------------------------------------
--  DDL for Type TYHIJOREG_4610
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4610" UNDER TYTRANSACCION(
finopedido  number(10),
fingcioidgest  number(3),
finotiendagest  number(5),
ficteidgest  number(10),
fidigitovergest  number(3),
fipaisgest  number(3),
ficanalgest  number(3),
fisucursalgest  number(5),
fifoliogest  number(10),
fnimpdomiciliado  number(9,2),
fctarjeta  varchar2(16),
fiautorizacion  number(10),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_4610(SELF IN OUT NOCOPY TYHIJOREG_4610, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4610" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4610
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_4610(SELF IN OUT NOCOPY TYHIJOREG_4610, pa_registerData XMLTYPE)
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
VL_USER VARCHAR2(12):='VENTASTIENDA';

--INICIO DE LA FUNCION
BEGIN
  BEGIN
  VL_ERROR :='ERROR AL INSERTAR EN TACREDVTATIENDA';
       MERGE INTO SCVENTASTIENDA.TACREDVTATIENDA TAC
           USING (SELECT PACABECERO.FIPAISID AS PAIS,
                         PACABECERO.FICANALID AS CANAL,
                         PACABECERO.FISUCURSALID AS SUCURSAL,
                         SELF.FINOPEDIDO AS NOPEDIDO
                    FROM DUAL) TEM
              ON (TEM.PAIS = TAC.FIPAIS AND
                  TEM.CANAL = TAC.FICANAL AND
                  TEM.SUCURSAL = TAC.FISUCURSAL AND
                  TEM.NOPEDIDO = TAC.FINOPEDIDO
                 )
      WHEN NOT MATCHED THEN
         INSERT ( fipais,
                  ficanal,
                  fisucursal,
                  finopedido,
                  fingcioidgest,
                  finotiendagest,
                  ficteidgest,
                  fidigitovergest,
                  fipaisgest,
                  ficanalgest,
                  fisucursalgest,
                  fifoliogest,
                  fnimpdomiciliado,
                  fctarjeta,
                  fiautorizacion,
                  fdcreacion,
                  fdmodifico,
                  fcusrmodifico
                  )
         VALUES (PACABECERO.FIPAISID,
                 PACABECERO.FICANALID,
                 PACABECERO.FISUCURSALID,
                 SELF.finopedido,
                 SELF.fingcioidgest,
                 SELF.finotiendagest,
                 SELF.ficteidgest,
                 SELF.fidigitovergest,
                 SELF.fipaisgest,
                 SELF.ficanalgest,
                 SELF.fisucursalgest,
                 SELF.fifoliogest,
                 SELF.fnimpdomiciliado,
                 SELF.fctarjeta,
                 SELF.fiautorizacion,
                 SYSDATE,
                 SYSDATE,
                 VL_USER);

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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_4610',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4610" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4610" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4610" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4610" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4610" TO "USRVENTAST";
