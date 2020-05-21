--------------------------------------------------------
--  DDL for Type TYHIJOREG_100
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_100" UNDER TYTRANSACCION(
FINOPEDIDO  NUMBER(10),
FINGCIOID  NUMBER(3),
FINOTIENDA  NUMBER(5),
FICTEID  NUMBER(10),
FIDIGITOVER  NUMBER(3),
FITIPOVENTA  NUMBER(3),
FDPEDFEC  DATE,
FIPLAZO_  NUMBER(3),
FIPERIODO  NUMBER(3),
FNPEDPAGOPER  NUMBER(9,2),
FNPEDULTPAGO  NUMBER(9,2),
FCFOLIOPARAM  NUMBER(10),
FCEMPNO  VARCHAR2(6 CHAR),
FNIMPANTICIPO  NUMBER(9,2),
FDLIMVIGENCIA  DATE,
FITIPOCTA  NUMBER(3),
FIPLAZO  NUMBER(5),
FDCREACION  DATE,
FDMODIFICO  DATE,
FCUSRMODIFICO  VARCHAR2(30),
CONSTRUCTOR FUNCTION TYHIJOREG_100(SELF IN OUT NOCOPY TYHIJOREG_100, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_100" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 100
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_100(SELF IN OUT NOCOPY TYHIJOREG_100, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT AS

  BEGIN
    pa_registerData.TOOBJECT(SELF);
    RETURN;
  END ;

  OVERRIDING MEMBER FUNCTION  FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN)
                               RETURN INTEGER AS

  CSL_0 CONSTANT PLS_INTEGER :=0;
  CSL_1 CONSTANT PLS_INTEGER :=1;
  CSL_2 CONSTANT PLS_INTEGER :=2;
  CSL_4 CONSTANT PLS_INTEGER :=4;
  CSL_200 CONSTANT PLS_INTEGER :=200;
  VL_VTL VARCHAR2(6):='999999';
  VL_CERO VARCHAR2(1) :='0';
  VL_OBSERVAC VARCHAR2(16):='SIN OBSERVACION';
  VL_USER VARCHAR2(13):='VENTASTIENDA';
  VL_ERROR VARCHAR2(100);
  VL_ORACOD NUMBER;
  VL_ORADESC VARCHAR2(2000);

  BEGIN
       BEGIN
   VL_ERROR:= 'ERROR AL INSERTAR EN TAPEDIDOS';
   MERGE INTO SCVENTASTIENDA.TAPEDIDOS PED
        USING (SELECT PACABECERO.FIPAISID AS PAIS,
                      PACABECERO.FICANALID AS CANAL,
                      PACABECERO.FISUCURSALID AS SUCURSAL,
                      SELF.FINOPEDIDO AS NOPEDIDO
                 FROM DUAL) TMP
           ON (TMP.PAIS = PED.FIPAIS
               AND TMP.CANAL = PED.FICANAL
               AND TMP.SUCURSAL = PED.FISUCURSAL
               AND TMP.NOPEDIDO = PED.FINOPEDIDO
              )
   WHEN NOT MATCHED THEN
      INSERT (FIPAIS,
              FICANAL,
              FISUCURSAL,
              FINOPEDIDO,
              FINGCIOID,
              FINOTIENDA,
              FICTEID,
              FIDIGITOVER,
              FCEMPNOVENTA,
              FITIPOVENTA,
              FDPEDFEC,
              FIFOLIOPARAM,
              FDFECHAARRIBO
              )
      VALUES (PACABECERO.FIPAISID,
              PACABECERO.FICANALID,
              PACABECERO.FISUCURSALID,
              SELF.FINOPEDIDO,
              SELF.FINGCIOID,
              SELF.FINOTIENDA,
              SELF.FICTEID,
              SELF.FIDIGITOVER,
              trim(SELF.FCEMPNO),
              SELF.FITIPOVENTA,
              SELF.FDPEDFEC,
              SELF.FCFOLIOPARAM,
              SYSDATE);

      VL_ERROR := 'ERROR AL INSERTAR EN PEDIDOS_CREDITO';
      MERGE INTO SCVENTASTIENDA.PEDIDOS_CREDITO CRED
           USING (SELECT PACABECERO.FIPAISID AS PAIS,
                         PACABECERO.FICANALID AS CANAL,
                         PACABECERO.FISUCURSALID AS SUCURSAL,
                         SELF.FINOPEDIDO AS NOPEDIDO
                    FROM DUAL) TEM
              ON (TEM.PAIS = CRED.FIPAISID AND
                  TEM.CANAL = CRED.FICANAL AND
                  TEM.SUCURSAL = CRED.FISUCURSAL AND
                  TEM.NOPEDIDO = CRED.FINOPEDIDO
                 )
      WHEN NOT MATCHED THEN
         INSERT (
                  FIPAISID,
                  FICANAL,
                  FISUCURSAL,
                  FINOPEDIDO,
                  FINGCIOID,
                  FINOTIENDA,
                  FICTEID,
                  FIDIGITOVER,
                  FIPLAZO,
                  FIPERIODO,
                  FNENGANCHE,
                  FNIMPORTEABONO,
                  FICLASIFCUENTA,
                  FNMORATORIOS,
                  FNULTIMPMORA,
                  FIDIASGRACIA,
                  FCSTATCARTERA,
                  FNIMPPAGARBONIF,
                  FIZONAid,
                  FIDEPTOID,
                  FIEMISION,
                  FISTATUSEMISION,
                  FDCINTTOTXATRASO,
                  FNCREDVARIOS,
                  FIDIASSERV,
                  FIIDORIGEN,
                  FISTATUSREGIONAL,
                  FINOGESTIONES,
                  FIGESTSINCOBRO,
                  FIRESULUVISITA,
                  FINOPAGOS,
                  FDFECULTACT,
                  FIDESPID,
                  FINOVECESATR,
                  FIRUTA,
                  FDCSALDOCAPITAL,
                  FISEMATRAS,
                  FITIPODEPTO,
                  FNPRECIOD,
                  FISERIE,
                  FCEMPNUMET,
                  FCCLASCAR,
                  FISALDOIDNCALVENC,
                  FNBONIFICA,
                  FNULTABONOMORA,
                  FDCINTXFINANCIAR,
                  FISOLICITUDID,
                  FCFOLIOPARAM,
                  FITIPOCLIENTE,
                  FIPERATRAACUM,
                  FDULTIMAVISITA,
                  FIIDZONACOBZA,
                  FIPAGOSINTERESES,
                  FCOBSERVACION,
                  FNIMPORTEULTPAGO,
                  FIPAGOSCAPITAL,
                  FDMODIFICACION,
                  FCUSRMODIFICACION
                )
         VALUES (
                  PACABECERO.FIPAISID,
                  PACABECERO.FICANALID,
                  PACABECERO.FISUCURSALID,
                  SELF.FINOPEDIDO,
                  SELF.FINGCIOID,
                  SELF.FINOTIENDA,
                  SELF.FICTEID,
                  SELF.FIDIGITOVER,
                  SELF.FIPLAZO,
                  SELF.FIPERIODO,
                  CSL_0,
                  SELF.FNPEDPAGOPER,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  VL_CERO,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_1,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  sysdate,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  VL_VTL,
                  VL_CERO,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  CSL_0,
                  SYSDATE,
                  CSL_0,
                  CSL_0,
                  VL_OBSERVAC,
                  SELF.FNPEDULTPAGO,
                  CSL_0,
                  sysdate,
                  VL_USER);

      VL_ERROR := 'ERROR AL ACTUALIZAR TAPREPARAME';
      UPDATE SCVENTASTIENDA.TAPREPARAME
         SET FINOPEDIDO = SELF.FINOPEDIDO
       WHERE FIPAIS = PACABECERO.FIPAISID
         AND FICANAL = PACABECERO.FICANALID
         AND FISUCURSAL = PACABECERO.FISUCURSALID
         AND FIFOLIOPARAM = SELF.FCFOLIOPARAM;

   IF (SELF.FITIPOVENTA = CSL_4) THEN

         VL_ERROR := 'ERROR AL ACTUALIZAR EN TAPEDIDOS';
         UPDATE SCVENTASTIENDA.TAPEDIDOS DET
            SET DET.FCEMPNOSURTE= TRIM(SELF.FCEMPNO)
          where FIFOLIOPARAM = SELF.FCFOLIOPARAM;
         COMMIT;

   ELSIF(SELF.FITIPOVENTA = CSL_2) THEN

          VL_ERROR := 'ERROR AL INSERTAR EN TACREDITO';
          MERGE INTO SCVENTASTIENDA.TACREDITO CRED
               USING (SELECT PACABECERO.FIPAISID AS PAIS,
                             PACABECERO.FICANALID AS CANAL,
                             PACABECERO.FISUCURSALID AS SUCURSAL,
                             SELF.FINOPEDIDO AS NOPEDIDO
                        FROM DUAL) TEM
                  ON (TEM.PAIS = CRED.FIPAIS
                      AND TEM.CANAL = CRED.FICANAL
                      AND TEM.SUCURSAL = CRED.FISUCURSAL
                      AND TEM.NOPEDIDO = CRED.FINOPEDIDO
                     )
          WHEN NOT MATCHED THEN
             INSERT (
                      FIPAIS,
                      FICANAL,
                      FISUCURSAL,
                      FINOPEDIDO,
                      FIPLAZO,
                      FIPERIODO,
                      FNENGANCHE,
                      FNPEDPAGOPER,
                      FNPEDULTPAGO,
                      FICLASIFCUENTA,
                      FNPEDIMPMORA,
                      FNULTIMPMORA,
                      FINOATRASOS,
                      FIPERIODOACT,
                      FINOPERIODOCORR,
                      FIDIASGRACIA,
                      FNIMPPAGADO,
                      FNIMPDEVENG,
                      FCSTATCARTERA,
                      FITIR,
                      FNPAGOMIN,
                      FNIMPBONIF,
                      FIZONACOBRO,
                      FCCOBRADOR,
                      FITIPOCTA
                    )
             VALUES ( PACABECERO.FIPAISID,
                      PACABECERO.FICANALID,
                      PACABECERO.FISUCURSALID,
                      SELF.FINOPEDIDO,
                      SELF.FIPLAZO,
                      SELF.FIPERIODO,
                      CSL_0,
                      SELF.FNPEDPAGOPER,
                      SELF.FNPEDULTPAGO,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      VL_CERO,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      CSL_0,
                      ' ',
                      SELF.FITIPOCTA);
   END IF;
 EXCEPTION
       WHEN OTHERS THEN
         ROLLBACK;
         VL_ORACOD :=SQLCODE;
         VL_ORADESC :=  SUBSTR(SQLERRM, CSL_0,CSL_200);
         --LLAMA AL SP PARA GUARDAR TXN EN ERROR
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_100',
                                       csl_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
        END;
    RETURN 0;
  END ;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_100" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_100" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_100" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_100" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_100" TO "USRVENTAST";
