#!/bin/bash
DATE_OLD=`date +%Y%m%d -d "1 days ago" `
DATA=`date +%d/%m/%Y -d "1 days ago" `
DATA1=`date +%d/%m/%Y -d "2 days ago" `
DATE_MY=`date +%Y-%m-%d -d "1 days ago" `
DATE_MY1=`date +%Y-%m-%d -d "2 days ago"`
MON_STR=`date +%b -d "1 days ago"`
ANO=`date +%Y -d "1 days ago" `
#fazendo scp do servidor snesun344 do log full do dia
scp pcsopn3@10.170.36.42:/app/reports/logmanagement/out/$DATE_OLD* .

#preparando arquivo para importar no mysql
zcat $DATE_OLD* | cut -d [ -f 9 | cut -d = -f 2 | cut -d , -f 1 > teste1.txt

zcat $DATE_OLD* | cut -d [ -f 2,3,5,6,7,8 > teste.txt

zcat $DATE_OLD* | cut -d [ -f 11,13,14,15 >teste2.txt

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA[$lineB[" >>formatando1.txt
done <teste.txt 3<teste1.txt


while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA$lineB" >>logs.txt
done <formatando1.txt 3<teste2.txt

sed "s/\]//g" logs.txt >logs2.txt
sed "s/ -0300//g" logs2.txt >formatando2.txt
sed "s/$ANO:/$ANO[/g" formatando2.txt > formatando3.txt

if [ "$MON_STR" == "Jan" ]; then
  sed "s/Jan/01/g" formatando3.txt >formatando4.txt
 else
if [ "$MON_STR" == "Feb" ]; then
  sed "s/Feb/02/g" formatando3.txt >formatando4.txt
fi
fi

if [ "$MON_STR" == "Mar" ]; then
  sed "s/Mar/03/g" formatando3.txt >formatando4.txt;
else
if [ "$MON_STR" == "Apr" ]; then
  sed "s/Apr/04/g" formatando3.txt >formatando4.txt
fi
fi

if [ "$MON_STR" == "May" ]; then
  sed "s/May/05/g" formatando3.txt >formatando4.txt;
else
if [ "$MON_STR" == "Jun" ]; then
  sed "s/Jun/06/g" formatando3.txt >formatando4.txt
 fi
 fi

if [ "$MON_STR" == "Jul" ]; then
  sed "s/Jul/07/g" formatando3.txt >formatando4.txt
else
if [ "$MON_STR" == "Aug" ]; then
  sed "s/Aug/08/g" formatando3.txt >formatando4.txt
fi
fi

if [ "$MON_STR" == "Sep" ]; then
  sed "s/Sep/09/g" formatando3.txt >formatando4.txt
else
if [ "$MON_STR" == "Oct" ]; then
  sed "s/Oct/10/g" formatando3.txt >formatando4.txt
fi
fi

if [ "$MON_STR" == "Nov" ]; then
  sed "s/Nov/11/g" formatando3.txt >formatando4.txt
else
if [ "$MON_STR" == "Dec" ]; then
  sed "s/Dec/12/g" formatando3.txt >formatando4.txt
fi
fi

#fazendo import final para o mysql
mysql -u root  siteminder -e "LOAD DATA LOCAL INFILE '/vms/log/formatando4.txt'
INTO TABLE sitemlog
FIELDS TERMINATED BY '['
LINES TERMINATED BY '\n'
(auth, authtype, server, olddatas,tempo, agent, sessao, uid, app, ip, url, method);"

mysql -u root  siteminder -e "UPDATE sitemlog set datas='$DATE_MY' WHERE olddatas='$DATA'"

mysql -u root  siteminder -e "UPDATE sitemlog set datas='$DATE_MY1' WHERE olddatas='$DATA1'"

#removendo arquivos temoprarios
rm -rf *.txt *.GZ

RESULADO=$(mysql -u root  siteminder -e "select count(*) from sitemlog where datas='$DATE_MY'")

echo $RESULADO
