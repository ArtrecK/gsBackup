--------------------------------------------------------
--  DDL for Index IDXACT0014
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCACTUALIZADORVT"."IDXACT0014" ON "SCACTUALIZADORVT"."TACTRLTIPTRANS" ("FIPAISID", "FICANAL", "FISUCURSAL", "FITRANNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP01_IDX"  LOCAL
 (PARTITION "PTACTRL_CONSEC_TIPTRAN1" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP01_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN2" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP02_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN3" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP03_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN4" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP04_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN5" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP05_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN6" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP06_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN7" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP07_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN8" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP08_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN9" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP09_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN10" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP10_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN11" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP11_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN12" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP12_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN13" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP13_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN14" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP14_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN15" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP15_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN16" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP16_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN17" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP17_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN18" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP18_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN19" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP19_IDX" , 
 PARTITION "PTACTRL_CONSEC_TIPTRAN20" 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCACT_TACTRLCONS_RP20_IDX" ) ;
