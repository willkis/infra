#!/bin/bash

#cria a vriavel data e acessa o diretorio /app/CA/siteminder/log/san45

ONTEM=`TZ=GMT+24 date +%Y%m%d`

cd /app/CA/siteminder/log/san45

#Zipa os logs antigos

gzip $ONTEM*



#DIR=/app/CA/siteminder/log/
DIR=/app/CA/siteminder/log/san45

#### Verifica a data dos arquivos .GZ com mais de 45 dias e os remove ####
find $DIR/* -mtime +45 -name "*.gz" -exec rm {}  \;