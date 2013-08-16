#!/bin/bash
data=`date '+%Y%m%d_%H:%M'`
data_log=`date '+%Y%m%d_%H:%M'`
#restart do servidor Apache
APACHEBIN=/appl/apache/pac/bin/apachectl

#Parando do servico Apache
sudo $APACHEBIN stop
sleep 10
		if [ $? -eq 0 ]; then
			echo "============================================" >> $data_log.txt
			echo "$data Apache sendo desligado..." >> $data_log.txt
			echo "============================================"  >> $data_log.txt
		fi					
		
APACHEPROC=$(ps aux |grep apache |awk '{print $2}' | grep -v grep | wc -l)
					if [ $APACHEPROC -lt 1 ]; then
						echo "============================================" >> $data_log.txt
						echo "$data ha $APACHEPROC presos"  >> $data_log.txt
						echo "============================================" >> $data_log.txt
							else
							echo "$data Apache desligado com sucesso."
							echo "============================================" >> $data_log.txt
					fi
					
#Iniciando o Apache	
sudo $APACHEBIN start
		if [ $? -eq 0 ]; then
			echo "============================================" >> $data_log.txt
			echo "$data Apache sendo iniciado..." >> $data_log.txt
				 date
				 echo "============================================" >> $data_log.txt
		fi					
		
APACHEPROC=$(ps aux |grep apache |awk '{print $2}' | grep -v grep | wc -l)
					if [ $APACHEPROC -ge 3 ]; then
					    echo "============================================" >> $data_log.txt
						echo "$data Apache iniciado com sucesso no dia "  >> $data_log.txt
						echo "============================================" >> $data_log.txt
							else
							echo " $data Apache não foi iniciado com sucesso, favor verificar logs" >> $data_log.txt
				    echo "============================================" >> $data_log.txt
					fi
