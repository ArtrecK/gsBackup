--------------------------------------------------------
--  DDL for Package PQFXVERIFICACIONTEL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQFXVERIFICACIONTEL" 
IS

   PROCEDURE sputelmail (pa_pais                IN     NUMBER,
                         pa_canal               IN     NUMBER,
                         pa_sucursal            IN     NUMBER,
                         pa_folio               IN     NUMBER,
                         pa_telefono            IN     NUMBER,
                         pa_tipo_telefono       IN     NUMBER,
                         pa_email               IN     VARCHAR2,
                         pa_codigo_validacion      OUT NUMBER,
                         pa_codigo                 OUT NUMBER,
                         pa_mensaje                OUT VARCHAR2);

   PROCEDURE spagregatelefono (pa_pais            IN     NUMBER,
                               pa_canal           IN     NUMBER,
                               pa_sucursal        IN     NUMBER,
                               pa_folio           IN     NUMBER,
                               pa_tipotelefono    IN     NUMBER,
                               pa_telefono        IN     NUMBER,
                               pa_foliogenerado      OUT NUMBER,
                               pa_status             OUT NUMBER,
                               pa_codigo             OUT INTEGER,
                               pa_mensaje            OUT VARCHAR2);

   FUNCTION fngenerafolio (pa_telefono IN NUMBER)
      RETURN NUMBER;

   PROCEDURE spverificatel (pa_pais            IN     NUMBER,
                            pa_canal           IN     NUMBER,
                            pa_sucursal        IN     NUMBER,
                            pa_folio           IN     NUMBER,
                            pa_telefono        IN     NUMBER,
                            pa_foliogenerado   IN     NUMBER,
                            pa_status             OUT NUMBER,
                            pa_codigo             OUT INTEGER,
                            pa_mensaje            OUT VARCHAR2);

   PROCEDURE spconsultatel (pa_pais          IN     NUMBER,
                            pa_canal         IN     NUMBER,
                            pa_sucursal      IN     NUMBER,
                            pa_folio         IN     NUMBER,
                            pa_curtelefono      OUT SYS_REFCURSOR,
                            pa_codigo           OUT INTEGER,
                            pa_mensaje          OUT VARCHAR2);
END pqfxverificaciontel;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXVERIFICACIONTEL" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXVERIFICACIONTEL" TO "USRSISGES";
