--------------------------------------------------------
--  DDL for Index IDX_VENEMPHIST
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IDX_VENEMPHIST" ON "SCSISGES"."TAVENTASACUMHIST" ("FNEMPLEADO", "FIIDSUCURSAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA01_IDX" ;
