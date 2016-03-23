#!/bin/bash
#snesun363 com o usuario njrbra


db2 backup db dbnjrbra online to /app/home/njrbra/backup/DBNJRBRA/ compress without prompting

cd /app/home/njrbra/backup/DBNJRBRA/

ARQ=$(ls -lt | grep DBNJRBRA | awk '{print($9)}' |head -1)

db2ckbkp -h /app/home/njrbra/backup/DBNJRBRA/$ARQ


cp /app/home/njrbra/backup/DBNJRBRA/$ARQ /backup/BACKUPS-DB2/363/NJRBRA/ & 


#db2 terminate 