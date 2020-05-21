--------------------------------------------------------
--  DDL for Package Body PACONTACT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PACONTACT" is

   PROCEDURE spAddMail (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_mail      IN varchar2,
        pa_codigo    OUT integer,
        pa_mensaje   OUT varchar2
    )AS
    BEGIN
        INSERT INTO scsisges.TADATOSMAIL (
            fipais,
            ficanal,
            fisucursal,
            fifolio,
            fcmail
        ) VALUES (
            pa_pais,
            pa_canal,
            pa_sucursal,
            pa_folio,
            pa_mail
        );
        pa_codigo := 200;
        pa_mensaje := 'OK';
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := sqlcode; 
            pa_mensaje := sqlerrm; 
            scsisges.sperrores(SYSDATE,sqlcode,sqlerrm
                                                 || '-'
                                                 || dbms_utility.format_error_backtrace(),'SCSISGES.PACONTACT.SPADDMAIL');

    END;

    PROCEDURE spVwMail (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_curMail     OUT SYS_REFCURSOR,
        pa_codigo   OUT integer,
        pa_mensaje  OUT varchar2
    ) AS
    BEGIN
        OPEN pa_curMail FOR SELECT
            fcMail
            FROM
            scsisges.TADATOSMAIL
            WHERE
            fipais = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fifolio = pa_folio
            order by fdultmodifica desc fetch first 1 row only;

        pa_codigo := 200;
        pa_mensaje := 'OK';
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            pa_codigo := sqlcode; 
            pa_mensaje := sqlerrm;
            COMMIT;
    END;

       PROCEDURE spAddTelefono (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_tipotelefono IN number,
        pa_telefono  IN number,
        pa_codigo    OUT integer,
        pa_mensaje   OUT varchar2
    )AS
    BEGIN
        INSERT INTO scsisges.TADATOSTELEFONO(
            fipais,
            ficanal,
            fisucursal,
            fifolio,
            fntelefono,
            fntipotelefono
        ) VALUES (
            pa_pais,
            pa_canal,
            pa_sucursal,
            pa_folio,
            pa_telefono,
            pa_tipotelefono
        );
        pa_codigo := 200;
        pa_mensaje := 'OK';
        --Guarda el registro
        COMMIT;
      EXCEPTION
        --Si se dispara alguna excepci�n
        WHEN OTHERS THEN
            --Deshace los cambios
            ROLLBACK;
            pa_codigo := sqlcode; --C�digo de error generado por Oracle
            pa_mensaje := sqlerrm; --Mensaje de error generado por Oracle
            --SP QUE INSERTA EN BITACORA DE ERRORES
            scsisges.sperrores(SYSDATE,sqlcode,sqlerrm
                                                 || '-'
                                                 || dbms_utility.format_error_backtrace(),'SCSISGES.PACONTACT.SPADDTELEFONO');

    END;

    PROCEDURE spVwTelefono (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_curTelefono OUT SYS_REFCURSOR,
        pa_codigo   OUT integer,
        pa_mensaje  OUT varchar2
    ) AS
    BEGIN

        OPEN pa_curTelefono FOR SELECT
            fntipotelefono, fntelefono
            FROM
            scsisges.TADATOSTELEFONO
            WHERE
            fipais = pa_pais
            AND ficanal = pa_canal
            AND fisucursal = pa_sucursal
            AND fifolio = pa_folio
            order by fdultmodifica desc fetch first 1 row only;

        pa_codigo := 200;
        pa_mensaje := 'OK';
    COMMIT;
    EXCEPTION
         WHEN OTHERS THEN
                ROLLBACK;
            pa_codigo := sqlcode; 
            pa_mensaje := sqlerrm; 
            COMMIT;
    END;


end PACONTACT;

/

  GRANT EXECUTE ON "SCSISGES"."PACONTACT" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PACONTACT" TO "USRVENTAST";
