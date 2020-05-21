--------------------------------------------------------
--  DDL for Type TYHIJOREG_217
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_217" 
   UNDER TYTRANSACCION
(
   finopedido NUMBER (10),
   fcempno VARCHAR2 (6 CHAR),
   fncomisionv NUMBER (7, 2),
   fncomisiong NUMBER (7, 2),
   fdcreacion DATE,
   fdmodifico DATE,
   fcusrmodifico VARCHAR2 (30),
   CONSTRUCTOR FUNCTION TYHIJOREG_217 (
      SELF              IN OUT NOCOPY TYHIJOREG_217,
      pa_registerData                 XMLTYPE)
      RETURN SELF AS RESULT,
   OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
      PACABECERO   IN scventastienda.TYCABECEROTXN)
      RETURN INTEGER
)
   NOT FINAL INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_217" 
AS
   /*************************************************************************************************
   Proyecto: Sistema de Gestion
   Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 217
   Creador: Cesar David Campos Garcia
   Fecha de creacion: 20/05/2019
   **************************************************************************************************/
   CONSTRUCTOR FUNCTION TYHIJOREG_217 (
      SELF              IN OUT NOCOPY TYHIJOREG_217,
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
      CSL_0     CONSTANT PLS_INTEGER := 0;
      CSL_1     CONSTANT PLS_INTEGER := 1;
      CSL_200   CONSTANT PLS_INTEGER := 200;
      VL_ERROR           VARCHAR2 (100);
      VL_ORACOD          NUMBER;
      VL_ORADESC         VARCHAR2 (2000);
   BEGIN
      BEGIN
         VL_ERROR := 'ERROR AL ACTUALIZAR EN TADETPEDIDOS';

         MERGE INTO SCVENTASTIENDA.TADETPEDIDOS DATOS
              USING (SELECT PACABECERO.FIPAISID PAIS,
                            PACABECERO.FICANALID CANAL,
                            PACABECERO.FISUCURSALID SUC,
                            SELF.finopedido AS PEDIDO
                       FROM DUAL) VALORES
                 ON (    DATOS.FIPAIS = VALORES.PAIS
                     AND DATOS.FICANAL = VALORES.CANAL
                     AND DATOS.FISUCURSAL = VALORES.SUC
                     AND DATOS.FINOPEDIDO = VALORES.PEDIDO)
         WHEN MATCHED
         THEN
            UPDATE SET
               FNCOMISIONG = SELF.fncomisiong, FNCOMISIONV = SELF.fncomisionv;
      EXCEPTION
         WHEN OTHERS
         THEN
            ROLLBACK;
            VL_ORACOD := SQLCODE;
            VL_ORADESC := SUBSTR (SQLERRM, CSL_0, CSL_200);
            --LLAMA AL SP PARA GUARDAR TXN EN ERROR
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
               || '-> TYHIJOREG_217',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_217" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_217" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_217" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_217" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_217" TO "USRVENTAST";
