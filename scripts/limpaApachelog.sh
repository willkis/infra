#!/bin/bash

#cria a vriavel do diretorio alvo onde logs estao

DIR=/app/pcs/apache/logs

cd $DIR

#Zipa os logs  de acessos antigos
for ACLOG in `ls -l access_log* | awk '{print $9}' | sed '$d'`; do
gzip $ACLOG
done

#Zipa os logs de erro antigo
for ERLOG in `ls -l error_log* | awk '{print $9}' | sed '$d'`; do
gzip $ERLOG
done




#### Verifica a data dos arquivos .GZ com mais de 45 dias e os remove ####
#find $DIR/* -mtime +45 -name "*.gz" -exec rm {}  \;
