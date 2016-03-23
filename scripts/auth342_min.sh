#!/bin/bash
# este script conecta nos 4 policies e retorna o numero de autenticacoes
# com e sem sucesso ocorridas no minuto anterior


# descomente a linha abaixo para 10 minutos atras
#datescript=`/home/pcsop/scripts/calcdate.pl -600`
datescript=`/app/home/pcsop/scripts/calcdate.pl -60`

dia=`echo $datescript | cut -d"/" -f1`
mes=`echo $datescript | cut -d"/" -f2 | sed 's/01/Jan/g;s/02/Feb/g;s/03/Mar/g;s/04/Apr/g;s/05/May/g;s/06/Jun/g;s/07/Jul/g;s/08/Aug/g;s/09/Sep/g;s/010/Oct/g;s/011/Nov/g;s/012/Dec/g;'`
ano=`echo $datescript | cut -d"/" -f3 | cut -d" " -f1`
hora=`echo $datescript | cut -d"/" -f3 | cut -d" " -f2 | cut -d":" -f1`

# descomente a linha abaixo para o intervalo de minutos atras
#minuto=`echo $datescript | cut -d"/" -f3 | cut -d" " -f2 | cut -d":" -f2 | awk '
minuto=`echo $datescript | cut -d"/" -f3 | cut -d" " -f2 | cut -d":" -f2 `

smdate=$dia/$mes/$ano:$hora:$minuto
#smdate=$dia/$mes/$ano:$hora

smdir="/app/sm6.0/siteminder/log"

autenticacao() {
        #grep $smdate $smdir/smaccess.log
        #for policy in 10.170.36.24 10.170.36.25 10.170.36.26; do
        for policy in 10.170.36.26; do 
	ssh pcsop@$policy grep $smdate $smdir/smaccess.log
        done
}

authaccept=`autenticacao|grep AuthAccept | wc -l | awk '{print($1)}'`
authreject=`autenticacao|grep AuthReject | wc -l | awk '{print($1)}'`
echo "AuthAccept;$authaccept"
echo "AuthReject;$authreject"
