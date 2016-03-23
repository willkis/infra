#!/bin/bash
##
# MySQL BACKUP SCRIPT
##
 
BANCO=siteminder
MYSQLUSER=root
#MYSQLPASS=MySQL_USER_PASSWORD
FTPUSER=FTP_USER
FTPPASS=FTP_PASSWORD
FTPHOST=FTP_HOST
FTPDIR=
BACKUPDIR=/usr/VMS/backup
 
mkdir -p $BACKUPDIR
mkdir -p $BACKUPDIR/mysql/binlog
mkdir -p $BACKUPDIR/mysql/full
 
 
function diskusage() {
MAX=80
LANG=C /bin/df -P | tr -s ' '|cut -d ' ' -f1,5 | grep -v Cap | while read line;
do
        fs=$(echo $line | cut -d ' ' -f1)
        uso=$(echo $line | cut -d ' ' -f2| cut -d '%' -f1)
        if [ $uso -gt $MAX ];
        then
                echo "$fs esta $uso% cheio, verifique"
        fi
done
}
 
function usage(){
echo $0 [ full | incremental ]
}
 
#function ftpsync(){
#   /usr/bin/lftp -e "mirror --log=/tmp/lftp.log -v -R $BACKUPDIR mysqlbackup; bye" -u ${FTPUSER},${FTPPASS} ${FTPHOST} &> /dev/null
#   [ $? -gt 0 ] && echo "LFTP ERROR: $?" && exit
#}
function logsync(){
 
   binlog="`basename $(cat /etc/mysql/my.cnf | grep '^log_bin' | cut -d '=' -f2)`"
   rsync -q -a /var/log/mysql/mariadb-bin.[0-9][0-9][0-9][0-9][0-9][0-9] $BACKUPDIR/mysql/binlog
   [ $? -gt 0 ] && echo "RSYNC ERROR: $?" && exit
   diskusage
}
 
function full(){
 
   /usr/bin/find $BACKUPDIR/mysql -type f -mtime +30 -delete
 
   FFILE="${BANCO}-backup-$(date +%Y-%m-%d_%H%M).sql.xz"
 
   /usr/bin/mysqldump -u ${MYSQLUSER} \
   --opt \
   --single-transaction \
   --no-autocommit \
   --all-databases \
   --flush-logs \
   --master-data \
   --routines | xz -2 -c - > ${BACKUPDIR}/mysql/full/${FFILE};
   [ $? -gt 0 ] && echo "MYSQLDUMP ERROR: $?" && exit
 
   logsync
   #ftpsync
 
}
 
function incremental(){
 
   /usr/bin/mysql -e 'PURGE BINARY LOGS BEFORE DATE_SUB( NOW( ), INTERVAL 15 DAY);'
   [ $? -gt 0 ] && echo "MYSQL PURGE LOG BINARY ERROR: $?" && exit
   /usr/bin/mysqladmin -u ${MYSQLUSER} flush-logs
   [ $? -gt 0 ] && echo "MYSQLADMIN flush-logs ERROR: $?" && exit
   logsync
   #ftpsync
    
}
 
 
case "$1" in
 
'full' ) full ;;
 
'incremental') incremental ;;
 
esac