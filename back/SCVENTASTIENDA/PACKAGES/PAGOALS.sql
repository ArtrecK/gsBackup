--------------------------------------------------------
--  DDL for Package PAGOALS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCVENTASTIENDA"."PAGOALS" 
AS
    /*******************************************************************************
      Proyecto:     GESTION CLIENTES
      Descripcion:  Paquete de utilerias para los objetivos acumulados diarios y semanales
      Parametros de Entrada: paFecha      fecha
      Parametros de Salida:
      Valor de Retorno: Regresa un cursor con los objetivos acumulados por vendedor
      Parametros de Entrada-Salida:
      PreCondiciones:
      Creador:           Cesar Ramirez Celaya
      Fecha de Creacion:  16 de Mayo del 2018
    *******************************************************************************/
    PROCEDURE spgoalsdaily (pa_idsucursal   IN     INTEGER,
                            pa_empnosurte   IN     INTEGER,
                            pa_fecha        IN     INTEGER,
                            pa_curgoals        OUT SYS_REFCURSOR,
                            pa_coderror        OUT INTEGER,
                            pa_msgerror        OUT VARCHAR2);

    PROCEDURE spgoalsweekly (pa_idsucursal   IN     INTEGER,
                             pa_empnosurte   IN     INTEGER,
                             pa_fecha        IN     INTEGER,
                             pa_curgoals        OUT SYS_REFCURSOR,
                             pa_coderror        OUT INTEGER,
                             pa_msgerror        OUT VARCHAR2);

    PROCEDURE splineas (cur_lineas    OUT SYS_REFCURSOR,
                        pa_mensaje    OUT VARCHAR2,
                        pa_coderror   OUT INTEGER,
                        pa_deserror   OUT VARCHAR2);
END pagoals;

/

  GRANT EXECUTE ON "SCVENTASTIENDA"."PAGOALS" TO "USRSISGES";
  GRANT EXECUTE ON "SCVENTASTIENDA"."PAGOALS" TO "USRVENTAST";
