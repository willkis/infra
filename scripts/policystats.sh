#!/usr/bin/bash

. ~pcsopn3/scripts/scripts.lib
# some important variables you can consider change
WARNLVL=60
CRITLVL=75

# don't touch from here
SIM=`text_color green; echo -n SIM;text_color white`
NAO=`text_color red; echo -n NAO;text_color white`


# Processo principal esta em execucao?
policy_running() {
	erro=`ps -ef|grep smpolicysrv|/usr/xpg4/bin/grep -qv grep`
	return $erro
}

# Qual o uso de cada CPU?
cpu_usage() {
	#size=`mpstat | wc -l`
	#mpstat|tail -$(($size-1))|awk '{ print $13+$14+$15 }'
	var=`vmstat|tail -1 | awk '{ print $20+$21 }'`
	# workaround to include a "0" - avoids break text align
	[ `echo -n "$var"|wc -c` -eq 1 ] && var=`echo "0$var"`
        [ $var -gt $CRITLVL ] && {
                text_color red
                echo -n "     $var%"
                text_color white
        } || {
                [ $var -gt $WARNLVL ] && {
                        text_color yellow
                        echo -n "     $var%"
                        text_color white
                } || {
                        text_color green
                        echo -n "     $var%"
                        text_color white
                }
        }

}

# Qual o uso de memoria?
memory_usage() {
	# primeiro obtemos o total de memoria ram
	# temos que multiplicar por 1024 pois o total eh em MB e precisamos KB
	TOTALRAM=`/usr/sbin/prtconf |grep  "Memory size"|awk '{print $3*1024;}'`
	# depois quanto esta livre
	FREERAM=`vmstat|tail -1|awk '{ print $5}'`
	USEDRAM=$(($TOTALRAM-$FREERAM))
	PUSEDRAM=$(($USEDRAM*100/$TOTALRAM))
	#return $PUSEDRAM
	#echo "$PUSEDRAM%"
	# workaround to include a "0" - avoids break text align
	[ `echo -n "$PUSEDRAM"|wc -c` -eq 1 ] && var=`echo "0$PUSEDRAM"`
        [ $PUSEDRAM -gt $CRITLVL ] && {
                text_color red
                echo -n "          $PUSEDRAM%"
                text_color white
        } || {
                [ $PUSEDRAM -gt $WARNLVL ] && {
                        text_color yellow
                        echo -n "          $PUSEDRAM%"
                        text_color white
                } || {
			text_color green
                        echo -n "          $PUSEDRAM%"
                        text_color white
                }
        }

}

portas() {
  netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44441 && {
    netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44442 && {
      netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44443 && {
        netstat -na |grep LISTEN |/usr/xpg4/bin/grep -wq 44444 && {
          echo "$SIM"; } || {
          echo "$NAO";
        }
      } || { echo "$NAO";}
    } || { echo "$NAO";}
  } || { echo "$NAO"; }
}

ultimo_restart() {
	SMPID=`ps -ef|grep smpolicysrv|grep -v grep|awk '{ print $2;}'`
#	ps -ef -o fname,pid,etime,stime|grep $SMPID|awk '{ print $4;}'
 	ps -ef -o fname,pid,stime|grep $SMPID|awk '{ print $3;}'|/usr/xpg4/bin/awk 'BEGIN { FS = "[_:]" };{ print $1":"$2;}'
}

# Quanto foi usado da particao /app?
app_usage() {
        var=`df -h /app|paste - -|awk '{ print $12;}'|tr -d "%"`
	# workaround to include a "0" - avoids break text align
	[ `echo -n "$var"|wc -c` -eq 1 ] && var=`echo "0$var"`
	[ $var -gt $CRITLVL ] && { 
		text_color red
		echo -n "     $var%"
		text_color white
	} || { 
		[ $var -gt $WARNLVL ] && { 
			text_color yellow
			echo -n "     $var%"
			text_color white
		} || {
			text_color green
			echo -n "     $var%"
                        text_color white
		} 
	}
}

ultimo_san45() {
	hoje=`date +%Y%m%d`
	last_file=`ls /app/sm6.0/siteminder/log/san45/*_snm45LIB.log|tail -1`
	tmp=`tail -1 $last_file|awk '{ print $1 " " $2;}'`
	echo $last_file|/usr/xpg4/bin/grep -q $hoje && { 
		text_color green
		echo -n $tmp
		text_color white
		
	} || { 
		text_color red	
		echo -n $tmp
		text_color white
	}
} 

host_name()
{
        text_color cyan
		echo -n $host1
		text_color white
}

#####
# executa
####

policy_running
tmp=$?
[ $tmp -eq 0 ] &&  { 
	running="$SIM"
	ultimorestart=`ultimo_restart` 
	} || { 
	running="$NAO"
	ultimorestart="    na"
}

APP=`app_usage`
CPU=`cpu_usage`
MEM=`memory_usage`
listening=`portas`
#ultimorestart=`ultimo_restart`
ultimosan45=`ultimo_san45`
host1=`hostname`
host=`host_name`
# host=`text_color cyan; hostname ;text_color white`

echo "| Hostname:  $host                                                         |"
echo "| Policy em execucao:               $running | Portas OK:                       $listening |"
echo "| Ultimo reinicio automatico do Policy:                           $ultimorestart       |"
echo "| Ultima escrita no San45:                         $ultimosan45       |"
echo "| Uso de cpu: $CPU | Uso de memoria: $MEM | Uso do /app: $APP |"
