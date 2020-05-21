--------------------------------------------------------
--  DDL for Index IDX_TBCLIENTES1
--------------------------------------------------------

  CREATE INDEX "SCVENTASTIENDA"."IDX_TBCLIENTES1" ON "SCVENTASTIENDA"."TACLIENTES" ("FISUCURSAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) LOCAL
 (PARTITION "TAPCLIENTES_001" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP01_IDX" , 
 PARTITION "TAPCLIENTES_002" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP02_IDX" , 
 PARTITION "TAPCLIENTES_003" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP03_IDX" , 
 PARTITION "TAPCLIENTES_004" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP04_IDX" , 
 PARTITION "TAPCLIENTES_005" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP05_IDX" , 
 PARTITION "TAPCLIENTES_006" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP06_IDX" , 
 PARTITION "TAPCLIENTES_007" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP07_IDX" , 
 PARTITION "TAPCLIENTES_008" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP08_IDX" , 
 PARTITION "TAPCLIENTES_009" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TABCLIENTE_RP09_IDX" ) ;
