#!/bin/bash
data=`date '+%Y%m%d_%H:%M'`
#restart do servidor Apache
APACHEBIN=/appl/apache/pac/bin/apachectl

#Parando do servico Apache
sudo $APACHEBIN stop
sleep 10
		if [ $? -eq 0 ]; then
			echo "Apache sendo desligado..." >> log.txt
				 echo "============================================"  >> log.txt
		fi					
		
APACHEPROC=$(ps aux |grep apache |awk '{print $2}' | grep -v grep | wc -l)
					if [ $APACHEPROC -lt 1]; then
						echo "$data ha $APACHEPROC presos"  >> log.txt
						echo "============================================" >> log.txt
							else
							echo "$data Apache desligado com sucesso."
							echo "============================================" >> log.txt
					fi
#Iniciando o Apache	

sudo $APACHEBIN start
		if [ $? -eq 0 ]; then
			echo "Apache sendo iniciado..." >> log.txt
				 date
				 echo "============================================" >> log.txt
		fi					
		
APACHEPROC=$(ps aux |grep apache |awk '{print $2}' | grep -v grep | wc -l)
					if [ $APACHEPROC -ge 3]; then
						echo "Apache iniciado com sucesso no dia $data"  >> log.txt
						echo "============================================" >> log.txt
							else
							echo " $data Apache não foi iniciado com sucesso, favor verificar logs" >> log.txt
				    echo "============================================" >> log.txt
					fi