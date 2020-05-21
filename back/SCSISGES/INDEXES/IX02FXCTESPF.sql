--------------------------------------------------------
--  DDL for Index IX02FXCTESPF
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IX02FXCTESPF" ON "SCSISGES"."TAFXCLIENTESPF" ("FIPAIS", "FICANAL", "FISUCURSAL", "FIFOLIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "TAFXCTESPF_01" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP01_IDX" , 
 PARTITION "TAFXCTESPF_02" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP02_IDX" , 
 PARTITION "TAFXCTESPF_03" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP03_IDX" , 
 PARTITION "TAFXCTESPF_04" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP04_IDX" , 
 PARTITION "TAFXCTESPF_05" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP05_IDX" , 
 PARTITION "TAFXCTESPF_06" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP06_IDX" , 
 PARTITION "TAFXCTESPF_07" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP07_IDX" , 
 PARTITION "TAFXCTESPF_08" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP08_IDX" , 
 PARTITION "TAFXCTESPF_09" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP09_IDX" , 
 PARTITION "TAFXCTESPF_10" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSIS_TAFXCLIENT_RP10_IDX" ) ;
