--------------------------------------------------------
--  DDL for Package Body PAEVENTS
--------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY SCSISGES.PAEVENTS AS

    CSL_0       CONSTANT INTEGER := 0;
    CSL_200     CONSTANT INTEGER := 200;
    CSL_OK      CONSTANT VARCHAR2 (2) := 'OK';

    PROCEDURE spevents (
        pa_status           IN VARCHAR2,
        pa_evncursor        OUT SYS_REFCURSOR)

	AS
        PRAGMA              AUTONOMOUS_TRANSACTION;
        vl_codigoerror      NUMBER;
        vl_mensajeerror     VARCHAR2(200);

        BEGIN
            OPEN pa_evncursor FOR
                SELECT
                    fievento,
                    fcevento
                FROM
                    scsisges.tcevento
                WHERE
                    fcestatus = pa_status;

            EXCEPTION
                WHEN OTHERS THEN
					SCSISGES.SPERRORES (
                        SYSDATE,
                        SQLCODE,
                        SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                        'SCSISGES.spevents');

                OPEN pa_evncursor FOR
                    SELECT
                        NULL fievento,
                        NULL fcevento
                    FROM DUAL;

				vl_codigoerror := SQLCODE;
				vl_mensajeerror := SQLERRM;
	    END;
 
    PROCEDURE speventsag (
        pa_fiusuarioid      IN VARCHAR2,
        pa_fctitulo         IN VARCHAR2,
        pa_fcnota           IN VARCHAR2,
        pa_fdhorainicio     IN VARCHAR2,
        pa_fdhorafin        IN VARCHAR2,
        pa_fievento         IN NUMBER,
        pa_fdfecha          IN VARCHAR2,
        pa_fiduracion       IN NUMBER,
        pa_fccliente        IN VARCHAR2,
        pa_ficliente        IN VARCHAR2,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2,
        pa_figestionid      IN scsisges.taeventgest.figestionid%TYPE DEFAULT NULL)

    AS
        PRAGMA              AUTONOMOUS_TRANSACTION;
        vl_horainicio       DATE;
        vl_horafin          DATE;
        pa_FIIDPAIS         NUMBER := CSL_0;
        pa_FIIDTERRITORIO   NUMBER := CSL_0;
        pa_FIIDZONA         NUMBER := CSL_0;
        pa_FIIDREGION       NUMBER := CSL_0;
        pa_FIIDSUCURSAL     NUMBER := CSL_0;
        vl_fiidevento       scsisges.taevento.fiidevento%TYPE;
        
        BEGIN
            vl_horainicio := TO_TIMESTAMP (
				pa_fdhorainicio,
				'yyyy-MM-dd HH24:MI:SS');
            vl_horafin := TO_TIMESTAMP (
				pa_fdhorafin,
				'yyyy-MM-dd HH24:MI:SS');

            BEGIN
                SELECT
                    TCS.FIIDPAIS,
                    TCS.FIIDTERRITORIO,
                    TCS.FIIDZONA,
                    TCS.FIIDREGION,
                    TCS.FIIDSUCURSAL
                INTO
                    pa_FIIDPAIS,
                    pa_FIIDTERRITORIO,
                    pa_FIIDZONA,
                    pa_FIIDREGION,
                    pa_FIIDSUCURSAL
                FROM
                    SCSISGES.TCFXSUCURSAL TCS,
                    SCSISGES.TAEMPLEADOPF TAE
                WHERE
                    TAE.FNEMPLEADO = pa_fiusuarioid
                    AND TCS.FINUMCECOSUC = TAE.FNCC;

                EXCEPTION
                    WHEN OTHERS THEN
                        NULL;
            END;

            INSERT INTO scsisges.taevento (
                fiusuarioid,
                fctitulo,
                fcnota,
                fdhorainicio,
                fdhorafin,
                fievento,
                fdfecha,
                fiduracion,
                fccliente,
                ficliente,
                fdbitacora,
				FIIDPAIS,
                FIIDTERRITORIO,
                FIIDZONA,
                FIIDREGION,
                FIIDSUCURSAL)
            VALUES (
                pa_fiusuarioid,
                pa_fctitulo,
                pa_fcnota,
                vl_horainicio,
                vl_horafin,
                pa_fievento,
                TO_DATE (
					pa_fdfecha,
					'yyyy-MM-dd'),
                pa_fiduracion,
                pa_fccliente,
                pa_ficliente,
                (SYSTIMESTAMP),
				pa_FIIDPAIS,
                pa_FIIDTERRITORIO,
                pa_FIIDZONA,
                pa_FIIDREGION,
                pa_FIIDSUCURSAL)
            RETURNING FIIDEVENTO INTO vl_fiidevento;

            pa_codigo := CSL_200;
            pa_mensaje := CSL_OK;
            COMMIT;
            scsisges.pqsbgestion0002.spieventgest (
                pa_figestionid,
				pa_fiusuarioid,
                vl_fiidevento,
				pa_ficliente);

            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    pa_codigo := SQLCODE;
                    pa_mensaje := SQLERRM;
                    scsisges.sperrores (
                        SYSDATE,
                        SQLCODE,
                        SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                        'SCSISGES.PAEVENTS.SPEVENTSAG');
	    END;

    PROCEDURE speventsup (
        pa_fiidevento       IN INTEGER,
        pa_fiusuarioid      IN VARCHAR2,
        pa_fctitulo         IN VARCHAR2,
        pa_fcnota           IN VARCHAR2,
        pa_fdhorainicio     IN VARCHAR2,
        pa_fdhorafin        IN VARCHAR2,
        pa_fievento         IN NUMBER,
        pa_fdfecha          IN VARCHAR2,
        pa_fiduracion       IN NUMBER,
        pa_fccliente        IN VARCHAR2,
        pa_ficliente        IN VARCHAR2,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2)

    AS
        PRAGMA              AUTONOMOUS_TRANSACTION;
        vl_horainicio       DATE;
        vl_horafin          DATE;

        BEGIN
            UPDATE 
                scsisges.taevento
				SET
					fctitulo = pa_fctitulo,
					fcnota = pa_fcnota,
					fdhorainicio = TO_TIMESTAMP (
						pa_fdhorainicio,
						'yyyy-MM-dd HH24:MI:SS'),
					fdhorafin = TO_TIMESTAMP (
						pa_fdhorafin,
						'yyyy-MM-dd HH24:MI:SS'),
					fievento = pa_fievento,
					fdfecha = TO_DATE (
						pa_fdfecha,
						'yyyy-MM-dd'),
					fiduracion = pa_fiduracion,
					fccliente = pa_fccliente,
					ficliente = pa_ficliente,
					fdbitacora = SYSTIMESTAMP
				WHERE
					fiidevento = pa_fiidevento
					AND fiusuarioid = pa_fiusuarioid;
 
            pa_codigo := CSL_200;
            pa_mensaje := CSL_OK;
            COMMIT;

            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
                    SCSISGES.SPERRORES (
                    SYSDATE,
                    SQLCODE,
                    SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                    'SCSISGES.speventsup');
                    pa_codigo := SQLCODE;
                    pa_mensaje := SQLERRM;
	    END;

    PROCEDURE speventsdl (
        pa_fiidevento       IN INTEGER,
        pa_fiusuarioid      IN VARCHAR2,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2)

    AS
        PRAGMA              AUTONOMOUS_TRANSACTION;
        vl_horainicio       DATE;
        vl_horafin          DATE;

        BEGIN
            DELETE
                scsisges.taevento
                WHERE
                    fiidevento = pa_fiidevento
                    AND fiusuarioid = pa_fiusuarioid;
    
            pa_codigo := CSL_200;
            pa_mensaje := CSL_OK;
            COMMIT;

            EXCEPTION
                WHEN OTHERS THEN
                    ROLLBACK;
					SCSISGES.SPERRORES (
                	SYSDATE,
                	SQLCODE,
                	SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                	'SCSISGES.speventsdl');
                    pa_codigo := SQLCODE;
                    pa_mensaje := SQLERRM;
	    END;
 
    PROCEDURE speventsvw (
        pa_fiusuarioid      IN VARCHAR2,
        curevents           OUT SYS_REFCURSOR,
        pa_codigo           OUT INTEGER,
        pa_mensaje          OUT VARCHAR2)

    AS
        PRAGMA              AUTONOMOUS_TRANSACTION;
        vl_horainicio       DATE;
        vl_horafin          DATE;

        BEGIN
            OPEN curevents FOR
                SELECT
                    ta.fiidevento,
                    ta.fiusuarioid,
                    ta.fctitulo,
                    ta.fcnota,
                    ta.fdhorainicio,
                    ta.fdhorafin,
                    ta.fievento,
                    ta.fdfecha,
                    ta.fiduracion,
                    ta.fccliente,
                    ta.ficliente,
                    tc.fccolorpri,
                    tc.fccolorsec,
                    tc.fcdescevento,
                    tc.fcicono
                FROM
                    scsisges.taevento ta,
                    scsisges.tcevento tc
                WHERE
                    ta.fievento = tc.fievento
                    AND ta.fiusuarioid = pa_fiusuarioid
					AND TC.FIEVENTO > CSL_0;

            pa_codigo := CSL_200;
            pa_mensaje := CSL_OK;

            EXCEPTION
                WHEN OTHERS THEN
                    SCSISGES.SPERRORES (
                    SYSDATE,
                    SQLCODE,
                    SQLERRM || '-' || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE (),
                    'SCSISGES.speventsvw');

                OPEN curevents FOR
                    SELECT 
                        NULL fiidevento,
                        NULL fiusuarioid,
                        NULL fctitulo,
                        NULL fcnota,
                        NULL fdhorainicio,
                        NULL fdhorafin,
                        NULL fievento,
                        NULL fdfecha,
                        NULL fiduracion,
                        NULL fccliente,
                        NULL ficliente,
                        NULL fccolorpri,
                        NULL fccolorsec,
                        NULL fcdescevento,
                        NULL fcicono
                    FROM DUAL;

                pa_codigo := SQLCODE;
                pa_mensaje := SQLERRM;
	    END;

END PAEVENTS;
/

  GRANT EXECUTE ON SCSISGES.PAEVENTS TO USRSISGES;
  GRANT EXECUTE ON SCSISGES.PAEVENTS TO USRVENTAST;
