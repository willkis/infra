#!/bin/bash
data=`date '+%Y%m%d_%H:%M'`
cd /appl/apache/pac/conf/certificadoBiometria/sh
date
#deleta o arquivo antigo
	if test -e PCSCATIM.crl
	   then
	   rm PCSCATIM.crl
	fi
#download do certificado
wget http://pkisec.internal.timbrasil.com.br/CertEnroll/PCSCATIM.crl
		if test -e PCSCATIM.crl
		   then
			openssl crl -inform DER -in PCSCATIM.crl -outform PEM -out secPKICA.crl
			echo "Certificado convertido!"
#move o certificado para a pasta certificadoBiometria
mv /appl/apache/pac/conf/certificadoBiometria/sh/secPKICA.crl  /appl/apache/pac/conf/certificadoBiometria/crl/
#tentativa de reload no modo graceful
sudo /appl/apache/pac/bin/apachectl graceful
			if [ $? -eq 0 ]; then
				echo "Feito!"
				 date
				 echo "============================================" 
				else 
				 sudo /appl/apache/pac/bin/apachectl stop 
				 sleep 10
				 sudo /appl/apache/pac/bin/apachectl start
				 echo "Foi necessario restartar o processo"
				 date
				 echo "============================================" 
			fi
		fi
exit
################## Fim ###################
