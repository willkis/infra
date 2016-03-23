#!/bin/bash

################## Desenvolvido ####################
# Desenvolvido pela equipe IT Security EXPRIVIA    #
#     Bruno Amado e Rafael Campos- 04/2014         #
####################################################

export datescript=`date +%Y%m%d`

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/

#SAPEXT
sapextlog=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/ExtSap/SapLog
sapextbkp=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/ExtSap/SapBackup

#SAPINT
sapintlog=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/IntSap/SapLog
sapintbkp=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/IntSap/SapBackup

#MASSIVE
massivelog=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/MassiveImport/MassiveLog
massivebkp=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/MassiveImport/MassiveBackup

#INACTIVATION
inactivelog=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Inactivation/InactivationLog
inactivebkp=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Inactivation/InactivationBackup

#SANEAMENTO45
san45log=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Saneamento45/Saneamento45Log
san45bkp=/app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Saneamento45/Saneamento45Backup

#BACKUP
bkp=/app/ITDI_backup_logs/

########## Utilização ###################################################
# Script desenvolvido para realizar a limpeza nos diretorios de Logs    #
# ALS, e após compactar os arquivos em pasta de BKP                     #
#########################################################################

#### Verifica a data dos arquivos das aplicações com mais de 1 mes e move para diretorio BKP####

#####SAPEXT#####

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/ExtSap/SapLog

find $sapextlog/* -mtime +30 -name "SapExt.log.*" -exec mv {} $bkp/ \; 
find $sapextlog/* -mtime +30 -name "Itera.log.*" -exec mv {} $bkp/ \;
find $sapextlog/* -mtime +30 -name "Timer.log.*" -exec mv {} $bkp/ \;

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/ExtSap/SapBackup
find $sapextbkp/* -mtime +30 -name "*.csv" -exec mv {} $bkp/ \;

cd $bkp

#SAPEXT
tar -cvf logs-SAPEXT_fino.al.$datescript.tar SapExt.log.* Itera.log.* Timer.log.* *.csv && gzip -9 logs-SAPEXT_fino.al.$datescript.tar

#####SAPINT#####

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/IntSap/SapLog

find $sapintlog/* -mtime +30 -name "AcquiIntSap.log.*" -exec mv {} $bkp/ \; 
find $sapintlog/* -mtime +30 -name "Itera.log.*" -exec mv {} $bkp/ \;
find $sapintlog/* -mtime +30 -name "Timer.log.*" -exec mv {} $bkp/ \;

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/IntSap/SapBackup
find $sapintbkp/* -mtime +30 -name "*.csv" -exec mv {} $bkp/ \;

cd $bkp

#SAPINT
tar -cvf logs-SAPINT_fino.al.$datescript.tar AcquiIntSap.log.* Itera.log.* Timer.log.* *.csv && gzip -9 logs-SAPINT_fino.al.$datescript.tar

#####MASSIVE#####

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/MassiveImport/MassiveLog

find $massivelog/* -mtime +30 -name "Massive.log.*" -exec mv {} $bkp/ \; 
find $massivelog/* -mtime +30 -name "ReadSkippedEntryFolder_Massive.log.*" -exec mv {} $bkp/ \;
find $massivelog/* -mtime +30 -name "ReadSkippedEntryFile_Massive.log.*" -exec mv {} $bkp/ \;
find $massivelog/* -mtime +30 -name "Timer.log.*" -exec mv {} $bkp/ \;
find $massivelog/* -mtime +30 -name "Itera.log.*" -exec mv {} $bkp/ \;

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/MassiveImport/MassiveBackup
find $massivebkp/* -mtime +30 -name "*.csv" -exec mv {} $bkp/ \;
find $massivebkp/* -mtime +30 -name "*.CSV" -exec mv {} $bkp/ \;

cd $bkp

#MASSIVE
tar -cvf logs-MASSIVE_fino.al.$datescript.tar Massive.log.* ReadSkippedEntryFolder_Massive.log.* ReadSkippedEntryFile_Massive.log.* Timer.log.* Itera.log.* *.csv *.CSV && gzip -9 logs-MASSIVE_fino.al.$datescript.tar


#####INACTIVATION#####

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Inactivation/InactivationLog

find $inactivelog/* -mtime +30 -name "Inactivation.log.*" -exec mv {} $bkp/ \; 
find $inactivelog/* -mtime +30 -name "ReadSkippedEntryFile_Inactivation.log.*" -exec mv {} $bkp/ \;
find $inactivelog/* -mtime +30 -name "Timer.log.*" -exec mv {} $bkp/ \;
find $inactivelog/* -mtime +30 -name "Itera.log.*" -exec mv {} $bkp/ \;
find $inactivelog/* -mtime +30 -name "SkippedFolder.log.*" -exec mv {} $bkp/ \;


cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Inactivation/InactivationBackup
find $inactivebkp/* -mtime +30 -name "*.csv" -exec mv {} $bkp/ \;
find $inactivebkp/* -mtime +30 -name "*.CSV" -exec mv {} $bkp/ \;

cd $bkp

#INACTIVE
tar -cvf logs-INACTIVATION_fino.al.$datescript.tar Inactivation.log.* ReadSkippedEntryFile_Inactivation.log.* Timer.log.* Itera.log.* SkippedFolder.log.* *.csv *.CSV && gzip -9 logs-INACTIVATION_fino.al.$datescript.tar

#####SANEAMENTO45#####

cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Saneamento45/Saneamento45Log

find $san45log/* -mtime +30 -name "Saneamento45.log.*" -exec mv {} $bkp/ \; 
find $san45log/* -mtime +30 -name "ReadSkippedEntryFile_Saneamento.log.*" -exec mv {} $bkp/ \;
find $san45log/* -mtime +30 -name "Timer.log.*" -exec mv {} $bkp/ \;
find $san45log/* -mtime +30 -name "Itera.log.*" -exec mv {} $bkp/ \;
find $san45log/* -mtime +30 -name "ReadSkippedEntryFolder_Saneamento.log.*" -exec mv {} $bkp/ \;


cd /app/IBM/IBMDirectoryIntegrator/solutions/BatchProcess/Saneamento45/Saneamento45Backup
find $san45bkp/* -mtime +30 -name "*.csv" -exec mv {} $bkp/ \;
find $san45bkp/* -mtime +30 -name "*.CSV" -exec mv {} $bkp/ \;

cd $bkp

#SANEAMENTO45
tar -cvf logs-SANEAMENTO45_fino.al.$datescript.tar Saneamento45.log.* ReadSkippedEntryFile_Saneamento.log.* Timer.log.* Itera.log.* ReadSkippedEntryFolder_Saneamento.log.* *.csv *.CSV && gzip -9 logs-SANEAMENTO45_fino.al.$datescript.tar


#### Após exclui da pasta os .LOG e csv ####
cd $bkp

rm -r *.log.*
rm -r *.csv
rm -r *.CSV 