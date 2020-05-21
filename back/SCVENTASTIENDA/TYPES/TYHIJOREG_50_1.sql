--------------------------------------------------------
--  DDL for Type TYHIJOREG_50
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_50" 
                     UNDER TYTRANSACCION
                  (
                     fcfolioparam NUMBER (10),
                     fingcioid NUMBER (3),
                     finotienda NUMBER (5),
                     ficteid NUMBER (10),
                     fidigitover NUMBER (3),
                     fitipoventa NUMBER (3),
                     fcempno VARCHAR2 (6 CHAR),
                     fiplazo_ NUMBER (3),
                     fiperiodo NUMBER (3),
                     fnpabo NUMBER (9, 2),
                     fnuabo NUMBER (9, 2),
                     fdfecprep DATE,
                     fiautoriza NUMBER (3),
                     fiplazo NUMBER (5),
                     fdcreacion DATE,
                     fdmodifico DATE,
                     fcusrmodifico VARCHAR2 (30),
                     CONSTRUCTOR FUNCTION TYHIJOREG_50 (
                        SELF              IN OUT NOCOPY TYHIJOREG_50,
                        pa_registerData                 XMLTYPE)
                        RETURN SELF AS RESULT,
                     OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
                        PACABECERO IN scventastienda.TYCABECEROTXN)
                        RETURN INTEGER)
                     NOT FINAL
                     INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_50" 
AS
   CONSTRUCTOR FUNCTION TYHIJOREG_50 (
      SELF              IN OUT NOCOPY TYHIJOREG_50,
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
   BEGIN
      BEGIN
         VL_ERROR := 'ERROR AL ACTUALIZAR/INSERTAR EN TAPREPARAME';

         MERGE INTO SCVENTASTIENDA.TAPREPARAME PRE
              USING (SELECT PACABECERO.FIPAISID AS PAIS,
                            PACABECERO.FICANALID AS CANAL,
                            PACABECERO.FISUCURSALID AS SUCURSAL,
                            SELF.fcfolioparam AS FOLIOPARAM
                       FROM DUAL) VALORES
                 ON (    PRE.FIPAIS = VALORES.PAIS
                     AND PRE.FICANAL = VALORES.CANAL
                     AND PRE.FISUCURSAL = VALORES.SUCURSAL
                     AND PRE.FIFOLIOPARAM = VALORES.FOLIOPARAM)
         WHEN MATCHED
         THEN
            UPDATE SET
               FNPABO = SELF.fnpabo,
               FNUABO = SELF.fnuabo,
               FIPLAZO = SELF.fiplazo
         WHEN NOT MATCHED
         THEN
            INSERT     (FIPAIS,
                        FICANAL,
                        FISUCURSAL,
                        FIFOLIOPARAM,
                        FINGCIOID,
                        FINOTIENDA,
                        FICTEID,
                        FIDIGITOVER,
                        FITIPOVENTA,
                        FCEMPNO,
                        FIPLAZO,
                        FIPERIODO,
                        FNPABO,
                        FNUABO,
                        FDFECPREP,
                        FIAUTORIZA,
                        FITRANNO)
                VALUES (PACABECERO.FIPAISID,
                        PACABECERO.FICANALID,
                        PACABECERO.FISUCURSALID,
                        SELF.fcfolioparam,
                        SELF.fingcioid,
                        SELF.finotienda,
                        SELF.ficteid,
                        SELF.fidigitover,
                        SELF.fitipoventa,
                        TRIM (SELF.fcempno),
                        SELF.fiplazo,
                        SELF.fiperiodo,
                        SELF.fnpabo,
                        SELF.fnuabo,
                        SELF.fdfecprep,
                        SELF.fiautoriza,
                        PACABECERO.FITRANNO);
      EXCEPTION
         WHEN OTHERS
         THEN
            ROLLBACK;
            VL_ORACOD := SQLCODE;
            VL_ORADESC := SUBSTR (SQLERRM, CSL_0, CSL_200);
            --LLAMAR AL SP PARA GUARDAR EL ERROR
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
               || '-> TYHIJOREG_50',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_50" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_50" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_50" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_50" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_50" TO "USRVENTAST";
