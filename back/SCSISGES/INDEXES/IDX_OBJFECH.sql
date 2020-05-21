--------------------------------------------------------
--  DDL for Index IDX_OBJFECH
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IDX_OBJFECH" ON "SCSISGES"."THOBJETIVOEMP" ("FDFECHA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "OBJETIVOEMPH_01" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_THOBJETIVO_RP01_IDX" , 
 PARTITION "OBJETIVOEMPH_02" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_THOBJETIVO_RP02_IDX" , 
 PARTITION "OBJETIVOEMPH_03" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_THOBJETIVO_RP03_IDX" , 
 PARTITION "OBJETIVOEMPH_04" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_THOBJETIVO_RP04_IDX" , 
 PARTITION "OBJETIVOEMPH_05" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_THOBJETIVO_RP05_IDX" ) ;
