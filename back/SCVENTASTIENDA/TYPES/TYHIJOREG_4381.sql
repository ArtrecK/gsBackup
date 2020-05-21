--------------------------------------------------------
--  DDL for Type TYHIJOREG_4381
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_4381" UNDER TYTRANSACCION(
fiidnegocio  number(3),
fiidtienda  number(5),
fiidcliente  number(10),
fingcioid  number(3),
finotienda  number(5),
ficteid  number(10),
fidigitover  number(3),
fdcreacion  date,
fdmodifico  date,
fcusrmodifico  varchar2(30),
  CONSTRUCTOR FUNCTION TYHIJOREG_4381(SELF IN OUT NOCOPY TYHIJOREG_4381, pa_registerData XMLTYPE)
                               RETURN SELF AS RESULT,
  OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO(PACABECERO IN scventastienda.TYCABECEROTXN) RETURN INTEGER
)NOT FINAL INSTANTIABLE  ;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_4381" AS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: SUBTYPES PARA PROCESAMIENTO DE TRANSACCIONES DEL SENDER,TIPO DE REGISTRO 4381
Creador: Cesar David Campos Garcia
Fecha de creacion: 20/05/2019
**************************************************************************************************/
CONSTRUCTOR FUNCTION TYHIJOREG_4381(SELF IN OUT NOCOPY TYHIJOREG_4381, pa_registerData XMLTYPE)
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
   VL_ERROR := 'ERROR AL INSERTAR EN TACREDCTECTES';
   MERGE INTO SCVENTASTIENDA.TACREDCTECTES CLI
        USING (SELECT PACABECERO.FIPAISID AS PAIS,
                      PACABECERO.FICANALID AS CANAL,
                      PACABECERO.FISUCURSALID AS SUCURSAL,
                      SELF.FIIDNEGOCIO AS IDNEGOCIO,
                      SELF.FIIDTIENDA AS IDTIENDA,
                      SELF.FIIDCLIENTE AS IDCLIENTE
                 FROM DUAL) TMP
           ON (TMP.PAIS = CLI.FIPAIS
               AND TMP.CANAL = CLI.FICANAL
               AND TMP.SUCURSAL = CLI.FISUCURSAL
               AND TMP.IDNEGOCIO = CLI.FIIDNEGOCIO
               AND TMP.IDTIENDA = CLI.FIIDTIENDA
               AND TMP.IDCLIENTE = CLI.FIIDCLIENTE
              )
   WHEN NOT MATCHED THEN
      INSERT (
              FIPAIS,
              FICANAL,
              FISUCURSAL,
              FIIDNEGOCIO,
              FIIDTIENDA,
              FIIDCLIENTE,
              FINGCIOID,
              FINOTIENDA,
              FICTEID,
              FIDIGITOVER,
              FDFECHAALTA
             )
      VALUES (PACABECERO.FIPAISID,
              PACABECERO.FICANALID,
              PACABECERO.FISUCURSALID,
              SELF.FIIDNEGOCIO,
              SELF.FIIDTIENDA,
              SELF.FIIDCLIENTE,
              SELF.FINGCIOID,
              SELF.FINOTIENDA,
              SELF.FICTEID,
              SELF.FIDIGITOVER,
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
                                       VL_ERROR||' -> '||VL_ORACOD||'-'||VL_ORADESC||'-> TYHIJOREG_4381',
                                       CSL_1,
                                       VL_ORACOD,
                                       VL_ORADESC);
                                       END;

RETURN 0;
END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4381" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4381" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4381" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4381" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_4381" TO "USRVENTAST";
