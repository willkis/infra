#!/bin/bash
# Script de captura de log do dia por usuario / agent
user=$1
[ -z $user ] && {
	echo "Uso correto eh passar um usuario por parametro"
	echo "$0 matricula"
	exit 1
}
analisa() {
	grep -i "$user" /app/sm6.0/siteminder/log/smaccess.log
for policy in 10.170.36.24 10.170.36.25 10.170.36.26 10.170.36.36 10.170.36.37 10.170.36.54 10.170.36.57 10.170.53.23; do
#	for policy in 10.170.36.24 10.170.36.25 10.170.36.26 10.170.36.36 10.170.36.54 10.170.36.57; do
	#for policy in 10.170.36.24 10.170.36.25 10.170.36.26 10.170.36.36 10.170.36.37 10.170.36.54 10.170.36.57; do
	#for policy in 10.170.36.24 10.170.36.25 10.170.36.26 10.170.36.36 10.170.36.37; do
		ssh pcsopn3@$policy grep -i "$user" /app/sm6.0/siteminder/log/smaccess.log
	done
} 

analisa | sort -t[ -k6
