--------------------------------------------------------
--  DDL for Procedure SPERRORES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "SCSISGES"."SPERRORES" (
    pa_fdfechaerror   IN DATE,
    pa_ficodigo       IN NUMBER,
    pa_fcmensaje      IN VARCHAR2,
    pa_fcspgenera     IN VARCHAR2
) IS
/*************************************************************************************************
Proyecto: Sistema de Gestion
Descripci�n: Procedimiento empleado para registrar las excepciones generadas por las funciones
    del Front End
Par�metros de entrada: pafdFechaError - Fecha del sistema; fecha en que se genera la excepci�n
             pafiCodigo - C�digo del error generado por Oracle
        pafcMensaje - Mensaje de error generado por Oracle
        pafcSpGenera - Nombre del SP o funci�n que dispar� la excepci�n
Par�metros de salida: N/A
Valor de retorno: N/A
Par�metros de entrada-salida: N/A
Precondiciones: N/A
Creador: Maria Canales
Fecha de creaci�n: 27 - 03 - 2018
**************************************************************************************************/ pragma autonomous_transaction;
    vl_codigoerror    NUMBER;
    vl_mensajeerror   VARCHAR2(200);
    vl_proc           VARCHAR2(60) := 'SCSISGES.SPERRORES';
BEGIN

   --Inserta en la tabla LOG_ERRORES
    INSERT INTO scsisges.talogerrores (
        fdfechaerror,
        ficodigo,
        fcmensaje,
        fcspgenera
    ) VALUES (
        pa_fdfechaerror,
        pa_ficodigo,
        pa_fcmensaje,
        pa_fcspgenera
    );

   --Guarda el registro

    COMMIT;
--    rollback;
EXCEPTION
   --Si se dispara alguna excepci�n
    WHEN OTHERS THEN
      --Deshace los cambios
        ROLLBACK;
        vl_codigoerror := sqlcode; --C�digo de error generado por Oracle
        vl_mensajeerror := sqlerrm
                           || '-'
                           || dbms_utility.format_error_backtrace (); --Mensaje de error generado por Oracle
   --Inserta en la tabla LOG_ERRORES
        INSERT INTO scsisges.talogerrores (
            fdfechaerror,
            ficodigo,
            fcmensaje,
            fcspgenera
        ) VALUES (
            SYSDATE,
            vl_codigoerror,
            vl_mensajeerror,
            vl_proc
        );
  --Guarda el registro
        COMMIT;
ROLLBACK;
END sperrores;

/

  GRANT EXECUTE ON "SCSISGES"."SPERRORES" TO "SCACTUALIZADORVT";
  GRANT EXECUTE ON "SCSISGES"."SPERRORES" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."SPERRORES" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."SPERRORES" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."SPERRORES" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."SPERRORES" TO "USRVENTAST";
