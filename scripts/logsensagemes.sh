#!/usr/bin/bash

# Concatenates the last smacesslogs from several servers for the final convertion.

LOGSDIR='/app/sm6.0/siteminder/log/'
gohorse="ls smaccess_201407*.log"
LASTCMD="$gohorse"
SERVERS='10.170.36.24 10.170.36.25 10.170.36.26 10.170.36.36 10.170.36.37 10.170.53.23'
RUSER='pcsopn3'

TMPDIR='/usr/VMS'
FINALDIR='/usr/VMS/log'

MATRIZ=$SERVERS

touch $TMPDIR/arq0
#gzip $TMPDIR/arq0


                cat $TMPDIR/arq0 $TMPDIR/smaccess_201407*.log > $TMPDIR/tmp
                mv $TMPDIR/tmp $TMPDIR/arq0



# Concatenates the local smaccesslog with the servers one

echo 'concatenating local file with downloaded ones'

LASTLOCAL=`ls $LOGSDIR/smaccess_*.log`
#gzcat $TMPDIR/arq0.gz $LASTLOCAL | gzip > $TMPDIR/tmp.gz
cat $TMPDIR/arq0 $LASTLOCAL > $TMPDIR/tmp
mv $TMPDIR/tmp $TMPDIR/arq0_final
rm $TMPDIR/arq0

# generates the serial for the final output file

#SERIAL=`echo $LASTONE | cut -d / -f 6 |cut -c 1-14`
#SERIAL=`echo $LASTONE | cut -d / -f 6 |cut -c 10-17`

# removes the residual file from the download loop

#TMPFILE=`echo $LASTONE | cut -d / -f 6`
#rm $TMPDIR/$TMPFILE

echo 'converting concatenated files to the SOX format'

# "Convert" the last smaccess on backup to the SOX format

#gzcat $TMPDIR/arq0_final.gz
mv $TMPDIR/arq0_final $FINALDIR\/$SERIAL\smacesslog_full
gzip $FINALDIR\/$SERIAL\smacesslog_full
mv $FINALDIR\/$SERIAL\smacesslog_full.gz $FINALDIR\/$SERIAL\smacesslog_full.GZ


#        }' |
#               gzip > $FINALDIR\/$SERIAL\smacesslog_full.GZ

# Remove Arquivo concatenado arq0_final.gz
#rm $TMPDIR/arq0_final.gz

echo 'ALL DONE!'