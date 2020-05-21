--------------------------------------------------------
--  DDL for Package PALOGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PALOGIN" IS
/*************************************************************
Proyecto: Sistema de Gestion
Descripci�n: Paquete de lOGIN de usuarios
Par�metros de entrada: N/A
Par�metros de salida: N/A
Valor de retorno: Tipo de datos de usuario
Par�metros de entrada-salida: N/A
Precondiciones: N/A
Creador: Yessica Thalia Apale Lara
Fecha de creaci�n: 10-12-2018
*************************************************************/

   PROCEDURE spvalidausuario (
       pa_fiempleado   IN SCSISGES.TCUSUARIOADMIN.FIUSRID%TYPE,
        pa_fccontrasenia         IN SCSISGES.TCUSUARIOADMIN.FCPWDUSR%TYPE,
        pa_bandera       OUT INTEGER,
        pa_tipousr       OUT INTEGER,
        cur_accesos OUT SYS_REFCURSOR,
        pa_code          OUT INTEGER,
        pa_message       OUT VARCHAR2
    );


END PALOGIN;

/

  GRANT EXECUTE ON "SCSISGES"."PALOGIN" TO "USRSISGES";
