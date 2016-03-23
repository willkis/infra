#!/bin/bash

#cria a vriavel data e acessa o diretorio /app/CA/Directory/dxserver/logs

####ONTEM=`TZ=GMT+24 date +%Y%m%d`
ONTEM=`date --date "last month" +%Y%m`
NOME=`hostname`
NUMERO=`echo $NOME | cut -d 'i' -f2`
cd /app/CA/Directory/dxserver/logs

#Zipa os logs antigos

gzip biru_router"$NUMERO"_stats_$ONTEM*
gzip biru_router"$NUMERO"_warn_$ONTEM*
gzip biru_router"$NUMERO"_diag_$ONTEM*
gzip biru_router"$NUMERO"_summary_$ONTEM*

gzip biru_"$NOME"_stats_$ONTEM*
gzip biru_"$NOME"_warn_$ONTEM*
gzip biru_"$NOME"_diag_$ONTEM*
gzip biru_"$NOME"_summary_$ONTEM*

# Diretó de logs /app/CA/Directory/dxserver/logs
DIR=/app/CA/Directory/dxserver/logs

#### Verifica a data dos arquivos .GZ com mais de 45 dias e os remove ####
find $DIR/* -mtime +45 -name "*.gz" -exec rm {}  \;
