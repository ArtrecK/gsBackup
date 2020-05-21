--------------------------------------------------------
--  DDL for Index IDXPKPERFALERTA
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCSISGES"."IDXPKPERFALERTA" ON "SCSISGES"."TAPERFALERTA" ("FIALERTAID", "FIPERFILID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA03_IDX" ;
