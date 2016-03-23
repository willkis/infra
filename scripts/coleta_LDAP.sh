#!/bin/bash
param=$1

# We received a parameter?
[ -z $param ] && {
        echo "Wrong usage."
        echo
        echo "We need a file with the matriculas, one by line, to be verified."
        echo
        echo "Correct usage is: $0 matriculasfile"
        echo
        exit 1
}

# The parameter is a file?
[ -f $param ] || {
        echo "$param is not a file ..."
        exit 2
}

for matricula in `cat $param`;do
        ldapsearch -h 10.170.52.23 -D "uid=itim, ou=Special Users,dc=tim,dc=com,dc=br" -s SUB -w '!t!mb!ru3s3' -p 389 -b "ou=people,dc=tim,dc=com,dc=br" -s sub "uid=$matricula" uid statusflag  | egrep "uid|statusflag" | paste - - - >> will.txt 
done

cat resultado.txt | cut -d : -f 3,4 |awk '{print $1,$3}' > rsultadofinal.txt
