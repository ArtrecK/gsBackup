--------------------------------------------------------
--  DDL for Package TEST_PAAPPLICATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."TEST_PAAPPLICATION" AS 

  PROCEDURE SPPRUEBACONSULTASOL AS

        pa_sucursal        INTEGER;
        pa_empleado        INTEGER;
        pa_curapplication  SYS_REFCURSOR;
        pa_code            INTEGER;
        pa_message         VARCHAR2;

  BEGIN
  
      SCVENTASTIENDA.PAAPPLICATION.spqaplication (pa_sucursal,pa_empleado,pa_curapplication,pa_code,pa_message);

      ut.expect(PA_CODE,'Código de salida no es 0').to_(equal(0));
      ut.expect(PA_MESSAGE,'Mensaje de salida no es igual OK').to_(equal('OK'));
    
      
  END SPPRUEBACONSULTASOL;

END TEST_PAAPPLICATION;

/
