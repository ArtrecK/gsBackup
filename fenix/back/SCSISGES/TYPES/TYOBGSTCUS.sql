--------------------------------------------------------
--  DDL for Type TYOBGSTCUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "SCSISGES"."TYOBGSTCUS" IS OBJECT(
    ORDERID         NUMBER,
    FIPAIS            NUMBER,
    FICANAL         NUMBER,
    FISUCURSAL   NUMBER,
    FIFOLIO          NUMBER,
    FISTATGEST    NUMBER,
    FIIDRESGEST  NUMBER,
    FCDESCGEST  VARCHAR2(50 BYTE),
    FDFECGEST     DATE);

/

  GRANT EXECUTE ON "SCSISGES"."TYOBGSTCUS" TO "USRSISGES";
