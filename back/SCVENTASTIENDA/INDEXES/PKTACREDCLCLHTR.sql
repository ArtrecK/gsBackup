--------------------------------------------------------
--  DDL for Index PKTACREDCLCLHTR
--------------------------------------------------------

  CREATE UNIQUE INDEX "SCVENTASTIENDA"."PKTACREDCLCLHTR" ON "SCVENTASTIENDA"."TACREDCTECTEHTR" ("FIPAIS", "FICANAL", "FISUCURSAL", "FIIDNEGOCIO", "FIIDTIENDA", "FIIDCLIENTE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE( INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SCVEN_TACRECLICL_RP01_IDX" ;
