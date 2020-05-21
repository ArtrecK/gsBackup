--------------------------------------------------------
--  DDL for Index PKTAPREPARAME
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCVENTASTIENDA"."PKTAPREPARAME" ON "SCVENTASTIENDA"."TAPREPARAME" ("FIPAIS", "FICANAL", "FISUCURSAL", "FIFOLIOPARAM") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "TAPCLIENTES_001" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP01_IDX" , 
 PARTITION "TAPCLIENTES_002" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP02_IDX" , 
 PARTITION "TAPCLIENTES_003" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP03_IDX" , 
 PARTITION "TAPCLIENTES_004" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP04_IDX" , 
 PARTITION "TAPCLIENTES_005" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP05_IDX" , 
 PARTITION "TAPCLIENTES_006" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP06_IDX" , 
 PARTITION "TAPCLIENTES_007" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP07_IDX" , 
 PARTITION "TAPCLIENTES_008" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP08_IDX" , 
 PARTITION "TAPCLIENTES_009" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TAPREPARAM_RP09_IDX" ) ;
