--------------------------------------------------------
--  DDL for Package PAAPPLICATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PAAPPLICATION" 
AS
    PROCEDURE spqaplication (
        pa_sucursal         IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado         IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_curapplication      OUT SYS_REFCURSOR,
        pa_code                OUT INTEGER,
        pa_message             OUT VARCHAR2);

    PROCEDURE spdetsols (
        pa_sucursal      IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado      IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_currequests      OUT SYS_REFCURSOR,
        pa_conteo           OUT NUMBER,
        pa_mensaje          OUT VARCHAR2,
        pa_coderror         OUT INTEGER,
        pa_deserror         OUT VARCHAR2);

    PROCEDURE spcountsolssuperv (
        pa_sucursal   IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado   IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_conteo        OUT NUMBER,
        pa_mensaje       OUT VARCHAR2,
        pa_coderror      OUT INTEGER,
        pa_deserror      OUT VARCHAR2);

    PROCEDURE spqaplicationv2 (
        pa_sucursal         IN     scventastienda.tasolicitudes.fisucursal%TYPE,
        pa_empleado         IN     scventastienda.tasolicitudes.fcempno%TYPE,
        pa_curapplication      OUT SYS_REFCURSOR,
        pa_code                OUT INTEGER,
        pa_message             OUT VARCHAR2);
END paapplication;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRVENTAST";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "SCSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAAPPLICATION" TO "USRINFSISGES";
