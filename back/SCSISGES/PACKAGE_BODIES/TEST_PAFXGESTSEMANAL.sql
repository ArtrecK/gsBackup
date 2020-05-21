--------------------------------------------------------
--  DDL for Package Body TEST_PAFXGESTSEMANAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."TEST_PAFXGESTSEMANAL" IS

   /* generated by utPLSQL for SQL Developer on 2019-04-29 13:33:33 */

    PROCEDURE consulta_gestiones_empleado is
        pa_ceco         NUMBER;
        pa_nivel        NUMBER;
        pa_gestiones    SYS_REFCURSOR;
        pa_codigo     NUMBER;
        pa_mensaje    VARCHAR2(200);
        pa_detalle    VARCHAR2(200);
        pa_opened_cursor BOOLEAN;
        TYPE MOMENT_ROWS IS TABLE OF scsisges.TCMOMFELICES%ROWTYPE;
        MOMENTS MOMENT_ROWS;
        l_cursor sys_refcursor;
    BEGIN
        pa_ceco := 1;
        pa_nivel := 255472;
        scsisges.pafxgestsemanal.spconteosemanal(pa_ceco => pa_ceco, pa_nivel => pa_nivel, pa_gestiones => pa_gestiones, pa_codigo => pa_codigo,pa_mensaje => pa_mensaje, pa_detalle => pa_detalle);
        ut.expect(pa_gestiones,'Se espera que el cursor devuelva solo una fila').to_have_count(11);
        --cur_moments2 := cur_moments;
        --pa_opened_cursor := cur_moments%isopen;
        --FETCH cur_moments BULK COLLECT INTO MOMENTS;
        --CLOSE cur_moments;
        ut.expect(pa_codigo,'Código de salida no es 200').to_(equal(0));
        ut.expect(pa_mensaje,'Mensaje de salida no es igual OK').to_(equal('OK'));
        --ut.expect(cur_moments2,'El cursor es nulo').to_be_not_null();
        --ut.expect(pa_opened_cursor,'El cursor esta cerrado').to_(equal(TRUE));

        --open l_cursor for select * from dual connect by level <=10;
        --ut.expect( l_cursor ).to_have_count(10);
        
        --close cur_moments;
    END;
    
   
END;

/
