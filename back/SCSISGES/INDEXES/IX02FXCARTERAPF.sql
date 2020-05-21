--------------------------------------------------------
--  DDL for Index IX02FXCARTERAPF
--------------------------------------------------------

  CREATE INDEX "SCSISGES"."IX02FXCARTERAPF" ON "SCSISGES"."TAFXCARTERAPF" ("FIIDSUCURSAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "TAFXCARTERAP_01" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP01_IDX" , 
 PARTITION "TAFXCARTERAP_02" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP02_IDX" , 
 PARTITION "TAFXCARTERAP_03" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP03_IDX" , 
 PARTITION "TAFXCARTERAP_04" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP04_IDX" , 
 PARTITION "TAFXCARTERAP_05" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP05_IDX" , 
 PARTITION "TAFXCARTERAP_06" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP06_IDX" , 
 PARTITION "TAFXCARTERAP_07" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP07_IDX" , 
 PARTITION "TAFXCARTERAP_08" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP08_IDX" , 
 PARTITION "TAFXCARTERAP_09" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP09_IDX" , 
 PARTITION "TAFXCARTERAP_10" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCSI_TFXCRTRPF_RP10_IDX" ) ;
