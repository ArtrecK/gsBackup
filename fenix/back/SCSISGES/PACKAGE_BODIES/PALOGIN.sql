--------------------------------------------------------
--  DDL for Package Body PALOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PALOGIN" 
    
    IS

    csl_0      CONSTANT INTEGER := 0;
    csl_1      CONSTANT INTEGER := 1;    

 PROCEDURE spvalidausuario (
       pa_fiempleado   IN SCSISGES.TCUSUARIOADMIN.FIUSRID%TYPE,
        pa_fccontrasenia         IN SCSISGES.TCUSUARIOADMIN.FCPWDUSR%TYPE,
        pa_bandera       OUT INTEGER,
        pa_tipousr       OUT INTEGER,
        cur_accesos OUT SYS_REFCURSOR,
        pa_code          OUT INTEGER,
        pa_message       OUT VARCHAR2
    )

        AS
        CSL_COUNTUSER   NUMBER;
        BEGIN

       SELECT
        COUNT(fiusrid) 
            INTO CSL_COUNTUSER 
                FROM SCSISGES.TCUSUARIOADMIN TAU 
                     WHERE tau.fiusrid  = pa_fiempleado 
                     and tau.fcpwdusr = pa_fccontrasenia
                     and TAU.FNINACTIVO = csl_0;


        IF CSL_COUNTUSER > csl_0 THEN

        SELECT
        TCTUSR.fitipousrid
            INTO pa_tipousr
            FROM SCSISGES.tctipousuario TCTUSR 
            JOIN SCSISGES.TCUSUARIOADMIN TCADM
            ON TCADM.FIUSRID = pa_fiempleado
            AND tctusr.fitipousrid = tcadm.fitipousrid
            AND TCTUSR.FNINACTIVO = csl_0
            AND TCADM.FNINACTIVO = csl_0
            AND TCTUSR.fitipousrid > csl_0;

        OPEN cur_accesos FOR
             SELECT TAUSRMOD.fimoduloid
             FROM  SCSISGES.tcusuarioadmin TCUSRADMIN 
                JOIN SCSISGES.TAUSUARIOMODULO TAUSRMOD
                 ON TCUSRADMIN.FIUSRID = pa_fiempleado 
                 AND TCUSRADMIN.FCPWDUSR = pa_fccontrasenia
                 AND TCUSRADMIN.FIUSRID = TAUSRMOD.FIUSRID
                 AND TCUSRADMIN.FITIPOUSRID = TAUSRMOD.FITIPOUSRID
                 AND TCUSRADMIN .FNINACTIVO = csl_0
                 AND TAUSRMOD.FNINACTIVO = csl_0
                ORDER BY TAUSRMOD.fimoduloid;
       pa_bandera:=csl_0;

       ELSE

       pa_tipousr:=csl_0;
       pa_bandera:=csl_1;
       pa_code := csl_0;
       pa_message := 'OK';

       END IF;


       pa_code := csl_0;
       pa_message := 'OK';
                EXCEPTION
                WHEN OTHERS THEN
                    pa_code := sqlcode;
                    pa_message := sqlerrm; 
                    pa_bandera := csl_1;
        END spvalidausuario;

 END PALOGIN;

/

  GRANT EXECUTE ON "SCSISGES"."PALOGIN" TO "USRSISGES";
