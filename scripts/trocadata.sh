#!/bin/bash

cat data.txt |cut -d \/ -f 2 >dia.txt
cat data.txt |cut -d \/ -f 1 >mes.txt
cat data.txt |cut -d \/ -f 3 >ano.txt

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA/$lineB" >>formatando.txt
done <dia.txt 3<mes.txt

while IFS= read -r lineA && IFS= read -r lineB <&3; do
  echo "$lineA/$lineB" >>datacorrigida.txt
done <formatando.txt 3<ano.txt