--------------------------------------------------------
--  DDL for Type TYHIJOREG_75
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_75" 
                     UNDER TYTRANSACCION
                  (
                     fcpobdesc VARCHAR2 (40 CHAR),
                     fcedodesc VARCHAR2 (20 CHAR),
                     fcctesexo VARCHAR2 (1 CHAR),
                     fcctetel VARCHAR2 (15 CHAR),
                     fccterfc VARCHAR2 (14 CHAR),
                     fcctefismor VARCHAR2 (2 CHAR),
                     fiedocivil NUMBER (3),
                     fdctefecnac DATE,
                     fitdaatiende NUMBER (5),
                     fdcreacion DATE,
                     fdmodifico DATE,
                     fcusrmodifico VARCHAR2 (30),
                     CONSTRUCTOR FUNCTION TYHIJOREG_75 (
                        SELF              IN OUT NOCOPY TYHIJOREG_75,
                        pa_registerData                 XMLTYPE)
                        RETURN SELF AS RESULT,
                     OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
                        PACABECERO IN scventastienda.TYCABECEROTXN)
                        RETURN INTEGER)
                     NOT FINAL
                     INSTANTIABLE
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_75" 
AS
   CONSTRUCTOR FUNCTION TYHIJOREG_75 (
      SELF              IN OUT NOCOPY TYHIJOREG_75,
      pa_registerData                 XMLTYPE)
      RETURN SELF AS RESULT
   AS
   BEGIN
      pa_registerData.TOOBJECT (SELF);
      RETURN;
   END;

   OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
      PACABECERO IN scventastienda.TYCABECEROTXN)
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
         VL_ERROR := 'ERROR AL ACTUALIZAR EN TACLIENTES';

         MERGE INTO SCVENTASTIENDA.TACLIENTES DATOS
              USING (SELECT PACABECERO.FIPAISID AS PAIS,
                            PACABECERO.FICANALID AS CANAL,
                            PACABECERO.FISUCURSALID AS SUCURSAL,
                            PACABECERO.FITRANNO AS TRANNO
                       FROM DUAL) VALORES
                 ON (    DATOS.FIPAIS = VALORES.PAIS
                     AND DATOS.FICANAL = VALORES.CANAL
                     AND DATOS.FISUCURSAL = VALORES.SUCURSAL
                     AND DATOS.FITRANNOACT = VALORES.TRANNO)
         WHEN MATCHED
         THEN
            UPDATE SET FCCTESEXO = SELF.fcctesexo,
                       FCCTETEL = SELF.fcctetel,
                       FCCTERFC = SELF.fccterfc,
                       FCCTEFISMOR = SELF.fcctefismor,
                       FITDAATIENDE = SELF.fitdaatiende,
                       FIEDOCIVIL = SELF.fiedocivil,
                       FDCTEFECNAC = SELF.fdctefecnac;
      EXCEPTION
         WHEN OTHERS
         THEN
            ROLLBACK;
            VL_ORACOD := SQLCODE;
            VL_ORADESC := SUBSTR (SQLERRM, CSL_0, CSL_200);
            --LLAMA AL SP PARA GUARDAR TXN EN ERROR
            SCVENTASTIENDA.
             SPTRANSACERROR (
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
               || '-> TYHIJOREG_75',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_75" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_75" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_75" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_75" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_75" TO "USRVENTAST";
