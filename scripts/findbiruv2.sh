#!/bin/bash

########################################################################################################################
#                                                                                                                                       #
# Script que retorna as seguintes informações LOGIN, NOME, MATRICULA, DATA DE CRIAÇÃO, DATA DE ÚLTIMO LOGIN,            #
# PERFIL E STATUS dos usuários associados a uma aplicação que será informada como parâmetro.                            #
# O Script realizar um LDAP Search na base do BIRU e retornará as informações desejadas                                 #
# O nome da aplicação que será informado como parâmetro deverá ser idêntico ao utilizado na estrutura da aplicação no   #
# BIRU, ou=APLICAÇÃO-X,ou=aplications,dc=tim,dc=com,dc=br                                                                       #
#                                                                                                                                       #
########################################################################################################################
#                                                               #
# Willian Kis - Projeto PCS              #
# 28/008/2015                                                    #
#
#                                                               #
#########################################################

####################################################################################################################

ldapuser="uid=pcsop,ou=Special Users,dc=tim,dc=com,dc=br"
ldappassword=ldappcsop08
peoplebranch="ou=people,dc=tim,dc=com,dc=br"
applicationsbranch="ou=applications,dc=tim,dc=com,dc=br"
serverip=10.170.57.24
serverport=1389
datescript=`date +%Y%m%d`
exportdir=/app/reports/sgi/out
datelog=`date "+%d/%m/%Y %H:%M:%S"`
####################################################################################################################
cd /app/scripts/findca

touch /app/scripts/javaUsersSGI/log/usersSGI_$datescript.log
echo "iniciando" >> /app/scripts/javaUsersSGI/log/usersSGI_$datescript.log

aplicacao=$(cat aplicacao.txt)

APP=$aplicacao

IFSOrig=$IFS

IFS=$'\n'

if [ ! -d $exportdir ]
then
  mkdir $exportdir
fi

####################################################################################################################

for ANSWER in ${APP[*]}
do

ldapsearch -B -D "$ldapuser" -b "ou=$ANSWER,$applicationsbranch" -s SUB -h $serverip  -p $serverport -w $ldappassword \(statusFlag=Active\) uid profile statusFlag activationDate lastLogonDate >> resulttemp.txt



cat resulttemp.txt |grep ",ou" |cut -d "," -f1 |cut -d"=" -f2 >> login.tmp

cat resulttemp.txt | grep activationDate |cut -d"=" -f2 | cut -d" " -f1 | sed 's/NULL//g;' >> activationDate.tmp

cat resulttemp.txt |grep profile | cut -d"=" -f2 >> profile.tmp

for linha in `cat resulttemp.txt |grep lastLogonDate | cut -d "=" -f 2 | sed 's/NULL//g;'`
do
  lastlogondate=`echo $linha | cut -d";" -f5 | sed 's/NULL//g;'`
    lastlogondate="${lastlogondate:6:2}/${lastlogondate:4:2}/${lastlogondate:0:4}"
        echo $lastlogondate >> lastlogondate.tmp
done;

for linha1 in `cat login.tmp`
do
  nome=`ldapsearch -B -D "$ldapuser" -b "$peoplebranch" -s SUB -h $serverip -p $serverport -w $ldappassword \(uid=$linha1\) cn |
  sed '/dc=com,dc=br$/d;s/^cn=//;'`
  echo $nome >> nome.tmp
done;


#preparando colunas

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA;$lineB;$lineA;" >>formatando1.tmp
done <login.tmp 3<nome.tmp


while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA$lineB;" >>formatando2.tmp
done <formatando1.tmp 3<activationDate.tmp

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA$lineB;" >>formatando3.tmp
done <formatando2.tmp 3<lastlogondate.tmp

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA$lineB;1" >>PCS$ANSWER\_USER_$datescript.csv
done <formatando3.tmp 3<profile.tmp

### Gerando Log########################
qtde=$(cat PCS$ANSWER\_USER_$datescript.csv | wc -l)
echo "$datelog|INFO|PCS"$ANSWER"_USER_$datescript.csv Total de Logins: $qtde" >>/app/scripts/javaUsersSGI/log/usersSGI_$datescript.log
####################################################################################################################

rm resulttemp.txt *.tmp
done;

mv PCSCLARIFYVN_USER_$datescript.csv PCSCLARIFY_USER_$datescript.csv

mv *.csv $exportdir
echo "$datelog|INFO|finalizado" >>/app/scripts/javaUsersSGI/log/usersSGI_$datescript.log
IFS=$FSOrig

