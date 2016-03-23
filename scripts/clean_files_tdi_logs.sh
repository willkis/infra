#!/bin/bash

################## Desenvolvido ####################
# Desenvolvido pela equipe IT Security EXPRIVIA    #
#     Bruno Amado e Rafael Campos- 04/2014         #
####################################################

export datescript=`date +%Y%m%d`

cd /app/solutions_RSL_logs/

atual=/app/solutions_RSL_logs/

bkp=/app/ITDI_backup_logs/

########## Utilização ###################################################
# Script desenvolvido para realizar a limpeza nos diretorios de Logs    #
# TDI, e após compactar os arquivos em pasta de BKP                     #
#########################################################################

#### Verifica a data dos arquivos das aplicações com mais de 2 meses e move para diretorio BKP####

cd /app/solutions_RSL_logs/

find $atual/* -mtime +60 -name "KPI_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_KPI*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "BCPORTAL_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_BCPORTAL*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "CBCF_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_CBCF*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "CLARIFYVN_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_CLARIFYVN*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "DSF_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_DSF*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "FOX_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_FOX*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "ICRC_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_ICRC*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "PDV_LIVE_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_PDV_LIVE*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "PDV_MGMT_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_PDV_MGMT*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "PDVGL_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_PDVGL*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "PDVGN_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_PDVGN*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "PROTOCOLOS_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_PROTOCOLOS*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "TIMFILAS_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_TIMFILAS*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "VCE_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_VCE*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "PLOGISTICA_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_PLOGISTICA*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "FELETRONICAPG_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_FELETRONICAPG*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "FELETRONICA_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_FELETRONICA*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "UCM_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_UCM*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "SFA_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_SFA*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "SIEBEL_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_SIEBEL*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "ASP_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_ASP*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "VERO_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_VERO*" -exec mv {} $bkp/ \;

find $atual/* -mtime +60 -name "BDOH_ExecuteCli.log.*" -exec mv {} $bkp/ \; 
find $atual/* -mtime +60 -name "EH_ITIM_BDOH*" -exec mv {} $bkp/ \;

#########Ir no diretorio de BKP
cd $bkp


#########Executar a compactação de cada log de cada aplicação

#KPI
tar -cvf logs-KPI_fino.al.$datescript.tar KPI_ExecuteCli.log.* EH_ITIM_KPI* && gzip -9 logs-KPI_fino.al.$datescript.tar

#BCPORTAL
tar -cvf logs-BCPORTAL_fino.al.$datescript.tar BCPORTAL_ExecuteCli.log.* EH_ITIM_BCPORTAL* && gzip -9 logs-BCPORTAL_fino.al.$datescript.tar

#CBCF
tar -cvf logs-CBCF_fino.al.$datescript.tar CBCF_ExecuteCli.log.* EH_ITIM_CBCF* && gzip -9 logs-CBCF_fino.al.$datescript.tar

#CLARIFYVN
tar -cvf logs-CLARIFYVN_fino.al.$datescript.tar CLARIFYVN_ExecuteCli.log.* EH_ITIM_CLARIFYVN* && gzip -9 logs-CLARIFYVN_fino.al.$datescript.tar

#DSF
tar -cvf logs-DSF_fino.al.$datescript.tar DSF_ExecuteCli.log.* EH_ITIM_DSF* && gzip -9 logs-DSF_fino.al.$datescript.tar

#FOX
tar -cvf logs-FOX_fino.al.$datescript.tar FOX_ExecuteCli.log.* EH_ITIM_FOX* && gzip -9 logs-FOX_fino.al.$datescript.tar

#ICRC
tar -cvf logs-ICRC_fino.al.$datescript.tar ICRC_ExecuteCli.log.* EH_ITIM_ICRC* && gzip -9 logs-ICRC_fino.al.$datescript.tar

#P2B
tar -cvf logs-P2B_fino.al.$datescript.tar P2B_ExecuteCli.log.* EH_ITIM_P2B* && gzip -9 logs-P2B_fino.al.$datescript.tar

#PDV_LIVE
tar -cvf logs-PDV_LIVE_fino.al.$datescript.tar PDV_LIVE_ExecuteCli.log.* EH_ITIM_PDV_LIVE* && gzip -9 logs-PDV_LIVE_fino.al.$datescript.tar

#PDV_MGMT
tar -cvf logs-PDV_MGMT_fino.al.$datescript.tar PDV_MGMT_ExecuteCli.log.* EH_ITIM_PDV_MGMT* && gzip -9 logs-PDV_MGMT_fino.al.$datescript.tar

#PDVGL
tar -cvf logs-PDVGL_fino.al.$datescript.tar PDVGL_ExecuteCli.log.* EH_ITIM_PDVGL* && gzip -9 logs-PDVGL_fino.al.$datescript.tar

#PDVGN
tar -cvf logs-PDVGN_fino.al.$datescript.tar PDVGN_ExecuteCli.log.* EH_ITIM_PDVGN* && gzip -9 logs-PDVGN_fino.al.$datescript.tar

#PROTOCOLOS
tar -cvf logs-PROTOCOLOS_fino.al.$datescript.tar PROTOCOLOS_ExecuteCli.log.* EH_ITIM_PROTOCOLOS* && gzip -9 logs-PROTOCOLOS_fino.al.$datescript.tar

#TIMFILAS
tar -cvf logs-TIMFILAS_fino.al.$datescript.tar TIMFILAS_ExecuteCli.log.* EH_ITIM_TIMFILAS* && gzip -9 logs-TIMFILAS_fino.al.$datescript.tar

#VCE
tar -cvf logs-VCE_fino.al.$datescript.tar VCE_ExecuteCli.log.* EH_ITIM_VCE* && gzip -9 logs-VCE_fino.al.$datescript.tar

#PLOGISTICA
tar -cvf logs-PLOGISTICA_fino.al.$datescript.tar RPLOGISTICA_ExecuteCli.log.* EH_ITIM_PLOGISTICA* && gzip -9 logs-PLOGISTICA_fino.al.$datescript.tar

#FELETRONICAPG
tar -cvf logs-FELETRONICAPG_fino.al.$datescript.tar FELETRONICAPG_ExecuteCli.log.* EH_ITIM_FELETRONICAPG* && gzip -9 logs-FELETRONICAPG_fino.al.$datescript.tar

#FELETRONICA
tar -cvf logs-FELETRONICA_fino.al.$datescript.tar FELETRONICA_ExecuteCli.log.* EH_ITIM_FELETRONICA* && gzip -9 logs-FELETRONICA_fino.al.$datescript.tar

#UCM
tar -cvf logs-UCM_fino.al.$datescript.tar RUCM_ExecuteCli.log.* EH_ITIM_UCM* && gzip -9 logs-UCM_fino.al.$datescript.tar

#SFA
tar -cvf logs-SFA_fino.al.$datescript.tar SFA_ExecuteCli.log.* EH_ITIM_SFA* && gzip -9 logs-SFA_fino.al.$datescript.tar

#SIEBEL
tar -cvf logs-SIEBEL_fino.al.$datescript.tar SIEBEL_ExecuteCli.log.* EH_ITIM_SIEBEL* && gzip -9 logs-SIEBEL_fino.al.$datescript.tar

#ASP
tar -cvf logs-ASP_fino.al.$datescript.tar ASP_ExecuteCli.log.* EH_ITIM_ASP* && gzip -9 logs-ASP_fino.al.$datescript.tar

#VERO
tar -cvf logs-VERO_fino.al.$datescript.tar VERO_ExecuteCli.log.* EH_ITIM_VERO* && gzip -9 logs-VERO_fino.al.$datescript.tar

#BDOH
tar -cvf logs-BDOH_fino.al.$datescript.tar BDOH_ExecuteCli.log.* EH_ITIM_BDOH* && gzip -9 logs-BDOH_fino.al.$datescript.tar


#### Após exclui da pasta os .LOG ####
cd $bkp

rm -r *.log.*