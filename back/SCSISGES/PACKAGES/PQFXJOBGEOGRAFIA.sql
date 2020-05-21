--------------------------------------------------------
--  DDL for Package PQFXJOBGEOGRAFIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQFXJOBGEOGRAFIA" IS
  -- Author  : 149766 - Arturo Lopez Patricio
  -- Created : 10/09/2018
  -- Purpose : proceso de geografias Mexico y Lam

/*store para poblar catalogo de paises en caso de no existir se da de alta
si el Id de Pais existe entonces se hace actualizacion de informacion*/
PROCEDURE SPPROCESAPAIS;
/*store para alta y actualizacion de  catalogo de territorios en caso de no existir se da de alta
si el Id del territorio existe entonces se hace actualizacion de informacion*/
PROCEDURE SPPROCTERRITORIO
  (
     PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAS
  );
/*store para alta y actualizacion de  catalogo de zonas en caso de no existir se da de alta
si el Id de la zona existe entonces se hace actualizacion de informacion*/
PROCEDURE SPPROCZONAS
 (
    PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAS
  );
/*store para dar de alta y actualizar catalogo de regiones*/
PROCEDURE SPPROCREGIONES
  (
      PA_TBSUCURSALES SCSISGES.TYTBGEOGRAFIAS
  );
PROCEDURE SPBAJATERRITORIO
  (
   PA_TBSUCURBAZ SCSISGES.TYTBGEOGRAFIAS
  ,PA_TBSUCUREKT SCSISGES.TYTBGEOGRAFIAS
  );
END PQFXJOBGEOGRAFIA;

/

  GRANT EXECUTE ON "SCSISGES"."PQFXJOBGEOGRAFIA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQFXJOBGEOGRAFIA" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQFXJOBGEOGRAFIA" TO "USRSISGES";
