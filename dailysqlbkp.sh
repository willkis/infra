#!/bin/bash

DATE=`date +%Y%m%d`
DATE_OLD=`date +%Y%m%d -d "1 days ago" `
DATE_OLD1=`date +%Y%m%d -d "2 days ago" `
MYSQL=`which mysqldump`
BKPDIR=/srv/backup/
LS=`which ls`
RM=`which rm`
TAR=`which tar`
EMAIL_FROM="infra@inmov.net"
EMAIL_TO="willkis@gmail.com"
SERVIDOR_SMTP="127.0.0.1:25" 

# Function to send e-mail

function Envia_email(){
sendEmail -f $EMAIL_FROM -t $EMAIL_TO -u "Daily Backup" -m "$MENSAGEM" -s $SERVIDOR_SMTP -xu $EMAIL_FROM -xp 123456
}

#changing to directory /srv/backup
cd "$BKPDIR"

#Execute the dumpfile
DUMP=`$MYSQL -h 127.0.0.1 -u root --all-databases --skip-lock-tables > larsMaracanau-$DATE.sql`

	if [ $? -eq 0 ]; then
	MENSAGEM="O Backup está ok"
	Envia_email
	 else
	 MENSAGEM="Backup falhou!"
	 Envia_email
	fi

#Making the tar file
$TAR -cvf larsMaracanau-$DATE.tgz larsMaracanau-$DATE.sql 

#Checkin dump integrity
DUMPATUAL=`$LS -l larsMaracanau-$DATE.tgz |awk '{print $5}'`
DUMP_OLD=`$LS -l larsMaracanau-$DATE_OLD.tgz |awk '{print $5}'`

	if [ $DUMPATUAL -lt $DUMP_OLD ]; then
	MENSAGEM="BKP novo menor que BKP antigo favor checar"
	Envia_email
	 else
	 MENSAGEM="BKP OK"
	 Envia_email
	fi

#Deleting old dump and sql file
$RM larsMaracanau-$DATE_OLD1.tgz
$RM larsMaracanau-$DATE.sql
