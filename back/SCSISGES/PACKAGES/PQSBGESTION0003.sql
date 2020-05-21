--------------------------------------------------------
--  DDL for Package PQSBGESTION0003
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "SCSISGES"."PQSBGESTION0003" AS

   PROCEDURE SPLISTGSTCU (pa_tb_cus      IN     SCSISGES.TYTBGSTCU,
                          pa_curGstCUs      OUT SYS_REFCURSOR,
                          pa_codmsg         OUT INTEGER,
                          pa_msg            OUT VARCHAR2,
                          pa_msgerror       OUT VARCHAR2);

END pqsbgestion0003;

/

  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRACTVT";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRINFFENIX";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRSISGES";
  GRANT EXECUTE ON "SCSISGES"."PQSBGESTION0003" TO "USRVENTAST";
