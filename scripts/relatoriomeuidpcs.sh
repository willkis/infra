#!/bin/bash
DATA=$(perl -MPOSIX=strftime -le '@t = localtime; $t[3] = 1; $t[4]--; print strftime("%Y-%m-", @t)')

SOMARS1=$(ssh pcsopn3@snesun357 "cat /var/tmp/snesun357/autosservico.out.$DATA* |grep 014RS |wc -l")
SOMARS2=$(ssh pcsopn3@snesun358 "cat /var/tmp/snesun358/autosservico.out.$DATA* |grep 014RS |wc -l")

SOMACAD1=$(ssh pcsopn3@snesun357 "cat /var/tmp/snesun357/autosservico.out.$DATA* |grep 002AC |wc -l")
SOMACAD2=$(ssh pcsopn3@snesun358 "cat /var/tmp/snesun358/autosservico.out.$DATA* |grep 002AC |wc -l")


TOTALRS=$((SOMARS1 + SOMARS2))
TOTALCAD=$((SOMACAD1 + SOMACAD2))

echo "o total de reset eh $TOTALRS"
echo "o total de cadastro eh $TOTALCAD"