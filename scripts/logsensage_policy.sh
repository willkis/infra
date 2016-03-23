#!/usr/bin/bash

# Concatenates the last smacesslogs from several servers for the final convertion.

LOGSDIR='/app/sm6.0/siteminder/backup'
LASTCMD="ls $LOGSDIR/*smaccess.log.gz|tail -1"
SERVERS='10.170.36.24 10.170.36.25 10.170.36.26'
RUSER='pcsopn3'

TMPDIR='/app/reports/logmanagement'
FINALDIR='/app/reports/logmanagement/out'

MATRIZ=$SERVERS

touch $TMPDIR/arq0
gzip $TMPDIR/arq0

echo 'downloading and concatenating remote log files'

#declare -p MATRIZ
#        for ANSWER in ${MATRIZ[*]}
        for ANSWER in ${SERVERS[*]}
        do
        LASTONE=`ssh $RUSER@$ANSWER $LASTCMD`
        scp $RUSER@$ANSWER:$LASTONE $TMPDIR/ 
                ARCHIVE=`echo $LASTONE|cut -d / -f 6`
                gzcat $TMPDIR/arq0.gz $TMPDIR/$ARCHIVE | gzip > $TMPDIR/tmp.gz
                mv $TMPDIR/tmp.gz $TMPDIR/arq0.gz
        done

# Concatenates the local smaccesslog with the servers one

echo 'concatenating local file with downloaded ones'
 
LASTLOCAL=`ls $LOGSDIR/*smaccess.log.gz|tail -1`
gzcat $TMPDIR/arq0.gz $LASTLOCAL | gzip > $TMPDIR/tmp.gz
mv $TMPDIR/tmp.gz $TMPDIR/arq0_final.gz 
rm $TMPDIR/arq0.gz

# generates the serial for the final output file 

SERIAL=`echo $LASTONE | cut -d / -f 6 |cut -c 1-14`

# removes the residual file from the download loop

TMPFILE=`echo $LASTONE | cut -d / -f 6`
rm $TMPDIR/$TMPFILE

echo 'converting concatenated files to the SOX format' 

# "Convert" the last smaccess on backup to the SOX format

gzcat $TMPDIR/arq0_final.gz |/usr/xpg4/bin/awk 'BEGIN { FS = "[ ,=\[\"]" } ; 
# DSF
# Autenticacao aceita
/International/ && /AuthAccept/ && /\[0\]/ {
	print "0061C|" $2 "|" $4 "|DSF|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
	} ;
# Autenticacao recusada
/International/ && /AuthReject/ && /\[0\]/ {
	print "006TS|" $2 "|" $4 "|DSF|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
	} ;
# Bloqueio por inatividade
/International/ && /AuthReject/ && /\[25\]/ {
	print "015BC|" $2 "|" $4 "|DSF|" $9 "|" $7 "|Bloqueio de conta por inatividade";
	} ;
# Logout 
/International\/Logout/ && /AzAccept/ {
	print "0060C|" $2 "|" $4 "|DSF|" $9 "|" $7 "|Fim de sessao do usuario";
	} ;

# Disabled since the boks script already has this information
# Boks
# Autenticacao aceita
#/boksagent/ && /AuthAccept/ && /\[0\]/ {
#	print "0061C|" $2 "|" $4 "|BOKS|" $9 "|" $7;
#	} ;
# Autenticacao recusada
#/boksagent/ && /AuthReject/ && /\[0\]/ {
#	Print "006TS|" $2 "|" $4 "|BOKS|" $9 "|" $7;
#	} ;
# Bloqueio por inatividade
#/boksagent/ && /AuthReject/ && /\[25\]/ {
#	print "015BC|" $2 "|" $4 "|BOKS|" $9 "|" $7;
#	} ;
# RAP
# Autenticacao aceita
/rap/ && /AuthAccept/ && /\[0\]/ {
	print "0061C|" $2 "|" $4 "|RAP|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
	} ;
# Autenticacao recusada
/rap/ && /AuthReject/ && /\[0\]/ {
	print "006TS|" $2 "|" $4 "|RAP|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
	} ;
# Bloqueio por inatividade
/rap/ && /AuthReject/ && /\[25\]/ {
	print "015BC|" $2 "|" $4 "|RAP|" $9 "|" $7 "|Bloqueio de conta por inatividade";
	} ;

# SCTR 
# Autenticacao aceita
/sctr/ && /AuthAccept/ && /\[0\]/ {
	print "0061C|" $2 "|" $4 "|SCTR|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
	} ;
# Autenticacao recusada
/sctr/ && /AuthReject/ && /\[0\]/ {
	print "006TS|" $2 "|" $4 "|SCTR|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
	} ;
# Bloqueio por inatividade
/sctr/ && /AuthReject/ && /\[25\]/ {
	print "015BC|" $2 "|" $4 "|SCTR|" $9 "|" $7 "|Bloqueio de conta por inatividade";
	} ;

#PDV_01 e 02
/pdv live/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|PDV LIVE|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/pdv live/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|PDV LIVE|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/pdv live/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|PDV LIVE|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;

#mgmt
/mgmt/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|PDV MGMT|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/mgmt/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|PDV MGMT|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/mgmt/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|PDV MGMT|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;
		
#protocolos externo
/protocolos_ext_1/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|PROTOCOLOS EXTERNO|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/protocolos_ext_1/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|PROTOCOLOS EXTERNO|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/protocolos_ext_1/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|PROTOCOLOS EXTERNO|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;		
		
#protocolos interno
/protocolos_int_1/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|PROTOCOLOS INTERNO|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/protocolos_int_1/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|PROTOCOLOS INTERNO|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/protocolos_int_1/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|PROTOCOLOS INTERNO|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;				


# Vendita
# Autenticacao aceita
/clarifyvn_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|Vendita|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/clarifyvn_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|Vendita|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/clarifyvn_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|Vendita|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;



# KPI
# Autenticacao aceita
/kpi_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|KPI|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/kpi_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|KPI|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/kpi_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|KPI|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ; 



# P2B
# Autenticacao aceita
/p2b_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|P2B|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/p2b_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|P2B|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/p2b_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|P2B|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;

# CBCF
# Autenticacao aceita
/cbcf-/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|CBCF|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/cbcf-/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|CBCF|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/cbcf-/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|CBCF|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# PAC Portal
# Autenticacao aceita
/pac_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|PAC Portal|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/pac_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|PAC Portal|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/pac_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|PAC Portal|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# SGR
# Autenticacao aceita
/sgr_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|SGR|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/sgr_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|SGR|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/sgr_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|SGR|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# Tim Filas
# Autenticacao aceita
/timfilas_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|Tim Filas|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/timfilas_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|Tim Filas|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/timfilas_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|Tim Filas|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;
		
		
# IPVS
# Autenticacao aceita
/ipvs_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|IPVS|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/ipvs_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|IPVS|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/ipvs_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|IPVS|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;		
		
# CONNECTRA
# Autenticacao aceita
/connectra_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|CONNECTRA|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/connectra_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|CONNECTRA|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/connectra_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|CONNECTRA|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;		
PORTAL
# Autenticacao aceita
/bcportal_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|BCPORTAL|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/bcportal_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|BCPORTAL|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/bcportal_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|BCPORTAL|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# GCPP
# Autenticacao aceita
/gcpp_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|GCPP|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/gcpp_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|GCPP|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/gcpp_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|GCPP|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# GJMC
# Autenticacao aceita
/gjmc_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|GJMC|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/gjmc_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|GJMC|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/gjmc_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|GJMC|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# GOL
# Autenticacao aceita
/gol_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|GOL|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/gol_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|GOL|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/gol_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|GOL|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# GVAS
# Autenticacao aceita
/gvas_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|GVAS|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/gvas_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|GVAS|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/gvas_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|GVAS|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;


# PLOGISTICA
# Autenticacao aceita
/plogistica_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|PLOGISTICA|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/plogistica_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|PLOGISTICA|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/plogistica_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|PLOGISTICA|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;
		
# IUNICA
# Autenticacao aceita
/iunica_/ && /AuthAccept/ && /\[0\]/ {
        print "0061C|" $2 "|" $4 "|IUNICA|" $9 "|" $7 "|Tentativa de Autenticacao com Sucesso";
        } ;
# Autenticacao recusada
/iunica_/ && /AuthReject/ && /\[0\]/ {
        print "006TS|" $2 "|" $4 "|IUNICA|" $9 "|" $7 "|Tentativa de Autenticao sem Sucesso";
        } ;
# Bloqueio por inatividade
/iunica_/ && /AuthReject/ && /\[25\]/ {
        print "015BC|" $2 "|" $4 "|IUNICA|" $9 "|" $7 "|Bloqueio de conta por inatividade";
        } ;		


# Change Password
# Troca de senha sem sucesso
/Ch_Pwd/ && /AuthReject/ && /\[21\]/ {
	print "014AS|" $2 "|" $4 "|PCS|" $9 "|" $7 "|Alteracao de senha sem sucesso";
	} ;
# Troca de senha sem sucesso digitou senha errada
/Ch_Pwd/ && /AuthReject/ && /\[22\]/ {
	print "014AS|" $2 "|" $4 "|PCS|" $9 "|" $7 "|Alteracao de senha sem sucesso";
	} ;
# Troca de senha com sucesso
/Ch_Pwd/ && /AuthAccept/ && /\[23\]/ {
	print "014AC|" $2 "|" $4 "|PCS|" $9 "|" $7 "|Alteracao de senha com sucesso";
	} ;
# Bloqueio por tentativas erradas
# ManagementCommand snesun332 [20/Oct/2008:01:09:16 -0300] "- SiteMinder" ChangeDisabledUserState 'uid=T3020003,ou=people,dc=tim,dc=com,dc=br'
/ManagementCommand/ && /ChangeDisabledUserState/ {
	print "002BC|" $2 "|" $4 "|PCS|" $12 "|" $7 "|Bloqueio de conta devido a numero excessivo de tentativas de autenticacao sem sucesso";
	}' | gzip > $FINALDIR\/$SERIAL\smacesslog_concat.GZ

# Remove Arquivo concatenado arq0_final.gz
rm $TMPDIR/arq0_final.gz

echo 'ALL DONE!'
