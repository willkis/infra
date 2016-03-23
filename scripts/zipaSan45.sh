#!/usr/bin/bash
# Loga nos servidores e efetua a compressao do log do diretorio /app/CA/siteminder/log/san45
DATA=`date +%Y%m%d -d "1 days ago" `

cd /app/CA/siteminder/log/san45
#Zipa os logs antigos
gzip $DATA_*