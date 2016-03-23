#!/bin/bash

clear

FuncPrincipal(){

echo "Informe qual opcao deseja usar
        Consulta no log do dia todo
        Consulta apenas das entradas recentes"

echo "OPCOES
        DT - Log dia Todo
        ER - Entradas recentes
        HH - Ajuda
        XX - exit
        "

echo "Digite a opcao desejada"

read opt

case $opt in
        DT) diatodo ;;
        ER) recente ;;
        HH) hlp ;;
        XX) ext ;;
        *) "Opcao Desconhecida. Utilize uma opcao valida" ; echo ; FuncPrincipal ;;
esac
}

####################### Consulta log dia todo ##########################
diatodo (){

#VARIABLES SERVERS
server1=10.170.36.25
server2=10.170.36.26
server3=10.170.36.36
server4=10.170.36.36
server5=10.170.36.37
server6=10.170.36.54
server7=10.170.36.57
server8=10.170.53.23

echo "Consulta Dia"

        echo "Informe o usuario a consultar"

        user=$1
        read user

        echo "$user" > TmpUserDT.txt

        scp tmp.user pcsopn3@${server1}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server2}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server3}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server4}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server5}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server6}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server7}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserDT.txt pcsopn3@${server8}:/app/home/pcsopn3/scripts/newstatus

        sleep 1

        #for scrip in ${server1} ${server2} ${server3} ${server4} ${server5} ${server6} ${server7} ${server8}
        for scrip in ${server1}
        do
                ssh pcsopn3@${scrip} ./app/home/pcsopn3/scripts/newstatus/SearchDay.sh

        done
}

#################### Consulta log recente #####################

recente(){

#VARIABLES SERVERS

server1=10.170.172.22
server2=10.170.172.21
server3=10.170.36.36
server4=10.170.36.36
server5=10.170.36.37
server6=10.170.36.54
server7=10.170.36.57
server8=10.170.53.23

        echo "Consulta recente"

        echo "Informe o usuario a consultar"

        user=$1
        read user

        echo "$user" > TmpUserER.txt

        scp TmpUserER.txt pcsopn3@${server1}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server2}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server3}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server4}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server5}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server6}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server7}:/app/home/pcsopn3/scripts/newstatus
        #scp TmpUserER.txt pcsopn3@${server8}:/app/home/pcsopn3/scripts/newstatus

        sleep 1

        for scrip in ${server1} ${server2} ${server3} ${server4} ${server5} ${server6} ${server7} ${server8}
        do
                ssh pcsopn3@${scrip} ./app/home/pcsopn3/scripts/newstatus/perquserrece.ksh

        done
}

################### HELP ##################
hlp(){

     echo "Para consultas de usuario no log do dia todo utilize a opcao DT
           Para conulta de usuario nas entradas recentes do log utilize a opcao ER
           O usuario a ser consultado pode ser utilizado matricula ou nome"
}

###################### exit ##################
ext(){

     echo "Ate Breve"
     exit
}

FuncPrincipal
