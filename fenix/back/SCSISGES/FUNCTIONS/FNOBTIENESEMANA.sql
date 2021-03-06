--------------------------------------------------------
--  DDL for Function FNOBTIENESEMANA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "SCSISGES"."FNOBTIENESEMANA" (
   pa_fecha IN SCSISGES.TAOBJETIVOEMP.FDFECHA%TYPE)
   RETURN NUMBER
AS
   vl_semana   NUMBER;
BEGIN
   /*FUNCION QUE OBTIENE EL NUMERO DE SEMANA A PARTIR DE UNA FECHA
     Fecha creacion: 28/05/19*/

   SELECT NVL (FISEMANA, 0)
     INTO vl_semana
     FROM SCSISGES.TCCALENDARIOEKT TCC
    WHERE TRUNC (TCC.FDFECHA) = TO_DATE (pa_fecha, 'yyyyMMdd');

   RETURN vl_semana;
EXCEPTION
   WHEN OTHERS
   THEN
      vl_semana := 0;
      RETURN vl_semana;
END FNOBTIENESEMANA;

/

  GRANT EXECUTE ON "SCSISGES"."FNOBTIENESEMANA" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."FNOBTIENESEMANA" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."FNOBTIENESEMANA" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."FNOBTIENESEMANA" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."FNOBTIENESEMANA" TO "USRVENTAST";
