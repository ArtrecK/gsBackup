--------------------------------------------------------
--  DDL for Index IX03PFCAMPAMKT
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IX03PFCAMPAMKT" ON "SCSISGES"."TAFXCAMPANASMKT" ("FISUCURSALCU") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "CAMPANASMKT_01" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCAMPAN_RP01_IDX" , 
 PARTITION "CAMPANASMKT_02" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCAMPAN_RP02_IDX" , 
 PARTITION "CAMPANASMKT_03" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCAMPAN_RP03_IDX" , 
 PARTITION "CAMPANASMKT_04" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCAMPAN_RP04_IDX" , 
 PARTITION "CAMPANASMKT_05" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCAMPAN_RP05_IDX" ) ;
