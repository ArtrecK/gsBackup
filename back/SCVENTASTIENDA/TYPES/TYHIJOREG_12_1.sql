--------------------------------------------------------
--  DDL for Type TYHIJOREG_12
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_12" 
                     UNDER TYTRANSACCION
                  (
                     FCCTESEXO VARCHAR2 (1 CHAR),
                     FCCTETEL VARCHAR2 (15 CHAR),
                     FCCTERFC VARCHAR2 (14 CHAR),
                     FCCTEFISMOR VARCHAR2 (2 CHAR),
                     FITDAATIENDE NUMBER (5),
                     FDCTEFECALT DATE,
                     FIEDOCIVIL NUMBER (3),
                     FNLINEACRED NUMBER (9, 2),
                     FDCTEFECNAC DATE,
                     FCPOBDESC VARCHAR2 (40 CHAR),
                     FCEDODESC VARCHAR2 (20 CHAR),
                     FDCREACION DATE,
                     FDMODIFICO DATE,
                     FCUSRMODIFICO VARCHAR2 (30),
                     CONSTRUCTOR FUNCTION TYHIJOREG_12 (
                        SELF              IN OUT NOCOPY TYHIJOREG_12,
                        pa_registerData                 XMLTYPE)
                        RETURN SELF AS RESULT,
                     OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
                        PACABECERO IN scventastienda.TYCABECEROTXN)
                        RETURN INTEGER)
                     NOT FINAL
                     INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_12" 
AS
   CONSTRUCTOR FUNCTION TYHIJOREG_12 (
      SELF              IN OUT NOCOPY TYHIJOREG_12,
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
      VL_ERROR           VARCHAR2 (100);
      VL_ORACOD          NUMBER;
      VL_ORADESC         VARCHAR2 (2000);
      CSL_0     CONSTANT PLS_INTEGER := 0;
      CSL_1     CONSTANT PLS_INTEGER := 1;
      CSL_200   CONSTANT PLS_INTEGER := 200;
   BEGIN
      BEGIN
         VL_ERROR := 'ERROR AL ACTUALIZAR EN TACLIENTES';

         MERGE INTO SCVENTASTIENDA.TACLIENTES DATOS
              USING (SELECT PACABECERO.FIPAISID AS PAIS,
                            PACABECERO.FICANALID AS CANAL,
                            PACABECERO.FISUCURSALID AS SUCURSAL,
                            PACABECERO.FITRANNO TRANNO
                       FROM DUAL) VALORES
                 ON (    DATOS.FIPAIS = VALORES.PAIS
                     AND DATOS.FICANAL = VALORES.CANAL
                     AND DATOS.FISUCURSAL = VALORES.SUCURSAL
                     AND DATOS.FITRANNO = VALORES.TRANNO)
         WHEN MATCHED
         THEN
            UPDATE SET FCCTESEXO = SELF.FCCTESEXO,
                       FCCTETEL = SELF.FCCTETEL,
                       FCCTERFC = SELF.FCCTERFC,
                       FCCTEFISMOR = SELF.FCCTEFISMOR,
                       FITDAATIENDE = SELF.FITDAATIENDE,
                       FDCTEFECALT = SELF.FDCTEFECALT,
                       FIEDOCIVIL = SELF.FIEDOCIVIL,
                       FNLINEACRED = SELF.FNLINEACRED,
                       FDCTEFECNAC = SELF.FDCTEFECNAC;
      EXCEPTION
         WHEN OTHERS
         THEN
            ROLLBACK;
            VL_ORACOD := SQLCODE;
            VL_ORADESC := SUBSTR (SQLERRM, CSL_0, CSL_200);
            --LLAM AL SP PARA GUARDAR TXN EN ERROR
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
               || '-> TYHIJOREG_12',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_12" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_12" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_12" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_12" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_12" TO "USRVENTAST";
