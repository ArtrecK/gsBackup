--------------------------------------------------------
--  DDL for Package PACONTACT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PACONTACT" is

  -- Author  : B643963
  -- Created : 18/07/2018 10:40:13 a.m.
  -- Purpose : Datos de contacto personal con el cliente

   PROCEDURE spAddMail (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_mail      IN varchar2,
        pa_codigo    OUT INTEGER,
        pa_mensaje   OUT VARCHAR2
    );

      PROCEDURE spVwMail (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_curMail     OUT SYS_REFCURSOR,
        pa_codigo   OUT INTEGER,
        pa_mensaje  OUT VARCHAR2
    );

   PROCEDURE spAddTelefono (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_tipotelefono IN number,
        pa_telefono  IN number,
        pa_codigo    OUT integer,
        pa_mensaje   OUT varchar2
    );

     PROCEDURE spVwTelefono (
        pa_pais      IN number,
        pa_canal     IN number,
        pa_sucursal  IN number,
        pa_folio     IN number,
        pa_curTelefono OUT SYS_REFCURSOR,
        pa_codigo   OUT integer,
        pa_mensaje  OUT varchar2
    );

end PACONTACT;

/

  GRANT EXECUTE ON "SCSISGES"."PACONTACT" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PACONTACT" TO "USRVENTAST";
