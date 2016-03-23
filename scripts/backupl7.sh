#!/bin/bash

DATA=$(date +%Y%m%d)

/opt/SecureSpan/Gateway/config/backup/ssgbackup.sh -image name.gz -ia


cd /opt/SecureSpan/Gateway/config/backup/images/

mv $DATA* /srv/backup

find /srv/backup/* -mtime +7 -name "*.gz" -exec rm {}  \;