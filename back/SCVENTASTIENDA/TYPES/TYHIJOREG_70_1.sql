--------------------------------------------------------
--  DDL for Type TYHIJOREG_70
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_70" 
                     UNDER TYTRANSACCION
                  (
                     fingcioid NUMBER (3),
                     finotienda NUMBER (5),
                     ficteid NUMBER (10),
                     fidigitover NUMBER (3),
                     fcctenombre VARCHAR2 (18 CHAR),
                     fccteapaterno VARCHAR2 (18 CHAR),
                     fccteamaterno VARCHAR2 (18 CHAR),
                     fcctedircalle VARCHAR2 (25 CHAR),
                     fcctedirnoext VARCHAR2 (5 CHAR),
                     fcctedirnoint VARCHAR2 (5 CHAR),
                     fcctecp VARCHAR2 (5 CHAR),
                     fcctecolonia VARCHAR2 (40 CHAR),
                     fdcreacion DATE,
                     fdmodifico DATE,
                     fcusrmodifico VARCHAR2 (30),
                     CONSTRUCTOR FUNCTION TYHIJOREG_70 (
                        SELF              IN OUT NOCOPY TYHIJOREG_70,
                        pa_registerData                 XMLTYPE)
                        RETURN SELF AS RESULT,
                     OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
                        PACABECERO IN scventastienda.TYCABECEROTXN)
                        RETURN INTEGER)
                     NOT FINAL
                     INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_70" 
AS
   CONSTRUCTOR FUNCTION TYHIJOREG_70 (
      SELF              IN OUT NOCOPY TYHIJOREG_70,
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
      CSL_0     CONSTANT PLS_INTEGER := 0;
      CSL_1     CONSTANT PLS_INTEGER := 1;
      CSL_200   CONSTANT PLS_INTEGER := 200;
      VL_ORACOD          NUMBER;
      VL_ORADESC         VARCHAR2 (2000);
   --INICIO DE LA FUNCION
   BEGIN
      BEGIN
         VL_ERROR := 'ERROR AL ACTUALIZAR/INSERTAR TACLIENTES';

         MERGE INTO SCVENTASTIENDA.TACLIENTES CLI
              USING (SELECT PACABECERO.FIPAISID AS PAIS,
                            PACABECERO.FICANALID AS CANAL,
                            PACABECERO.FISUCURSALID AS SUCURSAL,
                            SELF.fingcioid AS NGCIOID,
                            SELF.finotienda AS NOTIENDA,
                            SELF.ficteid AS CTEID,
                            SELF.fidigitover AS DIGITOVER
                       FROM DUAL) VALORES
                 ON (    CLI.FIPAIS = VALORES.PAIS
                     AND CLI.FICANAL = VALORES.CANAL
                     AND CLI.FISUCURSAL = VALORES.SUCURSAL
                     AND CLI.FINGCIOID = VALORES.NGCIOID
                     AND CLI.FINOTIENDA = VALORES.NOTIENDA
                     AND CLI.FICTEID = VALORES.CTEID
                     AND CLI.FIDIGITOVER = VALORES.DIGITOVER)
         WHEN MATCHED
         THEN
            UPDATE SET FCCTENOMBRE = SELF.fcctenombre,
                       FCCTEAPATERNO = SELF.fccteapaterno,
                       FCCTEAMATERNO = SELF.fccteamaterno,
                       FCCTEDIRCALLE = SELF.fcctedircalle,
                       FCCTEDIRNOEXT = SELF.fcctedirnoext,
                       FCCTEDIRNOINT = SELF.fcctedirnoint,
                       FCCTECP = SELF.fcctecp,
                       FCCTECOLONIA = SELF.fcctecolonia,
                       FITRANNOACT = PACABECERO.FITRANNO
         WHEN NOT MATCHED
         THEN
            INSERT     (FIPAIS,
                        FICANAL,
                        FISUCURSAL,
                        FINGCIOID,
                        FINOTIENDA,
                        FICTEID,
                        FIDIGITOVER,
                        FCCTENOMBRE,
                        FCCTEAPATERNO,
                        FCCTEAMATERNO,
                        FCCTEDIRCALLE,
                        FCCTEDIRNOEXT,
                        FCCTEDIRNOINT,
                        FCCTECP,
                        FCCTECOLONIA,
                        FITRANNO,
                        FITRANNOACT,
                        FDCTEFECALT)
                VALUES (PACABECERO.FIPAISID,
                        PACABECERO.FICANALID,
                        PACABECERO.FISUCURSALID,
                        SELF.fingcioid,
                        SELF.finotienda,
                        SELF.ficteid,
                        SELF.fidigitover,
                        SELF.fcctenombre,
                        SELF.fccteapaterno,
                        SELF.fccteamaterno,
                        SELF.fcctedircalle,
                        SELF.fcctedirnoext,
                        SELF.fcctedirnoint,
                        SELF.fcctecp,
                        SELF.fcctecolonia,
                        PACABECERO.FITRANNO,
                        PACABECERO.FITRANNO,
                        SYSDATE);
      EXCEPTION
         WHEN OTHERS
         THEN
            ROLLBACK;
            VL_ORACOD := SQLCODE;
            VL_ORADESC := SUBSTR (SQLERRM, CSL_0, CSL_200);
            --LLAMAR AL SP PARA GUARDAR TXN EN ERROR
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
               || '-> TYHIJOREG_70',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_70" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_70" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_70" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_70" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_70" TO "USRVENTAST";
