#!/usr/bin/bash
# Loga nos servidores e efetua a compressao do log
for HOST in 10.170.36.24 10.170.36.25 10.170.36.26 10.170.36.36 10.170.36.37 10.170.36.54 10.170.36.57 10.170.53.23; do 
	ssh $HOST "cd /app/CA/siteminder/log/; gzip smaccess_*.log "
done



