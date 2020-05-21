--------------------------------------------------------
--  DDL for Package PQFXGEOGRAFIAMXEKT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQFXGEOGRAFIAMXEKT" 
IS
    -- Author  : 149766 - Arturo Lopez Patricio
    -- Created : 23/10/2018
    -- Purpose : proceso de geografias elektra para Mexico

    /*store para poblar catalogo de paises en caso de no existir se da de alta
    si el Id de Pais existe entonces se hace actualizacion de informacion*/
    PROCEDURE SPPROCESAPAIS (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT);

    /*store para alta y actuazliacion de  catalogo de territorios en caso de no existir se da de alta
    si el Id del territorio existe entonces se hace actualizacion de informacion*/
    PROCEDURE SPPROCTERRITORIO (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT);

    /*store para dar de alta y actualizar catalogo de zonas*/
    PROCEDURE SPPROCZONAS (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT);

    /*store para dar de alta y actualizar catalogo de regiones*/
    PROCEDURE SPPROCREGIONES (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT);

    PROCEDURE SPPROCSUCURSALEKT (PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAEKT);

    PROCEDURE SPPROCSUCCERRADA (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT);

    /*store para dar de baja territorios que ya no existan en la geografia*/
    PROCEDURE SPBAJATERRITORIO (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT);

    /*store para dar de baja zonas que ya no existan en la geografia*/
    PROCEDURE SPBAJAZONAS (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT);

    PROCEDURE SPBAJAREGIONES (PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAEKT);

    /*store que debe correr para hacerse el procesamiento de toda la geografia ekt mx*/
    PROCEDURE SPPROCESAEKT (PA_NOMBREPROC   IN     VARCHAR2,
                            PA_CODERROR        OUT INTEGER,
                            PA_DESERROR        OUT VARCHAR2);
END PQFXGEOGRAFIAMXEKT;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXGEOGRAFIAMXEKT" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXGEOGRAFIAMXEKT" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQFXGEOGRAFIAMXEKT" TO "USRSISGES";
