#!/bin/bash
#usuario db2itim servidor snesun363 
db2 backup db itim online to /app/home/db2itim/backup_HADR/ compress without prompting

cd /app/home/db2itim/backup_HADR/

ARQ=$(ls -lt | grep ITIM | awk '{print($9)}' |head -1)

db2ckbkp -h /app/home/db2itim/backup_HADR/$ARQ > ~/checkbkpitim.log

cp /app/home/db2itim/backup_HADR/$ARQ /backup/BACKUPS-DB2/363/DB2ITIM/ &

#db2 terminate