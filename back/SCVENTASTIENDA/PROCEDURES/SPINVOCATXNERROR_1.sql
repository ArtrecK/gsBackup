--------------------------------------------------------
--  DDL for Procedure SPINVOCATXNERROR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SPINVOCATXNERROR" (PA_TRANSAC IN SCVENTASTIENDA.TYTABCABTXNGEN,
                                                            pa_CODIGOERR out number,
                                                            pa_DESCERROR out varchar2
                                                            ) is
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: PROCEDURE PARA GUARDAR LAS TRANSACCIONES EN ERROR DESDE EL MIDDLEWARE
Creador: Cesar David Campos Garcia
Fecha de creacion: 30/04/2019
**************************************************************************************************/
CSL_0 CONSTANT PLS_INTEGER :=0;
CSL_2 CONSTANT PLS_INTEGER :=2;
CSL_200 CONSTANT PLS_INTEGER :=200;
VL_USER VARCHAR2(15):= 'SCACTUALIZADOR';
VL_ERROR VARCHAR2(100):= 'ERROR:TIME OUT --> FALLO SPPROCESAREGISTROS';

PRAGMA AUTONOMOUS_TRANSACTION;

--inicio
  BEGIN
 FOR i IN PA_TRANSAC.FIRST..PA_TRANSAC.LAST LOOP
  INSERT INTO SCVENTASTIENDA.TATRANSAC_ERROR(
                                            fipaisid,
                                            ficanal,
                                            fisucursal,
                                            fitranno,
                                            fitrantipo,
                                            ficonsectipo,
                                            fdtransfechr,
                                            fctranws,
                                            fctranusr,
                                            ficonsdeta,
                                            fitiporeg,
                                            fcdatodeta,
                                            fcdescerror,
                                            fistatus,
                                            fdcreacion,
                                            fdmodifico,
                                            fcusrmodifico
                                            )
                                   VALUES
                                         (PA_TRANSAC(i).fipaisid,
                                          PA_TRANSAC(i).ficanalid,
                                          PA_TRANSAC(i).fisucursalid,
                                          PA_TRANSAC(i).fitranno,
                                          PA_TRANSAC(i).fitrantipo,
                                          PA_TRANSAC(i).ficonsectipo,
                                          PA_TRANSAC(i).fdtransfechr,
                                          PA_TRANSAC(i).fctranws,
                                          PA_TRANSAC(i).fctranusr,
                                          PA_TRANSAC(i).ficonsdeta,
                                          PA_TRANSAC(i).fitiporeg,
                                          PA_TRANSAC(i).fcdatodeta,
                                          VL_ERROR,
                                          CSL_2,
                                          SYSDATE,
                                          SYSDATE,
                                          VL_USER
                                          );

  END LOOP;
 COMMIT;

EXCEPTION
         WHEN OTHERS THEN
   pa_CODIGOERR := SQLCODE;
   pa_DESCERROR := SUBSTR(SQLERRM,CSL_0,CSL_200);
end SPINVOCATXNERROR;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SPINVOCATXNERROR" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPINVOCATXNERROR" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPINVOCATXNERROR" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPINVOCATXNERROR" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPINVOCATXNERROR" TO "USRINFSISGES";
