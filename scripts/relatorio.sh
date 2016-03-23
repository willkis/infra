#!/bin/bash

ONTEM=`TZ=GMT+24 date +%Y%m%d`
ANO=`date +%Y`

#pegando as informacoes para a pesquisa

c="ok"
echo "Digite a matricula exemplo: T3333333"
read c
clear

d="ok"
echo "Digite uma data no formato AAMMDD Ex: 20130908"
read d
clear

e="ok"
echo "Digite qual agent vc quer pesquisar Ex: asp_int_1 ou asp_int_*"
read e
clear

f="ok"
echo "Digite a hora inicial no formato 00 exemplo: 13"
read f
clear
f1=$(echo "$f"|cut -c1)
f2=$(echo "$f"|cut -c2)

h="ok"
echo "digite o minuto"
read h
clear
h1=$(echo "$h"|cut -c1)
h2=$(echo "$h"|cut -c2)

g="ok"

echo "digite a hora final no formato 00 exemplo: 23"
read g
clear
g1=$(echo "$g"|cut -c1)
g2=$(echo "$g"|cut -c2)

i="ok"
echo "digite o minuto"
read i
clear
i1=$(echo "$i"|cut -c1)
i2=$(echo "$i"|cut -c2)

#Efetuando grep inicial separando a matricula e a aplicação solicitada e jogando em um arquivo temporario. O if e para saber qual log pesquisar
echo "Processando arquivo temporario..."
 if [ $d == $ONTEM ]; then
   cd /app/reports/logmanagement/out; gzcat "$d"smacesslog_full.GZ |grep $e |grep $c >/tmp/relatorio.log; 
   else
   cd /app/reports/logmanagement/sent; gzcat "$d"smacesslog_full.GZ |grep $e |grep $c >/tmp/relatorio.log; 
   fi
clear
#Fazendo o grep com o range de horas solicitadas. 
#ha 2 ifs (um simples e um composto) para poder fazer separacao se for utilizar datas antes das 09 e depois das 09 e se precisar pegar um relatorio de periodo menor a uma hora.   
echo "Extraindo relatorio"  
if [ $f == $g ]; then
 	cat /tmp/relatorio.log |egrep "$ANO:$g:($h1[$h2-60])|$ANO:$g:($i1[$i2-60])" >~/relatorio.txt;
	else
	
 if [ $f == 00 ]; then 
	if [ $g <= 09 ]; then
	cat /tmp/relatorio.log |egrep "$ANO:(0[0-$g2])|$ANO:(0[0-$g2])" >~/relatorio.txt;
	else
	cat /tmp/relatorio.log |egrep "$ANO:(0[0-9])|$ANO:($g1[$g2-9])" >~/relatorio.txt;
	fi

 else
   cat /tmp/relatorio.log |egrep "$ANO:($f1[$f2-9])|$ANO:($g1[$g2-9])" >~/relatorio.txt;
 fi
 
 fi
 
 
 rm /tmp/relatorio.log

 echo "Relatorio completo. para visualiza-lo acesse o arquivo  /app/home/pcsopn3/relatorio.txt"