--------------------------------------------------------
--  DDL for Index IDX_OBJSUCSUC
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IDX_OBJSUCSUC" ON "SCSISGES"."TAOBJETIVOSUC" ("FIIDSUCURSAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "OBJETIVOSUC_01" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETSUC_RP01_IDX" , 
 PARTITION "OBJETIVOSUC_02" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETSUC_RP02_IDX" , 
 PARTITION "OBJETIVOSUC_03" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETSUC_RP03_IDX" , 
 PARTITION "OBJETIVOSUC_04" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETSUC_RP04_IDX" , 
 PARTITION "OBJETIVOSUC_05" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAOBJETSUC_RP05_IDX" ) ;
