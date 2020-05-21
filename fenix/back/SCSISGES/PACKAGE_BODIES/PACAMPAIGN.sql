--------------------------------------------------------
--  DDL for Package Body PACAMPAIGN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "SCSISGES"."PACAMPAIGN" 
IS
    csl_1   CONSTANT INTEGER := 1;
    csl_0   CONSTANT INTEGER := 0;

    PROCEDURE SpCampaignVw (curCampaign   OUT SYS_REFCURSOR,
                            pa_codigo     OUT INTEGER,
                            pa_mensaje    OUT VARCHAR2)
    AS
    BEGIN
        OPEN curCampaign FOR   SELECT FnCampana, Fccampana, Fcdesccampana
                                 FROM SCSISGES.TACAMPANA
                             ORDER BY fncampana;

        pa_codigo := 200;
        pa_mensaje := 'OK';

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := SQLCODE;
            pa_mensaje := SQLERRM;
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PACAMPAIGN.SpCampaignVw');
    END;

    PROCEDURE SpCampaignAdd (pa_FnCampana       IN     NUMBER,
                             pa_Fccampana       IN     VARCHAR2,
                             pa_Fcdesccampana   IN     VARCHAR2,
                             pa_codigo             OUT INTEGER,
                             pa_mensaje            OUT VARCHAR2)
    AS
        vl_campana         INTEGER;
        vl_nombrecampana   INTEGER;
    BEGIN
        SELECT COUNT (csl_1)
          INTO vl_campana
          FROM SCSISGES.TACAMPANA
         WHERE fncampana = pa_FnCampana;

        SELECT COUNT (csl_1)
          INTO vl_nombrecampana
          FROM SCSISGES.TACAMPANA
         WHERE fncampana = pa_FnCampana AND Fccampana = pa_Fccampana;

        IF vl_campana > csl_0 AND vl_nombrecampana > csl_0
        THEN
            UPDATE SCSISGES.TACAMPANA
               SET fcDescCampana = pa_Fcdesccampana
             WHERE fncampana = pa_FnCampana AND Fccampana = pa_Fccampana;

            pa_codigo := 200;
            pa_mensaje := 'OK';
        ELSIF vl_campana > csl_0 AND vl_nombrecampana = csl_0
        THEN
            UPDATE SCSISGES.TACAMPANA
               SET fccampana = pa_Fccampana, fcDescCampana = pa_Fcdesccampana
             WHERE fncampana = pa_FnCampana;

            pa_codigo := 200;
            pa_mensaje := 'OK';
        ELSE
            IF pa_FnCampana > csl_0
            THEN
                INSERT INTO scsisges.TACAMPANA (FnCampana,
                                                Fccampana,
                                                Fcdesccampana)
                     VALUES (pa_FnCampana, pa_Fccampana, pa_Fcdesccampana);

                pa_codigo := 200;
                pa_mensaje := 'OK';
            END IF;

            pa_codigo := 200;
            pa_mensaje := 'valor < 0';
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            pa_codigo := SQLCODE;
            pa_mensaje := SQLERRM;
            scsisges.sperrores (
                SYSDATE,
                SQLCODE,
                SQLERRM || '-' || DBMS_UTILITY.format_error_backtrace (),
                'SCSISGES.PACAMPAIGN.SpCampaignAdd');
    END;
END PACAMPAIGN;



/*---------------------------------------------------------------------------------------*/

/

  GRANT EXECUTE ON "SCSISGES"."PACAMPAIGN" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PACAMPAIGN" TO "USRVENTAST";
