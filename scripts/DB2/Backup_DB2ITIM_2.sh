#!/bin/bash

db2 backup db itim online to /app/home/db2itim/backup_HADR/ compress without prompting
ARQ=$(ls -lt | grep ITIM | awk '{print($9)}' |head -1)
db2ckbkp -h /app/home/db2itim/backup_HADR/$ARQ

cp /app/home/db2itim/backup_HADR/$ARQ /backup/BACKUPS-DB2/363/DB2ITIM/ &

db2 terminate