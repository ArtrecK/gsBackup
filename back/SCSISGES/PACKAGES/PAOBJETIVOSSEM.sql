--------------------------------------------------------
--  DDL for Package PAOBJETIVOSSEM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAOBJETIVOSSEM" 
AS
   /*PROCEDURE SPOBJETIVOSEMEMP
     Descripci�n: Obtiene la consulta de los objetivos y ventas de la semana que se desea consultar por empleado
     Fecha de creaci�n: 13/05/2019
     Par�metros de entrada:
         PA_FNEMPLEADO.- N�mero de empleado que se desea consultar.
         PA_FDFECHA.- Fecha de la cual se obtiene la semana y a�o.
     Par�etros de salida:
         CUR_OBJETIVOSEMEMP.- Cursor con la lista de objetivos y ventas de la semana por empleado agrupado por l�nea de producto y descripci�n.
         PA_CODIGO.- C�digo de error en caso de que ocurra
         PA_MENSAJE.- Descripci�n del error en caso de que ocurra    */
   PROCEDURE SPOBJETIVOSEMEMP (
      PA_FNEMPLEADO        IN     SCSISGES.TAOBJETIVOEMP.FNEMPLEADO%TYPE,
      PA_FDFECHA           IN     SCSISGES.TAOBJETIVOEMP.FDFECHA%TYPE,
      CUR_OBJETIVOSEMEMP      OUT SYS_REFCURSOR,
      PA_CODIGO               OUT INTEGER,
      PA_MENSAJE              OUT VARCHAR2);

   /*PROCEDURE SPOBJETIVOSEMSUC
     Descripci�n: Obtiene la consulta de los objetivos y ventas de la semana que se desea consultar por sucursal
     Fecha de creaci�n: 13/05/2019
     Par�metros de entrada:
         PA_FIIDSUCURSAL.- N�mero de sucursal que se desea consultar.
         PA_FDFECHA.- Fecha de la cual se obtiene la semana y a�o.
     Par�etros de salida:
         CUR_OBJETIVOSEMSUC.- Cursor con la lista de objetivos y ventas de la semana por sucursal agrupado por l�nea de producto y descripci�n.
         PA_CODIGO.- C�digo de error en caso de que ocurra
         PA_MENSAJE.- Descripci�n del error en caso de que ocurra    */
   PROCEDURE SPOBJETIVOSEMSUC (
      PA_FIIDSUCURSAL      IN     SCSISGES.TAOBJETIVOSUC.FIIDSUCURSAL%TYPE,
      PA_FDFECHA           IN     SCSISGES.TAOBJETIVOSUC.FDFECHA%TYPE,
      CUR_OBJETIVOSEMSUC      OUT SYS_REFCURSOR,
      PA_CODIGO               OUT INTEGER,
      PA_MENSAJE              OUT VARCHAR2);
END PAOBJETIVOSSEM;

/

  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "SCVENTASTIENDA";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRINFSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PAOBJETIVOSSEM" TO "USRVENTAST";
