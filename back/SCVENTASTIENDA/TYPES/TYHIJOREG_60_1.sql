--------------------------------------------------------
--  DDL for Type TYHIJOREG_60
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYHIJOREG_60" 
                     UNDER TYTRANSACCION
                  (
                     fcfolioparam NUMBER (10),
                     fiprodid NUMBER (10),
                     fnprodpreciod NUMBER (9, 2),
                     ficant NUMBER (10),
                     fndescto NUMBER (7, 2),
                     fndesctoesp NUMBER (7, 2),
                     fnsobreprecio NUMBER (11, 4),
                     fiporciva NUMBER (6, 2),
                     fndesctomkt NUMBER (9, 2),
                     fncostopdcto NUMBER (9, 2),
                     fistatdp NUMBER (3),
                     fnintereses NUMBER (8, 2),
                     fnenganche NUMBER (8, 2),
                     ficveprom NUMBER (10),
                     fncomisionv NUMBER (9, 2),
                     fncomisiong NUMBER (9, 2),
                     fdcreacion DATE,
                     fdmodifico DATE,
                     fcusrmodifico VARCHAR2 (30),
                     CONSTRUCTOR FUNCTION TYHIJOREG_60 (
                        SELF              IN OUT NOCOPY TYHIJOREG_60,
                        pa_registerData                 XMLTYPE)
                        RETURN SELF AS RESULT,
                     OVERRIDING MEMBER FUNCTION FNPROCESAREGISTRO (
                        PACABECERO IN scventastienda.TYCABECEROTXN)
                        RETURN INTEGER)
                     NOT FINAL
                     INSTANTIABLE;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "SCVENTASTIENDA"."TYHIJOREG_60" 
AS
   CONSTRUCTOR FUNCTION TYHIJOREG_60 (
      SELF              IN OUT NOCOPY TYHIJOREG_60,
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
      VL_ERROR            VARCHAR2 (100);
      CSL_0      CONSTANT PLS_INTEGER := 0;
      CSL_1      CONSTANT PLS_INTEGER := 1;
      CSL_200    CONSTANT PLS_INTEGER := 200;
      CSL_2012   CONSTANT PLS_INTEGER := 2012;
      CSL_2010   CONSTANT PLS_INTEGER := 2010;
      CSL_2100   CONSTANT PLS_INTEGER := 2100;
      vlUpdate            NUMBER (1) := 1;
      VL_ORACOD           NUMBER;
      VL_ORADESC          VARCHAR2 (2000);
   --INICIO DE LA FUNCION
   BEGIN
      BEGIN
         VL_ERROR := 'ERROR AL INSERTAR EN TADETPREPARAM';

         MERGE INTO SCVENTASTIENDA.TADETPREPARAM DATOS
              USING (SELECT PACABECERO.FIPAISID AS PAIS,
                            PACABECERO.FICANALID AS CANAL,
                            PACABECERO.FISUCURSALID AS SUCURSAL,
                            SELF.FCFOLIOPARAM AS FOLIOPARAM,
                            SELF.FIPRODID AS PRODID
                       FROM DUAL) VALORES
                 ON (    DATOS.FIPAIS = VALORES.PAIS
                     AND DATOS.FICANAL = VALORES.CANAL
                     AND DATOS.FISUCURSAL = VALORES.SUCURSAL
                     AND DATOS.FIFOLIOPARAM = VALORES.FOLIOPARAM
                     AND DATOS.FIPRODID = VALORES.PRODID)
         WHEN NOT MATCHED
         THEN
            INSERT     (FIPAIS,
                        FICANAL,
                        FISUCURSAL,
                        FIFOLIOPARAM,
                        FIPRODID,
                        FNPRODPRECIOD,
                        FICANT,
                        FNDESCTO,
                        FNDESCTOESP,
                        FNSOBREPRECIO,
                        FNPORCIVA,
                        FNDESCTOMKT,
                        FNCOSTOPDCTO,
                        FISTATDP,
                        FNINTERESES,
                        FNENGANCHE,
                        FICVEPROM,
                        FNCOMISIONV,
                        FNCOMISIONG)
                VALUES (PACABECERO.FIPAISID,
                        PACABECERO.FICANALID,
                        PACABECERO.FISUCURSALID,
                        SELF.FCFOLIOPARAM,
                        SELF.FIPRODID,
                        SELF.FNPRODPRECIOD,
                        SELF.FICANT,
                        SELF.FNDESCTO,
                        SELF.FNDESCTOESP,
                        SELF.FNSOBREPRECIO,
                        SELF.FIPORCIVA,
                        SELF.FNDESCTOMKT,
                        SELF.FNCOSTOPDCTO,
                        SELF.FISTATDP,
                        SELF.FNINTERESES,
                        SELF.FNENGANCHE,
                        SELF.FICVEPROM,
                        SELF.FNCOMISIONV,
                        SELF.FNCOMISIONG);

         vlUpdate := CSL_0;

         IF (vlUpdate = CSL_1)
         THEN
            VL_ERROR := 'ERROR AL ACTUALIZAR EN TADETPREPARAM';

            IF (PACABECERO.FITRANTIPO = CSL_2012
                OR PACABECERO.FITRANTIPO = CSL_2010)
            THEN
               UPDATE SCVENTASTIENDA.TADETPREPARAM
                  SET FNPRODPRECIOD = SELF.FNPRODPRECIOD,
                      FNDESCTO = SELF.FNDESCTO,
                      FNDESCTOESP = SELF.FNDESCTOESP,
                      FNSOBREPRECIO = SELF.FNSOBREPRECIO,
                      FNDESCTOMKT = SELF.FNDESCTOMKT
                WHERE     FIPAIS = PACABECERO.FIPAISID
                      AND FICANAL = PACABECERO.FICANALID
                      AND FISUCURSAL = PACABECERO.FISUCURSALID
                      AND FIFOLIOPARAM = SELF.FCFOLIOPARAM
                      AND FIPRODID = SELF.FIPRODID;
            ELSIF (PACABECERO.FITRANTIPO = CSL_2100)
            THEN
               UPDATE SCVENTASTIENDA.TADETPREPARAM
                  SET FNPRODPRECIOD = SELF.FNPRODPRECIOD,
                      FICANT = SELF.FICANT,
                      FNDESCTO = SELF.FNDESCTO,
                      FNDESCTOESP = SELF.FNDESCTOESP,
                      FNSOBREPRECIO = SELF.FNSOBREPRECIO,
                      FNPORCIVA = SELF.FIPORCIVA,
                      FNDESCTOMKT = SELF.FNDESCTOMKT,
                      FNCOSTOPDCTO = SELF.FNCOSTOPDCTO,
                      FISTATDP = SELF.FISTATDP,
                      FNINTERESES = SELF.FNINTERESES,
                      FNENGANCHE = SELF.FNENGANCHE,
                      FICVEPROM = SELF.FICVEPROM,
                      FNCOMISIONV = SELF.FNCOMISIONV,
                      FNCOMISIONG = SELF.FNCOMISIONG
                WHERE     FIPAIS = PACABECERO.FIPAISID
                      AND FICANAL = PACABECERO.FICANALID
                      AND FISUCURSAL = PACABECERO.FISUCURSALID
                      AND FIFOLIOPARAM = SELF.FCFOLIOPARAM
                      AND FIPRODID = SELF.FIPRODID;
            END IF;
         END IF;
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
               || '-> TYHIJOREG_60',
               CSL_1,
               VL_ORACOD,
               VL_ORADESC);
      END;

      RETURN 0;
   END;
END;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_60" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_60" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_60" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_60" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."TYHIJOREG_60" TO "USRVENTAST";
