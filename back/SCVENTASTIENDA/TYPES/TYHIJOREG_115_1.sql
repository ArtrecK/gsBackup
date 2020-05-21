--------------------------------------------------------
--  DDL for Type TYHIJOREG_115
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_115" UNDER TYTRANSACCION(
  FINOPEDIDO  NUMBER(10),
    FNPEDTOTAL  NUMBER(13,2),
    FNPEDSALDO  NUMBER(13,2),
    FNENGANCHE  NUMBER(9,2),
    FNRECARGOS  NUMBER(11,2),
    FNDESCTOTOTAL  NUMBER(11,2),
    FNSOBREPRECIO  NUMBER(11,2),
    FDCREACION  DATE,
    FDMODIFICO  DATE,
    FCUSRMODIFICO  VARCHAR2(30),
    CONSTRUCTOR FUNCTION TYHIJOREG_115(SELF IN OUT NOCOPY TYHIJOREG_115, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_115" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 115
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_115(SELF IN OUT NOCOPY TYHIJOREG_115, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT AS
  BEGIN
    pa_registerData.TOOBJECT(SELF);
    RETURN;
  END ;
  OVERRIDING MEMBER FUNCTION  FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN)
                               RETURN INTEGER AS

  CSL_0 CONSTANT PLS_INTEGER :=0;
  CSL_1 CONSTANT PLS_INTEGER :=1;
  CSL_200 CONSTANT PLS_INTEGER :=200;
  VL_ERROR VARCHAR2(100);
  VL_ORACOD NUMBER;
  VL_ORADESC VARCHAR2(2000);

  BEGIN
       BEGIN
   VL_ERROR := 'ERROR AL ACTUALIZAR EN TAPEDIDOS';
   MERGE INTO SCVENTASTIENDA.TAPEDIDOS DATOS
       USING (SELECT PACABECERO.FIPAISID AS  PAIS,
                     PACABECERO.FICANALID AS  CANAL,
                     PACABECERO.FISUCURSALID AS  SUC,
                     SELF.FINOPEDIDO AS  PEDIDO
                FROM DUAL) VALORES
                  ON (DATOS.FIPAIS = VALORES.PAIS
                 AND  DATOS.FICANAL = VALORES.CANAL
                 AND  DATOS.FISUCURSAL = VALORES.SUC
                 AND  DATOS.FINOPEDIDO = VALORES.PEDIDO)
        WHEN MATCHED THEN
             UPDATE
                SET  FNPEDTOTAL = SELF.FNPEDTOTAL,
                     FNPEDSALDO = SELF.FNPEDSALDO,
                     FNENGANCHE = SELF.FNENGANCHE;

   VL_ERROR := 'ERROR AL ACTUALIZAR EN TACREDITO';
   MERGE INTO SCVENTASTIENDA.TACREDITO DATOS
       USING (SELECT PACABECERO.FIPAISID AS PAIS,
                     PACABECERO.FICANALID AS CANAL,
                     PACABECERO.FISUCURSALID AS  SUC,
                     SELF.FINOPEDIDO AS PEDIDO
                FROM DUAL) VALORES
                  ON (DATOS.FIPAIS = VALORES.PAIS
                 AND  DATOS.FICANAL = VALORES.CANAL
                 AND  DATOS.FISUCURSAL = VALORES.SUC
                 AND  DATOS.FINOPEDIDO = VALORES.PEDIDO)
        WHEN MATCHED THEN
             UPDATE
                SET  FNENGANCHE = SELF.FNENGANCHE;

   VL_ERROR := 'ERROR AL ACTUALIZAR EN PEDIDOS_CREDITO';
   MERGE INTO SCVENTASTIENDA.pedidos_credito PC
         USING (SELECT PACABECERO.FIPAISID AS PAIS,
                       PACABECERO.FICANALID AS CANAL,
                       PACABECERO.FISUCURSALID AS SUC,
                       SELF.FINOPEDIDO AS PEDIDO
                  FROM DUAL) VALORES
                    ON (PC.FIPAISID = VALORES.PAIS
                   AND  PC.FICANAL = VALORES.CANAL
                   AND  PC.FISUCURSAL = VALORES.SUC
                   AND  PC.FINOPEDIDO = VALORES.PEDIDO)
          WHEN MATCHED THEN
               UPDATE
                  SET  FDCSALDOORIGINAL = SELF.FNPEDTOTAL,
                       FNIMPTOTVENTA = SELF.FNPEDTOTAL,
                       FNSALDO = SELF.FNPEDSALDO,
                       FNENGANCHE = SELF.FNENGANCHE;

   EXCEPTION
       WHEN OTHERS THEN
         ROLLBACK;
         VL_ORACOD :=SQLCODE;
         VL_ORADESC :=  SUBSTR(SQLERRM, CSL_0,CSL_200);
         --SE LLAMA AL SP PARA GUARDAR TXN EN ERROR
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_115',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
        END;
    RETURN 0;
  END ;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_115" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_115" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_115" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_115" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_115" TO "USRVENTAST";
