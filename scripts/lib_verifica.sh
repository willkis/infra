#!/usr/bin/bash

# Processo principal esta em execucao?
policy_running() {
	erro=`ps -ef|grep smpolicysrv|/usr/xpg4/bin/grep -qv grep`
	return $erro
}

# Qual o uso de cada CPU?
cpu_usage() {
	#size=`mpstat | wc -l`
	#mpstat|tail -$(($size-1))|awk '{ print $13+$14+$15 }'
	vmstat |tail -1 | awk '{ print $20+$21 }'
}

# Qual o uso de memoria?
memory_usage() {
	# primeiro obtemos o total de memoria ram
	# temos que multiplicar por 1024 pois o total eh em MB e precisamos KB
	TOTALRAM=`/usr/sbin/prtconf |grep  "Memory size"|awk '{print $3*1024;}'`
	# depois quanto esta livre
	FREERAM=`vmstat |tail -1|awk '{ print $5}'`
	USEDRAM=$(($TOTALRAM-$FREERAM))
	PUSEDRAM=$(($USEDRAM*100/$TOTALRAM))
	return $PUSEDRAM
}

portas() {
  netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44441 && {
    netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44442 && {
      netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44443 && {
        netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44444 && {
          echo "SIM"; } || {
          echo "NAO";
        }
      } || { echo "NAO";}
    } || { echo "NAO";}
  } || { echo "NAO"; }
}

ultimo_restart() {
	SMPID=`ps -ef|grep smpolicysrv|grep -v grep|awk '{ print $2;}'`
#	ps -ef -o fname,pid,etime,stime|grep $SMPID|awk '{ print $4;}'
 	ps -ef -o fname,pid,stime|grep $SMPID|awk '{ print $3;}'|/usr/xpg4/bin/awk 'BEGIN { FS = "[_:]" };{ print $1":"$2;}'
}

# Quanto foi usado da particao /app?
app_usage() {
        df -h /app|paste - -|awk '{ print $12;}'
}


#####
# executa
####

policy_running
tmp=$?
[ $tmp -eq 0 ] && running="SIM" || running="NAO"

APP=`app_usage`
CPU=`cpu_usage`
memory_usage
MEM=$?
listening=`portas`
ultimorestart=`ultimo_restart`



printf "| Policy em execucao:\t\t   %3s | Portas OK:\t\t\t   %3s |\n" $running $listening
printf "| Ultimo reinicio automatico do Policy:\t\t\t\t%3s\t       |\n" $ultimorestart
printf "| Uso de cpu:\t %3s %% | Uso de memoria:\t %3s %% | Uso do /app:\t %3s %% |\n" $CPU $MEM $APP
