--------------------------------------------------------
--  DDL for Index IDX_PEDCIFRAS2
--------------------------------------------------------

  CREATE INDEX "SCVENTASTIENDA"."IDX_PEDCIFRAS2" ON "SCVENTASTIENDA"."TAPEDCIFRASCTRL" ("FISUCURSAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_DATA03_IDX" ;
