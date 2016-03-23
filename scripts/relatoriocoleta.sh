#!/bin/bash

ONTEM=`TZ=GMT+24 date +%Y%m%d`

#Coletando resultados da snesun304 para o dashboard
#dados do SAN45
scp pcsopn3@snesun304:/export/home/pcsopn3/relatorio/san45/$ONTEM.* ~/relatorios/san45/

#dados do sap
scp pcsopn3@snesun304:/export/home/pcsopn3/relatorio/sap/$ONTEM.* ~/relatorios/sap/