--------------------------------------------------------
--  DDL for Package Body TEST_PAMOMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."TEST_PAMOMENTS" AS

    PROCEDURE inserta_momentos IS
    BEGIN
        DELETE FROM scsisges.TCMOMFELICES;

        INSERT ALL INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Tu no vendes productos',
            'FF0040',
            'vendes',
            '2E2E2E',
            'ilusiones',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Sonreir te ayuda,',
            'FF0040',
            'pero el hacer sonreír a una familia',
            '2E2E2E',
            'te hace mejor',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Si no vas',
            'FF0040',
            'por todo, ',
            '2E2E2E',
            'no vayas',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Para tus clientes,',
            'FF0040',
            'somos su mejor opción,',
            '2E2E2E',
            '¡DEMUÉSTRASELOS!',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Haz que más familias mexicanas,',
            'FF0040',
            'vivan el momento',
            '2E2E2E',
            'con ELEKTRA',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'El mejor momento,',
            'FF0040',
            'ver salir',
            '2E2E2E',
            'feliz a una familia',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Tu esfuerzo y sueño de crecer,',
            'FF0040',
            'se ve reflejado al realizar una venta,',
            '2E2E2E',
            '¡Vamos!',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Hoy,',
            'FF0040',
            'que tu plan sea',
            '2E2E2E',
            'el cumplir sueños',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'En ELEKTRA',
            'FF0040',
            'creamos TCMOMFELICES',
            '2E2E2E',
            'felices',
            '0'
        )INTO scsisges.TCMOMFELICES(
            fipadre,
            fcdesc1,
            fccolor1,
            fcdesc2,
            fccolor2,
            fcdesc3,
            fccolor3
        )VALUES(
            1,
            'Gestionar mis clientes',
            'FF0040',
            'crea TCMOMFELICES',
            '2E2E2E',
            'felices',
            '0'
        )SELECT
             1
         FROM
             dual;

    END;

    PROCEDURE consulta_momentos IS
        --TYPE ref_cursor IS REF CURSOR;
        pa_fipadre    NUMBER;
        cur_moments   SYS_REFCURSOR;
        cur_moments2   SYS_REFCURSOR;
        pa_codigo     NUMBER;
        pa_mensaje    VARCHAR2(200);
        pa_opened_cursor BOOLEAN;
        TYPE MOMENT_ROWS IS TABLE OF scsisges.TCMOMFELICES%ROWTYPE;
        MOMENTS MOMENT_ROWS;
        l_cursor sys_refcursor;
    BEGIN
        pa_fipadre := 1;
        scsisges.pamoments.spmomentsvw( pa_fipadre => pa_fipadre,cur_moments => cur_moments,pa_codigo => pa_codigo,pa_mensaje => pa_mensaje );
        ut.expect(cur_moments,'Se espera que el cursor devuelva solo una fila').to_have_count(1);
        --cur_moments2 := cur_moments;
        --pa_opened_cursor := cur_moments%isopen;
        --FETCH cur_moments BULK COLLECT INTO MOMENTS;
        --CLOSE cur_moments;
        ut.expect(pa_codigo,'Código de salida no es 200').to_(equal(200));
        ut.expect(pa_mensaje,'Mensaje de salida no es igual OK').to_(equal('OK'));
        --ut.expect(cur_moments2,'El cursor es nulo').to_be_not_null();
        --ut.expect(pa_opened_cursor,'El cursor esta cerrado').to_(equal(TRUE));

        --open l_cursor for select * from dual connect by level <=10;
        --ut.expect( l_cursor ).to_have_count(10);
        
        --close cur_moments;
    END;

    PROCEDURE consulta_no_existentes IS
        pa_fipadre    NUMBER;
        cur_moments   SYS_REFCURSOR;
        pa_codigo     NUMBER;
        pa_mensaje    VARCHAR2(200);
    BEGIN
        pa_fipadre := 2;
        scsisges.pamoments.spmomentsvw(pa_fipadre,cur_moments,pa_codigo,pa_mensaje);

        ut.expect(pa_codigo,'Código de salida es 200').not_to(equal(200));
        ut.expect(pa_mensaje,'Mensaje de salida no es igual OK').not_to(equal('OK'));
        ut.expect(cur_moments,'El cursor no es nulo').to_be_null();
    END;

    PROCEDURE consulta_con_null IS
        pa_fipadre    NUMBER;
        cur_moments   SYS_REFCURSOR;
        pa_codigo     NUMBER;
        pa_mensaje    VARCHAR2(200);
    BEGIN
        pa_fipadre := NULL;
        scsisges.pamoments.spmomentsvw(pa_fipadre,cur_moments,pa_codigo,pa_mensaje);
        ut.expect(pa_codigo,'Código de salida es 200').not_to(equal(200));
        ut.expect(pa_mensaje,'Mensaje de salida no es igual OK').not_to(equal('OK'));
        ut.expect(cur_moments,'El cursor es nulo').to_be_null();
    END;

END;

/
