#!/bin/bash
#snesun364
#usuario itimldap

db2 backup db LDAPDB2 online to /app/home/itimldap/backup/364/ compress without prompting

cd /app/home/itimldap/backup/364/

ARQ=$(ls -lt | grep LDAPDB2 | awk '{print($9)}' |head -1)

db2ckbkp -h /app/home/itimldap/backup/364/$ARQ

cp /app/home/itimldap/backup/364/$ARQ /backup/BACKUPS-DB2/364/ITIMLDAP/ &

#db2 terminate  