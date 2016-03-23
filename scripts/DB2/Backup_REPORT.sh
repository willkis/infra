#!/bin/bash
#usuario njrbra no servidor snesun363

db2 backup db report online to /app/home/njrbra/backup/REPORT/ compress without prompting

cd /app/home/njrbra/backup/REPORT/

ARQ=$(ls -lt | grep REPORT | awk '{print($9)}' |head -1)

db2ckbkp -h  /app/home/njrbra/backup/REPORT/$ARQ

cp /app/home/njrbra/backup/REPORT/$ARQ /backup/BACKUPS-DB2/363/REPORT/ &

#db2 terminate  