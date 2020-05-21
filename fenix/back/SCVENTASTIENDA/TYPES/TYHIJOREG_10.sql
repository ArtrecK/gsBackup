--------------------------------------------------------
--  DDL for Type TYHIJOREG_10
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_10" 
                     UNDER TYTRANSACCION
                  (
                     FINGCIOID NUMBER (3),
                     FINOTIENDA NUMBER (5),
                     FICTEID NUMBER (10),
                     FIDIGITOVER NUMBER (3),
                     FIOCUID NUMBER (5),
                     FCCTENOMBRE VARCHAR2 (18 CHAR),
                     FCCTEAPATERNO VARCHAR2 (18 CHAR),
                     FCCTEAMATERNO VARCHAR2 (18 CHAR),
                     FCCTEDIRCALLE VARCHAR2 (25 CHAR),
                     FCCTEDIRNOEXT VARCHAR2 (5 CHAR),
                     FCCTEDIRNOINT VARCHAR2 (5 CHAR),
                     FCCTECP VARCHAR2 (5 CHAR),
                     FCCTECOLONIA VARCHAR2 (40 CHAR),
                     FDCREACION DATE,
                     FDMODIFICO DATE,
                     FCUSRMODIFICO VARCHAR2 (30),
                     CONSTRUCTOR FUNCTION TYHIJOREG_10 (
                        SELF              IN OUT NOCOPY TYHIJOREG_10,
                        pa_registerData                 XMLTYPE)
                        RETURN SELF AS RESULT,
                     OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
                        PACABECERO IN scventastienda.TYCABECEROTXN)
                        RETURN INTEGER)
                     NOT FINAL
                     INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_10" 
AS
   CONSTRUCTOR FUNCTION TYHIJOREG_10 (
      SELF              IN OUT NOCOPY TYHIJOREG_10,
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
      VL_COBRADOR        VARCHAR2 (1) := '0';
   --INICIO DE LA FUNCION
   BEGIN
      BEGIN
         VL_ERROR := 'ERROR AL ACTUALIZAR/INSERTAR EN TACLIENTES';

         MERGE INTO SCVENTASTIENDA.TACLIENTES CTE
              USING (SELECT PACABECERO.FIPAISID AS PAIS,
                            PACABECERO.FICANALID AS CANAL,
                            PACABECERO.FISUCURSALID AS SUCURSAL,
                            SELF.FINGCIOID AS NGCIOID,
                            SELF.FINOTIENDA AS NOTIENDA,
                            SELF.FICTEID AS CTEID,
                            SELF.FIDIGITOVER AS DIGITOVER
                       FROM DUAL) TMP
                 ON (    CTE.FIPAIS = TMP.PAIS
                     AND CTE.FICANAL = TMP.CANAL
                     AND CTE.FISUCURSAL = TMP.SUCURSAL
                     AND CTE.FINGCIOID = TMP.NGCIOID
                     AND CTE.FINOTIENDA = TMP.NOTIENDA
                     AND CTE.FICTEID = TMP.CTEID
                     AND CTE.FIDIGITOVER = TMP.DIGITOVER)
         WHEN MATCHED
         THEN
            UPDATE SET FIOCUID = SELF.FIOCUID,
                       FCCTENOMBRE = SELF.FCCTENOMBRE,
                       FCCTEAPATERNO = SELF.FCCTEAPATERNO,
                       FCCTEAMATERNO = SELF.FCCTEAMATERNO,
                       FCCTEDIRCALLE = SELF.FCCTEDIRCALLE,
                       FCCTEDIRNOEXT = SELF.FCCTEDIRNOEXT,
                       FCCTEDIRNOINT = SELF.FCCTEDIRNOINT,
                       FCCTECP = SELF.FCCTECP,
                       FCCTECOLONIA = SELF.FCCTECOLONIA,
                       FITRANNO = PACABECERO.FITRANNO
         WHEN NOT MATCHED
         THEN
            INSERT     (FIPAIS,
                        FICANAL,
                        FISUCURSAL,
                        FINGCIOID,
                        FINOTIENDA,
                        FICTEID,
                        FIDIGITOVER,
                        FIOCUID,
                        FCCTENOMBRE,
                        FCCTEAPATERNO,
                        FCCTEAMATERNO,
                        FCCTEDIRCALLE,
                        FCCTEDIRNOEXT,
                        FCCTEDIRNOINT,
                        FCCTECP,
                        FCCTECOLONIA,
                        FDCTEFECALT,
                        FICTEECO,
                        FCNOCOBRADOR,
                        FITRANNO)
                VALUES (PACABECERO.FIPAISID,
                        PACABECERO.FICANALID,
                        PACABECERO.FISUCURSALID,
                        SELF.FINGCIOID,
                        SELF.FINOTIENDA,
                        SELF.FICTEID,
                        SELF.FIDIGITOVER,
                        SELF.FIOCUID,
                        SELF.FCCTENOMBRE,
                        SELF.FCCTEAPATERNO,
                        SELF.FCCTEAMATERNO,
                        SELF.FCCTEDIRCALLE,
                        SELF.FCCTEDIRNOEXT,
                        SELF.FCCTEDIRNOINT,
                        SELF.FCCTECP,
                        SELF.FCCTECOLONIA,
                        SYSDATE,
                        CSL_0,
                        VL_COBRADOR,
                        PACABECERO.FITRANNO);
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
               || '-> TYHIJOREG_10',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_10" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_10" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_10" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_10" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_10" TO "USRVENTAST";
