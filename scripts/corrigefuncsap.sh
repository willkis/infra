#!/bin/bash
#script de correcao de usuarios no import sap
#Criado por Willian Kis data 05/02/2014

cd /export/home/pcsopn3/tmp

#LDAP search com os usuarios com floor PW e srial number diferente de null jogando em um arquivo para tratamento
ldapsearch -h 10.170.52.23 -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br" -b "ou=people,dc=tim,dc=com,dc=br" -s sub "(&(statusflag=active)(floor=PW)(certificateserialnumber=*))" dn scSerialNumber | egrep 'uid|scSerialNumber|floor' > funcsap.txt

cat funcsap.txt | cut -d , -f 1 > funcsap1.txt

cat funcsap1.txt | cut -d , -f1 >funcsap2.txt

cat funcsap2.txt |egrep 'F|T' > funcsap3.txt

cat funcsap.txt | cut -d , -f 1,2 > funcsapserial.txt

cat funcsapserial.txt | grep scSerialNumber > funcsapserial1.txt

#Criando um arquivo concatenado 

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA,$lineB," >>formatando.txt
done <funcsap3.txt 3<funcsapserial1.txt

cat formatando.txt |grep scSerialNumber=0 >formatando1.txt

cat formatando1.txt |cut -d , -f 1 > formatando2.txt

cat  formatando2.txt | cut -d = -f 2 > sapfuncfinal.csv
mv sapfuncfinal.csv /export/home/pcsopn3/scripts

rm *.txt