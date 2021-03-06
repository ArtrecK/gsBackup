--------------------------------------------------------
--  DDL for Index IDXACT0007
--------------------------------------------------------

  CREATE INDEX "SCACTUALIZADORVT"."IDXACT0007" ON "SCACTUALIZADORVT"."TATRNCRDTE" ("ORA_ERR_ROWID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TRANDETERR_IDX" ;
