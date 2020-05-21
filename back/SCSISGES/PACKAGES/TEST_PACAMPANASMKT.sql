--------------------------------------------------------
--  DDL for Package TEST_PACAMPANASMKT
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."TEST_PACAMPANASMKT" is
   --%suite(TEST_PACAMPANASMKT)
   --%suitepath(TEST_PACAMPANASMKT)
   --%displayname(PRUEBAS DE PAQUETE PARA CARGA DE CAMPAÑAS.)

    --%beforeall
    PROCEDURE SPINSERTADATOS;

    --%test
    PROCEDURE SPEXECUTEMKT ;

END TEST_PACAMPANASMKT;
/
