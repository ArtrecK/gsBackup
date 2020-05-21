--------------------------------------------------------
--  DDL for Index IDXACT0011
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCACTUALIZADORVT"."IDXACT0011" ON "SCACTUALIZADORVT"."TACAT_ERROR" ("FIERR_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_CATALOGO_IDX" ;
