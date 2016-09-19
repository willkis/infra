#!/bin/bash

################ExportCapacity###########
#script para exportar a quantidade de   #
#autenticacao para o Capacity sem usar o#
#Banco do dashboard                     #
#Criado por: Willian Kis                #
#Data: 19/09/2016                       #
#########################################


#Ldapsearch para pegar todas as aplicacoes 
ldapsearch -h servidor -D "uid=itim, ou=Special Users,dc=tim,dc=com,dc=br" -s SUB -w 'senha' -p 1389 -b "ou=applications,dc=tim,dc=com,dc=br" "(ou=*)" |grep "ou: " |cut -d ":" -f2 | awk '{print $1}' > aplicacao.txt

#Variaveis
ONTEM=`TZ=GMT+24 date +%Y%m%d`
ANOONTEM=`TZ=GMT+24 date +%Y`
DATACSV=`TZ=GMT+24 date +%d/%m/%Y`
aplicacao=$(cat aplicacao.txt |grep -v applications)
APP=$aplicacao
hora=0

#laco para pegar montar o arquivo csv
for ANSWER in ${APP[*]}

do

	while [ $hora -le 23 ]
	do

		if [ $hora -lt 10 ] 
		then
			hora1=0$hora
			TOTALHORA=`gzcat /app/reports/logmanagement/out/$ONTEM\smacesslog_full.GZ |grep $ANSWER | egrep "AuthAccept|ValidateAccept|AuthReject" | grep "$ANOONTEM\:$hora1" | wc -l`
			TOTALHORA2=`echo $TOTALHORA`
			echo "$ANSWER;$DATACSV $hora1:00:00;$TOTALHORA2" >>exportCapacity.csv
		else
		hora1=$hora
		TOTALHORA=`gzcat /app/reports/logmanagement/out/$ONTEM\smacesslog_full.GZ |grep $ANSWER | egrep "AuthAccept|ValidateAccept|AuthReject" | grep "$ANOONTEM\:$hora1" | wc -l`
		TOTALHORA2=`echo $TOTALHORA`
		echo "$ANSWER;$DATACSV $hora1:00:00;$TOTALHORA2" >>exportCapacity.csv
		fi;
	(( hora++ ))
	done
done

#Load para o capacity
sqlldr INM_PCS/INM_PCS@CAPLANP1 control=/app/scripts/capacity/capacity.ctl log=/app/home/pcsopn3/log/consolidado.log 
