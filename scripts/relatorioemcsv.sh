#!/bin/bash

cd /tmp

#Consultando LDAP para busca de usuarios
ldapsearch -h 10.170.52.21 -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br" -b "ou=people,dc=tim,dc=com,dc=br" '(&(statusflag=a
ctive)(certificateserialnumber=*))' uid scSerialNumber dateExpiration > /tmp/gcsm.txt

#Fazendo a limpeza do Arquivo:
sed '/dn/ d' gcsm.txt >> gcsm1.txt

#Declarando variaves
TOTAL=$(cat gcsm1.txt | grep uid: |wc -l)
USER=$(cat gcsm1.txt |grep uid | awk '{print $2}' >> alluser.txt)
SERIALNUM=$(cat gcsm1.txt |grep scSerialNumber |awk '{print $2}' >> allserial.txt)
EXPIRATION=$(cat gcsm1.txt |grep dateExpiration |awk '{print $2}'>> allexpiration.txt)

#preparando colunas

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA;$lineB;" >>formatando1.txt
done <alluser.txt 3<allserial.txt


while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA$lineB" >>formatando2.txt
done <formatando1.txt 3<allexpiration.txt

#criando o arquivo .csv e adicionando as linhas
touch relatorio.csv

echo "User;Serial_Number;Data-de-expiracao" >>relatorio.csv

cat formatando2.txt >>relatorio.csv

#removendo arquivos de formatacao e gcsm

#rm gcsm.txt gcsm1.txt all* formatando*