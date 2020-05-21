--------------------------------------------------------
--  DDL for Type TYHIJOREG_110
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_110" UNDER TYTRANSACCION(
finopedido  number(10),
fiprodid  number(10),
fcprodtipo  varchar2(2 char),
ficantart  number(5),
fnprcunit  number(9,2),
fnpdctodescto  number(9,2),
fnimpsobrep  number(11,4),
fncostopdcto  number(9,2),
fnporcpromoeng  number(4,2),
ficveprom  number(10),
fnproddesctoe  number(9,2),
fndesctomkt  number(9,2),
fnintereses  number(8,2),
fiporciva  number(9,2),
fitipobloqueo  number(3),
fidepto  number(10),
fisubdepto  number(10),
fnprecioventa  number(14,2),
fiidgext  number(10),
fncomisionv  number(7,2),
fncomisiong  number(7,2),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_110(SELF IN OUT NOCOPY TYHIJOREG_110, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_110" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 110
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_110(SELF IN OUT NOCOPY TYHIJOREG_110, pa_registerData XMLTYPE)
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
   VL_ERROR := 'ERROR AL ACTUALIZAR EN PEDIDOS_CREDITO';
   UPDATE SCVENTASTIENDA.pedidos_credito t
      SET t.fdcsaldocapital= (SELF.ficantart * SELF.fnprcunit)+(t.fdcsaldocapital)
     WHERE t.finopedido= SELF.finopedido;

      VL_ERROR := 'ERROR AL INSERTAR EN TADETPEDIDOS';
      MERGE INTO SCVENTASTIENDA.TADETPEDIDOS DET
           USING (SELECT PACABECERO.FIPAISID AS PAIS,
                         PACABECERO.FICANALID AS CANAL,
                         PACABECERO.FISUCURSALID AS SUCURSAL,
                         SELF.finopedido AS NOPEDIDO,
                         SELF.fiprodid AS PRODID
                    FROM DUAL) TMP
              ON (TMP.PAIS = DET.FIPAIS AND
                  TMP.CANAL = DET.FICANAL AND
                  TMP.SUCURSAL = DET.FISUCURSAL AND
                  TMP.NOPEDIDO = DET.FINOPEDIDO AND
                  TMP.PRODID = DET.FIPRODID
                 )
      WHEN NOT MATCHED THEN
         INSERT (
                 FIPAIS,
                 FICANAL,
                 FISUCURSAL,
                 FINOPEDIDO,
                 FIPRODID,
                 FICANTART,
                 FNPRCUNIT,
                 FNPDCTODESCTO,
                 FNPRODDESCTOE,
                 FNCOMISIONG,
                 FNCOMISIONV,
                 FNIMPSOBREP,
                 FNCOSTOPDCTO,
                 FNPORCENGANCHE,
                 FNINTERESES,
                 FNPORCIVA,
                 FNDESCTOMKT,
                 FNPRECIOVENTA,
                 FICVEPROM
                )
         VALUES (
                 PACABECERO.FIPAISID,
                 PACABECERO.FICANALID,
                 PACABECERO.FISUCURSALID,
                 SELF.finopedido,
                 SELF.fiprodid,
                 SELF.ficantart,
                 SELF.fnprcunit,
                 SELF.fnpdctodescto,
                 SELF.fnproddesctoe,
                 SELF.fncomisiong,
                 SELF.fncomisionv,
                 SELF.fnimpsobrep,
                 SELF.fncostopdcto,
                 SELF.fnporcpromoeng,
                 SELF.fnintereses,
                 SELF.fiporciva,
                 SELF.fndesctomkt,
                 SELF.fnprecioventa,
                 SELF.ficveprom
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_110',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_110" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_110" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_110" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_110" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_110" TO "USRVENTAST";
