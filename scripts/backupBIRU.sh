################################################################
# Script que faz a compacta\347\343o dos arquivos do BIRU               #
#                                                                       #
# 23/10/2012 - Ricardo Henrique Pereira                                 #
#                                                                       #
################################################################

exportDir="/app/home/pcsop/log/BIRU"

datescript=`date +%Y%m%d`

gzip -9 $exportDir/$datescript

tar -cf $exportDir/backup_$datescript.tar $exportDir/*$datescript.gz

chmod 664 $exportDir/backup_$datescript.tar

rm $exportDir/*$datescript.gz


