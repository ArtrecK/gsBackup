--------------------------------------------------------
--  DDL for Index IDXTATRANCBE01
--------------------------------------------------------

  CREATE INDEX "SCACTUALIZADORVT"."IDXTATRANCBE01" ON "SCACTUALIZADORVT"."TATRNCRCBEHIST" ("FITRANNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TATRNCRCBE_IDX" ;
