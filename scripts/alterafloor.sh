#!/bin/bash
#Coleta informa\347\365es de APPs ativas no BIRU
ldapsearch -h 10.170.52.24 -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br" -b "ou=people,dc=tim,dc=com,dc=br" '(&(statusFlag=Active)(orgunit=04004663))' uid > temp1;

#Prepara arquivo de BLOCO LDAP
cat temp1 |grep dn > temp2
cat temp2 |
while read i
do
        # Monta arquivo forn_ldap PARA AS ALTERACOES
        echo $i >> temp_ldap
        echo "changetype: modify" >> temp_ldap
        echo "replace: floor" >> temp_ldap
        echo "floor: CHT" >> temp_ldap
#       sed '$!N;s/\n/ /g'
        echo "" >> temp_ldap

done

#Alterando no BIRU
ldapmodify -h 10.170.52.24 -f temp_ldap -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br"
clear;