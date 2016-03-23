#!/bin/bash
DATA=$(date +%Y%m%d)
ONTEM=`TZ=GMT+24 date +%Y%m%d`

#coletando os usuarios inativos por aplicacao no san45

cd /app/gos/bin/san45/logs
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep DSF |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1| cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.DSF.txt 
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep VENDITA |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.VENDITA.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep PROTOCOLOS |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.PROTOCOLOS.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep SGR |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.SGR.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep PDV_LIVE |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.PDV_LIVE.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep PDV_MGMT |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.PDV_MGMT.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep RAP |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.RAP.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep SCTR-PORTAL |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.SCTR-PORTAL.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep IPVS |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.IPVS.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep KPI |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.KPI.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep TIMFILAS |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.TIMFILAS.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep GVAS |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.GVAS.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep CBCF |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.CBCF.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep GJMC |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.GJMC.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep BCPORTAL |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.BCPORTAL.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep GCPP |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.GCPP.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep PDVGL |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.PDVGL.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep PDVGN |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.PDVGN.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep VCE |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.VCE.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep PLOGISTICA |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.PLOGISTICA.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep BISEMANTICO |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.BISEMANTICO.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep IUNICA |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.IUNICA.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep ICRC |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.ICRC.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep FELETRONICA |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.FELETRONICA.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep FELETRONICAPG |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.FELETRONICAPG.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep UCM |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.UCM.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep SIEBEL |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.SIEBEL.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep VERO |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.VERO.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep SFA |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.SFA.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep ASP |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.ASP.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep SALES |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.SALES.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep BDOH |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.BDOH.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep P2B |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.P2B.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep GCOB |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.GCOB.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep GEOWEB |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.GEOWEB.txt
cat "$DATA"_saneamento_removal_result.log |grep MATR |grep DTH |awk '{print $3 $4}' | cut -d ":" -f 2 | cut -d "," -f 1 >~/relatorio/san45/$DATA.DTH.txt

#coletando os logs da intaivacao sap
cd /app/gos/massive/output
cat INATIVOS_"$ONTEM"*|cut -d";" -f6 >~/relatorio/sap/$ONTEM.sap.txt
