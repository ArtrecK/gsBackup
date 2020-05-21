--------------------------------------------------------
--  DDL for Type TYOBEMPLEADOOBJ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCVENTASTIENDA"."TYOBEMPLEADOOBJ" AS OBJECT (
   FNEMPLEADO     NUMBER,
   FCEMPLEADO    VARCHAR2(10),
   FIIDSUCURSAL    NUMBER
);

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."TYOBEMPLEADOOBJ" TO "USRVENTAST";
