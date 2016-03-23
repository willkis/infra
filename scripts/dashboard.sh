#!/bin/bash

DATA=$(date +%Y%m%d)
#Diretorios
ATIVO='/app/reports/cruscotto/ativos-aplicacao/'
TK='/app/reports/cruscotto/status/tk/'
PW='/app/reports/cruscotto/status/pw/'
SC='/app/reports/cruscotto/status/sc/'
SAN='/app/reports/cruscotto/saneamento/'
INAT='/app/reports/cruscotto/inativacao/'

#Movendo csv de aplicacoes ativas e saindo para um dir tmp

cd /app/reports/sgi/sent 

cp *.csv $ATIVO

cd /tmp

#Efetuando o search e movendo resultado para o dir TK
ldapsearch -h 10.170.50.51 -p 1389 -D cn=root -w ToOr#sCp -b "ou=people,erglobalid=00000000000000000000,ou=TIM,O=TIVOLI" -s sub "(&(floor=TK)(statusflag=Active))" employeenumber  | grep employeenumber |grep '{print $2}' > /$TK/$DATA-active_func_TK.txt

#Efetuando o search e movendo resultado para o dir PW
ldapsearch -h 10.170.50.51 -p 1389 -D cn=root -w ToOr#sCp -b "ou=people,erglobalid=00000000000000000000,ou=TIM,O=TIVOLI" -s sub "(&(floor=PW)(statusflag=Active))" employeenumber  | grep employeenumber |awk '{print $2}' > /$PW/$DATA-active_func_PW.txt

#Efetuando o search e movendo resultado para o dir SC
ldapsearch -h 10.170.50.51 -p 1389 -D cn=root -w ToOr#sCp -b "ou=people,erglobalid=00000000000000000000,ou=TIM,O=TIVOLI" -s sub "(&(floor=SC)(statusflag=Active))" employeenumber  | grep employeenumber |awk '{print $2}'> /$SC/$DATA-active_func_SC.txt


#copiando arquivo com logs do sanemaneto 45
scp pcsopn3@snesun356:~/relatorios/$DATAsan45.txt $SAN

#inativacao SAP
scp pcsopn3@snesun356:~/relatorios/$DATAsap.txt $INAT



