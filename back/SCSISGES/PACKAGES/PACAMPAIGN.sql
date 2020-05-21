--------------------------------------------------------
--  DDL for Package PACAMPAIGN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PACAMPAIGN" 
IS
    -- Author  : B643963
    -- Created : 15/08/2018 05:25:21 p.m.
    -- Purpose : Paquete para administrar campa�as con descripci�n

    /************************************************************************************/
    PROCEDURE SpCampaignVw (curCampaign   OUT SYS_REFCURSOR,
                            pa_codigo     OUT INTEGER,
                            pa_mensaje    OUT VARCHAR2);

    PROCEDURE SpCampaignAdd (pa_FnCampana       IN     NUMBER,
                             pa_Fccampana       IN     VARCHAR2,
                             pa_Fcdesccampana   IN     VARCHAR2,
                             pa_codigo             OUT INTEGER,
                             pa_mensaje            OUT VARCHAR2);
END PACAMPAIGN;


/***************************************************/

/

  GRANT EXECUTE ON "SCSISGES"."PACAMPAIGN" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PACAMPAIGN" TO "USRVENTAST";
