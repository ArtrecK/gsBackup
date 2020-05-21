--------------------------------------------------------
--  DDL for Package PAREPORTES0002
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PAREPORTES0002" 
AS
    PROCEDURE SPGESTIONES (PA_DATA      OUT SYS_REFCURSOR,
                           PA_CODE      OUT INTEGER,
                           PA_MESSAGE   OUT VARCHAR2,
                           PA_DETAIL    OUT VARCHAR2);

    /*
    * Consulta para reporte de gestiones V2
    * param   N/A.
    * return  Gestiones con Zona y Region.
    * author  Marcos Glez
    */
    PROCEDURE SPGESTIONESV2 (PA_DATA      OUT SYS_REFCURSOR,
                             PA_CODE      OUT INTEGER,
                             PA_MESSAGE   OUT VARCHAR2,
                             PA_DETAIL    OUT VARCHAR2);
END PAREPORTES0002;

/

  GRANT EXECUTE ON "SCSISGES"."PAREPORTES0002" TO "USRSISGES";
