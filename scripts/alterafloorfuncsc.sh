#!/bin/bash
#Script para a correcao do import sap 
#Criado por Willian Kis 
DATA=$(date +%Y%m%d)
HORA=$(date +%H%M%S)

#Criando um diretorio temporario para efetuar a correcao do arquivo
mkdir -p /app/reports/gos/in/tmp/importsapfunc/

#Entrando no diretorio e encontrando o arquivo que precisa ser mudado
cd /app/reports/gos/in

ARQ=$(ls -lt | grep SAP_FUNC | awk '{print($9)}' |head -1)

qtde=`ls -lt SAP_FUNC* | head -2 | awk '{print($9)}' | wc -l | awk '{print($1)}'` 

if [ "$qtde" == "0" ]
then


  echo "Existe apenas um arquivo no diretorio"
else

#movendo aruivo para área temporária para efetuar as modificacoes
mv $ARQ /app/reports/gos/in/tmp/importsapfunc/

cd /app/reports/gos/in/tmp/importsapfunc/

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
cat formatando.txt |grep F > func.txt

cat func.txt |grep scSerialNumber=0 >funcionarios.txt

#Tratando arquivos para arquivo final

cat funcionarios.txt |cut -d , -f 1 > funcionarios1.txt

cat  funcionarios1.txt | cut -d = -f 2 > funcionariofinal.txt

cat terceiros.txt |cut -d , -f 1 > terceiros1.txt

sed -e 's/F/0/g' funcionariofinal.txt > funcionariofinal1.txt

#seds para preparar o sed
sed '2,999999s/^/\|/g' funcionariofinal1.txt >> funcionariofinal2.txt
perl -e 'while(<>){chomp;print "$_"}' funcionariofinal2.txt>> funcionariofinal3.txt


TROCA=$(cat funcionariofinal3.txt)

#cat para criar o arquivo final
cat $ARQ | egrep "$TROCA" > prefunc.txt
cat $ARQ | egrep -v -e "$TROCA" > SAP_FUNC_$DATA\_$HORA.CSV
perl -i -p -e 's/"PW"/"SC"/g;' prefunc.txt
cat prefunc.txt >> SAP_FUNC_$DATA\_$HORA.CSV

mv SAP_FUNC_$DATA\_$HORA.CSV /app/reports/gos/in/

bash /app/scripts/importsapfunc.sh

cd

rm -R /app/reports/gos/in/tmp/importsapfunc/

fi