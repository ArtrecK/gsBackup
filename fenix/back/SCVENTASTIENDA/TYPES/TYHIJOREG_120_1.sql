--------------------------------------------------------
--  DDL for Type TYHIJOREG_120
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_120" UNDER TYTRANSACCION(
FITIPOOP  NUMBER(5),
FINOPEDIDO  NUMBER(10),
FIMOVPCARABO  NUMBER(3),
FDFECMOVTOPED  DATE,
FNMOVPIMP  NUMBER(13,2),
FICONCEPMOV  NUMBER(5),
FINGCIOID  NUMBER(3),
FINOTIENDA  NUMBER(5),
FICTEID  NUMBER(10),
FIDIGITOVER  NUMBER(3),
FITIPOVENTA  NUMBER(3),
FICONSNOMOVTO  NUMBER(10),
FITDAORIGEN  NUMBER(5),
FDCREACION  DATE,
FDMODIFICO  DATE,
FCUSRMODIFICO  VARCHAR2(30),
CONSTRUCTOR FUNCTION TYHIJOREG_120(SELF IN OUT NOCOPY TYHIJOREG_120, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_120" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 120
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_120(SELF IN OUT NOCOPY TYHIJOREG_120, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT AS

BEGIN
  pa_registerData.TOOBJECT(SELF);
    RETURN;
END;

OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN)
RETURN INTEGER AS

VL_ERROR VARCHAR2(100);
VL_ORACOD NUMBER;
VL_ORADESC VARCHAR2(2000);
CSL_0 CONSTANT PLS_INTEGER :=0;
CSL_1 CONSTANT PLS_INTEGER :=1;
CSL_4 CONSTANT PLS_INTEGER :=4;
CSL_6 CONSTANT PLS_INTEGER :=6;
CSL_108 CONSTANT PLS_INTEGER :=108;
CSL_200 CONSTANT PLS_INTEGER :=200;

BEGIN
  BEGIN
   VL_ERROR := 'ERROR AL INSERTAR EN TAMOVPEDIDOS';
   IF(SELF.FITIPOOP IN (CSL_6,CSL_4,CSL_108))THEN
      MERGE INTO SCVENTASTIENDA.TAMOVPEDIDOS DET
           USING (SELECT PACABECERO.FIPAISID AS PAIS,
                         PACABECERO.FICANALID AS CANAL,
                         PACABECERO.FISUCURSALID AS SUCURSAL,
                         SELF.FINOPEDIDO AS NOPEDIDO,
                         SELF.FICONSNOMOVTO AS NOMOVTO
                    FROM DUAL) TMP
              ON (TMP.PAIS = DET.FIPAIS
                  AND TMP.CANAL = DET.FICANAL
                  AND TMP.SUCURSAL = DET.FISUCURSAL
                  AND TMP.NOPEDIDO = DET.FINOPEDIDO
                  AND TMP.NOMOVTO = DET.FINOMOVTO
                 )
      WHEN NOT MATCHED THEN
         INSERT (
                 FIPAIS,
                 FICANAL,
                 FISUCURSAL,
                 FINOPEDIDO,
                 FINOMOVTO,
                 FINOTRANSAC,
                 FITIPOOP,
                 FDFECMOVTOPED,
                 FIMOVPCARABO,
                 FNMOVPIMP,
                 FCUSERID,
                 FCWS,
                 FICONCEPMOV
                )
         VALUES (PACABECERO.FIPAISID,
                 PACABECERO.FICANALID,
                 PACABECERO.FISUCURSALID,
                 SELF.FINOPEDIDO,
                 SELF.FICONSNOMOVTO,
                 PACABECERO.FITRANNO,
                 SELF.FITIPOOP,
                 SELF.FDFECMOVTOPED,
                 SELF.FIMOVPCARABO,
                 SELF.FNMOVPIMP,
                 ' ',
                 ' ',
                 SELF.FICONCEPMOV
                 );
   END IF;

    VL_ERROR := 'ERROR AL INSERTAR EN PEDIDOS_CREDITO';
    MERGE INTO SCVENTASTIENDA.PEDIDOS_CREDITO PC
           USING (SELECT PACABECERO.FIPAISID AS PAIS,
                         PACABECERO.FICANALID AS CANAL,
                         PACABECERO.FISUCURSALID AS SUCURSAL,
                         SELF.FINOPEDIDO AS NOPEDIDO
                    FROM DUAL) TMP
              ON (TMP.PAIS = PC.FIPAISID
                  AND TMP.CANAL = PC.FICANAL
                  AND TMP.SUCURSAL = PC.FISUCURSAL
                  AND TMP.NOPEDIDO = PC.FINOPEDIDO
                  )
   WHEN MATCHED THEN
     UPDATE
        SET FDFECHACANC = SELF.FDFECMOVTOPED;

    EXCEPTION
       WHEN OTHERS THEN
         ROLLBACK;
         VL_ORACOD :=SQLCODE;
         VL_ORADESC :=  SUBSTR(SQLERRM, CSL_0,CSL_200);
         --SE LLAMA AL SP PARA GUARDAR 
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_120',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
     END;
RETURN 0;
END ;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_120" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_120" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_120" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_120" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_120" TO "USRVENTAST";
