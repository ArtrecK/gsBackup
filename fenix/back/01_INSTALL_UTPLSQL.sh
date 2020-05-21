#/bin/bash
unzip /opt/oracle/scripts/setup/utPLSQL.zip -d /home/oracle
cd /home/oracle/utPLSQL/source
sqlplus sys/0racleD3v@ORCLPDB1 as sysdba @install_headless.sql
sqlplus sys/0racleD3v@ORCLPDB1 as sysdba @create_synonyms_and_grants_for_public.sql ut3
rm -rf /home/oracle/utPLSQL
