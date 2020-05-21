ALTER SESSION SET CONTAINER = ORCLPDB1;
alter system set db_files=2000 scope=spfile sid='*';
ALTER SESSION SET CONTAINER = CDB$ROOT;
alter system set db_files=2000 scope=spfile sid='*';
shutdown abort;
startup;
alter pluggable database all close immediate;
alter pluggable database all open;