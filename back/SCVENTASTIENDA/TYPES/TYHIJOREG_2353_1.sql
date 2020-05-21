--------------------------------------------------------
--  DDL for Type TYHIJOREG_2353
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_2353" UNDER TYTRANSACCION(
finopedido  number(10),
fitir  number(5),
fdfecsurt  date,
fnprcbnfpgpntl  number(13,6),
fntsglbnormalanulsniva  number(13,6),
fntsglbpuntualanulsniva  number(13,6),
fniva  number(13,6),
fdcreacion    date,
fdmodifico    date,
fcusrmodifico    varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_2353(SELF IN OUT NOCOPY TYHIJOREG_2353, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_2353" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 2353
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_2353(SELF IN OUT NOCOPY TYHIJOREG_2353, pa_registerData XMLTYPE)
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
      VL_ERROR :='ERROR AL INSERTAR EN TAPEDCIFRASCTRL';
      MERGE INTO SCVENTASTIENDA.TAPEDCIFRASCTRL PED
           USING (SELECT PACABECERO.FIPAISID AS PAIS,
                         PACABECERO.FICANALID AS CANAL,
                         PACABECERO.FISUCURSALID AS SUCURSAL,
                         SELF.FINOPEDIDO AS NOPEDIDO
                    FROM DUAL) TEM
              ON (TEM.PAIS = PED.FIPAIS AND
                  TEM.CANAL = PED.FICANAL AND
                  TEM.SUCURSAL = PED.FISUCURSAL AND
                  TEM.NOPEDIDO = PED.FINOPEDIDO
                 )
      WHEN NOT MATCHED THEN
         INSERT ( fipais,
                  ficanal,
                  fisucursal,
                  fitranno,
                  finopedido,
                  fitir,
                  fdfecsurt,
                  fnprcbnfpgpntl,
                  fntsglbnormalanulsniva,
                  fntsglbpuntualanulsniva,
                  fniva,
                  fdcreacion,
                  fdmodifico,
                  fcusrmodifico
                   )
         VALUES(PACABECERO.FIPAISID,
                PACABECERO.FICANALID,
                PACABECERO.FISUCURSALID,
                PACABECERO.FITRANNO,
                SELF.finopedido,
                SELF.fitir,
                SELF.fdfecsurt,
                SELF.fnprcbnfpgpntl,
                SELF.fntsglbnormalanulsniva,
                SELF.fntsglbpuntualanulsniva,
                SELF.fniva,
                SYSDATE,
                SYSDATE,
                VL_USER);  


   VL_ERROR := 'ERROR AL ACTUALIZAR EN TACREDITO';
   MERGE INTO SCVENTASTIENDA.TACREDITO CRE
       USING (SELECT PACABECERO.FIPAISID AS  PAIS,
                     PACABECERO.FICANALID AS  CANAL,
                     PACABECERO.FISUCURSALID AS  SUC,
                     SELF.FINOPEDIDO AS  PEDIDO
                FROM DUAL) VALORES
                  ON (CRE.FIPAIS = VALORES.PAIS
                 AND  CRE.FICANAL = VALORES.CANAL
                 AND  CRE.FISUCURSAL = VALORES.SUC
                 AND  CRE.FINOPEDIDO = VALORES.PEDIDO)
        WHEN MATCHED THEN
             UPDATE
                SET  FITIR = SELF.fitir;            

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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_2353',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2353" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2353" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2353" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2353" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_2353" TO "USRVENTAST";
