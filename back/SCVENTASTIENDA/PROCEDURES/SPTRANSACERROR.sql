--------------------------------------------------------
--  DDL for Procedure SPTRANSACERROR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCVENTASTIENDA"."SPTRANSACERROR" (pa_pais number,
                                           pa_canal number,
                                           pa_sucursal number,
                                           pa_tranno number,
                                           pa_trantipo number,
                                           pa_constipo number,
                                           pa_transfecha date,
                                           pa_transws varchar2,
                                           pa_tranusr varchar2,
                                           pa_consdeta number,
                                           pa_tiporeg number,
                                           pa_datodeta varchar2,
                                           pa_descerror varchar2,
                                           pa_status number,
                                           pa_codigoError out number,
                                           pa_mensajeError out varchar2
                                           ) IS
                                             
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripcion: PROCEDURE PARA GUARDAR LAS TRANSACCIONES EN ERROR DEL SENDER
Creador: Cesar David Campos Garcia
Fecha de creacion: 22/04/2019
**************************************************************************************************/                                             

PRAGMA AUTONOMOUS_TRANSACTION;
vl_user VARCHAR2(10):='USRVENTAST';

BEGIN

   EXECUTE IMMEDIATE('alter session set nls_date_format = ''YYYY-MM-DD HH24:MI:SS'''); 

   --INSERTA EN LA TABLA DE TXN EN ERROR
   INSERT INTO SCVENTASTIENDA.TATRANSAC_ERROR(fipaisid,
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
                                              FCDESCERROR,
                                              fistatus,
                                              fdcreacion,
                                              fdmodifico,
                                              fcusrmodifico)
                                     VALUES ( pa_pais,
                                              pa_canal,
                                              pa_sucursal,
                                              pa_tranno,
                                              pa_trantipo,
                                              pa_constipo,
                                              pa_transfecha,
                                              pa_transws,
                                              pa_tranusr,
                                              pa_consdeta,
                                              pa_tiporeg,
                                              pa_datodeta,
                                              pa_descerror,
                                              pa_status,
                                              SYSDATE,
                                              SYSDATE,
                                              vl_user);

    COMMIT;                         
EXCEPTION
   WHEN OTHERS THEN
   ROLLBACK;
   pa_codigoError := SQLCODE; 
   pa_mensajeError := SQLERRM;
end SPTRANSACERROR;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."SPTRANSACERROR" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPTRANSACERROR" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPTRANSACERROR" TO "USRACTVT";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPTRANSACERROR" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."SPTRANSACERROR" TO "USRINFSISGES";
