--------------------------------------------------------
--  DDL for Index IXTADATOSTEL
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IXTADATOSTEL" ON "SCSISGES"."TADATOSTELEFONO" ("FIPAIS", "FICANAL", "FISUCURSAL", "FIFOLIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_DATA01_IDX" ;
