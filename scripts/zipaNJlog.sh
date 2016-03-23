#!/bin/bash
# Menu Shell

CURYR=$(date +%Y)

DIR=/app/home/db2itim/NJT_Brazil/Extractor/logs

cd $DIR


menu ()
{
a="ok"

while true $a !="ok"
do
   echo "ZIP de logs NJRBrazil_Listener e NJRBrazil_Cleaner"
   echo "Escolha o mes que gostaria de compactar"
   echo ""
   echo "1 - Janeiro"
   echo "2 - Fevereiro"
   echo "3 - Marco"
   echo "4 - Abril"
   echo "5 - Maio"
   echo "6 - Junho"
   echo "7 - Julho"
   echo "8 - Agosto"
   echo "9 - Setembro"
   echo "10 - Outubro"
   echo "11 - Novembro"
   echo "12 - Dezembro"
   echo "13 - ELIMINAR logs com mais de 3 meses"
   echo ""
   echo "OBS. pressione 'ctrl+c' p/ sair do script"
   echo ""
   echo "Digite a opcao desejada: "
   read a
   case $a in
   1)tar -cvf NJT_Extractor_$CURYR.01.tar NJT_Extractor_$CURYR.01* ; mv NJT_Extractor_$CURYR.01.tar $DIR/bkp_logs/$CURYR;;
   2)tar -cvf NJT_Extractor_$CURYR.02.tar NJT_Extractor_$CURYR.02* ; mv NJT_Extractor_$CURYR.02.tar $DIR/bkp_logs/$CURYR;;
   3)tar -cvf NJT_Extractor_$CURYR.03.tar NJT_Extractor_$CURYR.03* ; mv NJT_Extractor_$CURYR.03.tar $DIR/bkp_logs/$CURYR;;
   4)tar -cvf NJT_Extractor_$CURYR.04.tar NJT_Extractor_$CURYR.04* ; mv NJT_Extractor_$CURYR.04.tar $DIR/bkp_logs/$CURYR;;
   5)tar -cvf NJT_Extractor_$CURYR.05.tar NJT_Extractor_$CURYR.05* ; mv NJT_Extractor_$CURYR.05.tar $DIR/bkp_logs/$CURYR;;
   6)tar -cvf NJT_Extractor_$CURYR.06.tar NJT_Extractor_$CURYR.06* ; mv NJT_Extractor_$CURYR.06.tar $DIR/bkp_logs/$CURYR;;
   7)tar -cvf NJT_Extractor_$CURYR.07.tar NJT_Extractor_$CURYR.07* ; mv NJT_Extractor_$CURYR.07.tar $DIR/bkp_logs/$CURYR;;
   8)tar -cvf NJT_Extractor_$CURYR.08.tar NJT_Extractor_$CURYR.08* ; mv NJT_Extractor_$CURYR.08.tar $DIR/bkp_logs/$CURYR;;
   9)tar -cvf NJT_Extractor_$CURYR.09.tar NJT_Extractor_$CURYR.09* ; mv NJT_Extractor_$CURYR.09.tar $DIR/bkp_logs/$CURYR;;
   10)tar -cvf NJT_Extractor_$CURYR.10.tar NJT_Extractor_$CURYR.10*; mv NJT_Extractor_$CURYR.10.tar $DIR/bkp_logs/$CURYR;;
   11)tar -cvf NJT_Extractor_$CURYR.11.tar NJT_Extractor_$CURYR.11*; mv NJT_Extractor_$CURYR.11.tar $DIR/bkp_logs/$CURYR;;
   12)tar -cvf NJT_Extractor_$CURYR.12.tar NJT_Extractor_$CURYR.12*; mv NJT_Extractor_$CURYR.12.tar $DIR/bkp_logs/$CURYR;;
   13)find $DIR/* -mtime +91 -name "*.log" -exec rm {}  \;;;
   esac
done
}

menu