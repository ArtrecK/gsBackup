--------------------------------------------------------
--  DDL for Package Body PAMOMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PAMOMENTS" AS

 PROCEDURE SPMOMENTSVW (pa_FIPADRE IN INTEGER
                                          , cur_MOMENTS OUT SYS_REFCURSOR
                                          , pa_CODIGO OUT INTEGER
                                          , pa_MENSAJE OUT VARCHAR2)

 AS
 
    PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN
    OPEN cur_MOMENTS FOR
    SELECT fcdesc1
              , fccolor1
              , fcdesc2
              , fccolor2
              , fcdesc3
              , fccolor3
FROM (SELECT fcdesc1
                     , fccolor1
                     , fcdesc2
                     , fccolor2
                     , fcdesc3
                     , fccolor3 
              from SCSISGES.TCMOMFELICES 
          WHERE FIPADRE = pa_FIPADRE
  order by dbms_random.value)
where rownum = csl_1;



      pa_CODIGO:= 200;
      pa_MENSAJE:= 'OK';
      --Guarda el registro
    COMMIT;
    --    rollback;

    EXCEPTION
    --Si se dispara alguna excepci�n
    WHEN OTHERS THEN
        --Deshace los cambios
        ROLLBACK;
        pa_CODIGO := SQLCODE; --C�digo de error generado por Oracle
        pa_MENSAJE := SQLERRM; --Mensaje de error generado por Oracle
        --Inserta en la tabla LOG_ERRORES 
  COMMIT;
END;
END;

/

  GRANT EXECUTE ON "SCSISGES"."PAMOMENTS" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAMOMENTS" TO "USRVENTAST";
