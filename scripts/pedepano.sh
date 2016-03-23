#!/bin/bash
#Script para a correcao do import sap 
#Criado por Willian Kis 
DATA=$(date +%Y%m%d)
HORA=$(date +%H%M%S)

#Criando um diretorio temporario para efetuar a correcao do arquivo
mkdir -p /tmp/importsap

#Entrando no diretorio e encontrando o arquivo que precisa ser mudado
cd /app/reports/gos/in

ARQ=$(ls -lt | grep SAP_FUNC | awk '{print($9)}' |head -1)

#movendo aruivo para área temporária para efetuar as modificacoes
mv $ARQ /tmp

cd /tmp

#Efetua a consulta no LDAP e encontra as pessoas que utilizam a biometria para acessar e joga em um arquivo bruto
ldapsearch -h 10.170.52.23 -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br" -b "ou=people,dc=tim,dc=com,dc=br" -s sub "(&(statusflag=active)(certificateserialnumber=*))" dn scSerialNumber | egrep 'uid|scSerialNumber' > gcsm.txt

#Fazendo tratamento do arquivo 

cat gcsm.txt | cut -d , -f 1 > prematricula.txt

cat prematricula.txt | cut -d , -f1 >prematricula1.txt

cat prematricula1.txt |egrep 'F|T' > matricula.txt

cat gcsm.txt | cut -d , -f 1,2 > preserial.txt

cat preserial.txt | grep scSerialNumber > serial.txt

#Criando um arquivo concatenado 

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA,$lineB," >>formatando.txt
done <matricula.txt 3<serial.txt

#Separando em arquivos de funcionarios e terceiros, retirando os mesmos que não possuirem serial
cat formatando.txt |grep T > terc.txt

cat formatando.txt |grep F > func.txt

cat terc.txt |grep scSerialNumber=0 >terceiros.txt

cat func.txt |grep scSerialNumber=0 >funcionarios.txt

#Tratando arquivos para arquivo final

cat funcionarios.txt |cut -d , -f 1 > funcionarios1.txt

cat  funcionarios1.txt | cut -d = -f 2 > funcionariofinal.txt

cat terceiros.txt |cut -d , -f 1 > terceiros1.txt

cat  terceiros1.txt | cut -d = -f 2 > terceiros.txt

sed -e 's/F/0/g' funcionariofinal.txt > funcionariofinal1.txt

sed -e 's/T/0/g' terceiros.txt > terceiros1.txt

#seds para preparar o sed
sed "1s/^/\//" funcionariofinal1.txt >> funcionariofinal2.txt
sed '2,9999999999999999999s/^/\\\|/g' funcionariofinal2.txt >> funcionariofinal3.txt
sed ':a;$!N;s/\n//;ta;' funcionariofinal3.txt>> funcionariofinal4.txt
sed "s/$/\//" funcionariofinal4.txt >> funcionariofinal5.txt

TROCA=$(cat funcionariofinal5.txt)

#sed para fazer a troca no arquivo 
sed "$TROCA s/PW/SC/" $ARQ >> SAP_FUNC_$DATA\_$HORA.CSV

mv SAP_FUNC_$DATA\_$HORA.CSV /app/reports/gos/in

rm -R /tmp/importsap