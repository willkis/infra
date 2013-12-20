#!/bin/bash
DATE_OLD=`date +%Y%m%d -d "1 days ago" `
DATA_MY=`date +%d-%m-%Y -d "1 days ago" `
DATE_MY=`date +%Y-%m-%d -d "1 days ago" `

#fazendo scp do servidor snesun344 do log full do dia
scp user@server:/app/reports/logmanagement/out/$DATE_OLD* .

#preparando arquivo para importar no mysql
zcat $DATE_OLD* | cut -d [ -f 9 | cut -d = -f 2 | cut -d , -f 1 > teste1.txt

zcat $DATE_OLD* | cut -d [ -f 2,3,5,6,7,8 > teste.txt

zcat $DATE_OLD* | cut -d [ -f 11,13,14,15 >teste2.txt

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA,$lineB," >>formatando1.txt
done <teste.txt 3<teste1.txt


while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA$lineB" >>logs.txt
done <formatando1.txt 3<teste2.txt

sed "s/\[/,/g" logs.txt > logs1.txt
sed "s/\]//g" logs1.txt >logs2.txt
sed "s/ -0300//g" logs2.txt >formatando2.txt
sed "s/2013:/2013,/g" formatando2.txt > formatando3.txt
sed "s/\//-/g" formatando3.txt >formatando4.txt
sed "s/Dec/12/g" formatando4.txt >formatando5.txt

#fazendo import final para o mysql
mysql -u user -p siteminder -e "LOAD DATA LOCAL INFILE '/vms/log/formatando5.txt'
INTO TABLE sitemlog
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(auth, authtype, server, olddatas,tempo, agent, sessao, uid, app, ip, url, mehod);"

#Atualizando o campo date
mysql -u user -p siteminder -e "UPDATE sitemlog set datas='$DATE_MY' WHERE olddatas='$DATA_MY'"

#removendo arquivos temoprarios
rm *.txt
