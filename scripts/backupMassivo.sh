#!/bin/bash

cont=127

while true;
do
  valor=$((86400*$cont*-1))
  datescript=`./calcdate.pl $valor`
  echo $datescript
  /app/scripts/backupSGI.sh $datescript
  let cont++
  if [ $cont -gt 149 ]; then
    break
  fi
done