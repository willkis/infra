#!/bin/bash
#snesun363
#usuario itimldap

db2 backup db LDAPDB2 online to /app/home/itimldap/backup/363/ compress without prompting

ARQ=$(ls -lt | grep LDAPDB2 | awk '{print($9)}' |head -1)

db2ckbkp -h /app/home/itimldap/backup/363/$ARQ

cp /app/home/itimldap/backup/363/$ARQ /backup/BACKUPS-DB2/363/ITIMLDAP/ 

#db2 terminate  