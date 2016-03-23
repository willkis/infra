######################################################
#	Script de Saneamento base PCS e Aplicação							#
#															#
#	Data de criacao: 27/05/2015										#
#															#
#															#
#															#
#	Criado por:  Willian Kis											#
######################################################

#VARIAVEIS
DATA=`date +%d%m%Y_05 `

#Script para rodar Search nas aplicacoes e transferir localmente

#ASP
cd /app/home/wasadmin/scripts/app/ASP
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsasp@10.112.110.106 "/pcsasp/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"ASP\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcsasp@10.112.110.106:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/ASP
cat SEARCH_RESULT.txt |cut -d "|" -f3 > ASP.txt

#BDOH 
cd /app/home/wasadmin/scripts/app/BDOH
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsbdoh@10.1.9.28 "/interfaces/bdoh/adapter/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"BDOH\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcsbdoh@10.1.9.28:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/BDOH
cat SEARCH_RESULT.txt |cut -d "|" -f3 > BDOH.txt

#CBCF
cd /app/home/wasadmin/scripts/app/CBCF
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcscbcf@10.168.24.46 "/appl/pcscbcf/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"CBCF\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcscbcf@10.168.24.46:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/CBCF
cat SEARCH_RESULT.txt |cut -d "|" -f3 > CBCF.txt

#ClarifyVN
cd /app/home/wasadmin/scripts/app/CLARIFYVN
rm *
scp -i /app/home/wasadmin/.ssh/script_rsa pcsvend@10.112.53.21:~/SEARCH_RESULT_$DATA* /app/home/wasadmin/scripts/app/CLARIFYVN
cat SEARCH_RESULT_$DATA* |cut -d "|" -f3 > CLARIFYVN.txt


#P2B
cd /app/home/wasadmin/scripts/app/P2B
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsp2b@10.168.57.171 "/appl/pcsp2b/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"P2B\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcsp2b@10.168.57.171:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/P2B
cat SEARCH_RESULT.txt |cut -d "|" -f3 > P2B.txt

#SIAC
cd /app/home/wasadmin/scripts/app/SIAC
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcssiac@10.168.24.40 "/appl/pcssiac/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"SIAC\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcssiac@10.168.24.40:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/SIAC
cat SEARCH_RESULT.txt |cut -d "|" -f3 > SIAC.txt

#SIEBELPRE
cd /app/home/wasadmin/scripts/app/SIEBEL
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcssiebe@10.168.236.33 "/export/home/pcssiebe/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"SIEBEL\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcssiebe@10.168.236.33:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/SIEBELPRE
cat SEARCH_RESULT.txt |cut -d "|" -f3 > SIEBELPRE.txt

#SIEBELPOS
cd /app/home/wasadmin/scripts/app/SIEBELPOS
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcssiebe@10.168.236.179 "/u01/siebel/pcssiebe/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"SIEBELPOS\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcssiebe@10.168.236.179:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/SIEBELPOS
cat SEARCH_RESULT.txt |cut -d "|" -f3 > SIEBELPOS.txt

#SISJUR
cd /app/home/wasadmin/scripts/app/SISJUR
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsisjur@10.168.54.161 "/appl/pcsisjur/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"SISJUR\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcsisjur@10.168.54.161:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/SISJUR
cat SEARCH_RESULT.txt |cut -d "|" -f3 > SISJUR.txt

#KPI
cd /app/home/wasadmin/scripts/app/KPI
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcskpi@10.168.105.41 "/appl/pcskpi/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"KPI\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcskpi@10.168.105.41:~/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/KPI
cat SEARCH_RESULT.txt |cut -d "|" -f3 > KPI.txt

#PDV_Live
cd /app/home/wasadmin/scripts/app/PDV_LIVE/
rm *
#ssh -i /app/home/wasadmin/.ssh/script_rsa pcspdvcl@10.168.114.90 "/appl/adapter/live/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"PDV_LIVE\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcspdvcl@10.168.114.90:/appl/adapter/live/search/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PDV_LIVE/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PDV_LIVE.txt

#PDV_Mgmt
cd /app/home/wasadmin/scripts/app/PDV_MGMT/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcspdvcm@10.168.114.90 "/appl/adapter/live/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcspdvcm@10.168.114.90:/appl/adapter/mgmt/search/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PDV_MGMT/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PDV_MGMT.txt

#PDV_GL
cd /app/home/wasadmin/scripts/app/PDV_GL/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcspdvgl@10.168.224.97 "/appl/pcspdvgl/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"PDVGL\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcspdvgl@10.168.224.97:/appl/pcspdvgl/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PDV_GL/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PDV_GL.txt

#PDVGN
cd /app/home/wasadmin/scripts/app/PDVGN/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcspdvgn@10.168.105.124 "/appl/adapter/pcspdvgn/ADAPTER.sh \"\\\\\\\"SEARCH\\\\\\\"\\\\\\\"PDVGN\\\\\\\"\\\\\\\"\\\\\\\"\""
scp -i /app/home/wasadmin/.ssh/script_rsa pcspdvgn@10.168.105.124:/appl/adapter/pcspdvgn/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PDVGN/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PDVGN.txt

#PROTOCOLOS
cd /app/home/wasadmin/scripts/app/PROTOCOLOS/
rm *
scp -i /app/home/wasadmin/.ssh/script_rsa pcsproto@10.168.51.81:/home/pcsproto/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PROTOCOLOS/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PROTOCOLOS.txt

#TIMFILAS
cd /app/home/wasadmin/scripts/app/TIMFILAS/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsfilas@10.168.24.40 "/appl/pcsfilas/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsfilas@10.168.24.40:/appl/pcsfilas/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/TIMFILAS/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > TIMFILAS.txt

#PLOGISTICA
cd /app/home/wasadmin/scripts/app/PLOGISTICA/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcslogis@10.168.29.20 "/appl/pcslogis/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcslogis@10.168.29.20:/appl/pcslogis/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PLOGISTICA/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PLOGISTICA.txt

#ICRC
cd /app/home/wasadmin/scripts/app/ICRC/
rm *
#ssh -i /app/home/wasadmin/.ssh/script_rsa pcsicrc@10.168.110.92 "/appl/pcs/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsicrc@10.168.110.92:/appl/pcs/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/ICRC/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > ICRC.txt

#FELETRONICAPG
cd /app/home/wasadmin/scripts/app/FELETRONICAPG/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsfepg@10.168.224.24 "/fatura/ebilling/pcsfepg/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsfepg@10.168.224.24:/fatura/ebilling/pcsfepg/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/FELETRONICAPG/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > FELETRONICAPG.txt

#FELETRONICA
cd /app/home/wasadmin/scripts/app/FELETRONICA/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsfecsr@10.168.224.24 "/fatura/ebilling/pcsfecsr/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsfecsr@10.168.224.24:/fatura/ebilling/pcsfecsr/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/FELETRONICA/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > FELETRONICA.txt

#VCE
cd /app/home/wasadmin/scripts/app/VCE/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsvce@10.168.34.147 "/vce/pcsvce/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsvce@10.168.34.147:/vce/pcsvce/vce-adapter/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/VCE/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > VCE.txt

#UCM
cd /app/home/wasadmin/scripts/app/UCM/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsucm@10.168.236.68 "/u01/siebel/pcsucm/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsucm@10.168.236.68:/u01/siebel/pcsucm/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/UCM/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > UCM.txt

#SFA
cd /app/home/wasadmin/scripts/app/SFA/
rm *
#ssh -i /app/home/wasadmin/.ssh/script_rsa pcssfa@10.168.220.136 "/appl/pcssfa/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcssfa@10.168.220.136:/appl/pcssfa/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/SFA/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > SFA.txt

#VERO
cd /app/home/wasadmin/scripts/app/VERO/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsvero@10.168.220.136 "/appl/pcsvero/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsvero@10.168.220.136:/appl/pcsvero/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/VERO/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > VERO.txt

#SALES
cd /app/home/wasadmin/scripts/app/SALES/
rm *
#ssh -i /app/home/wasadmin/.ssh/script_rsa pcssales@10.1.9.28 "/interfaces/sales/adapter/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcssales@10.1.9.28:/interfaces/sales/adapter/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/SALES/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > SALES.txt

#GFA
cd /app/home/wasadmin/scripts/app/GFA/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsgfa@10.168.24.40 "/appl/pcsgfa/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsgfa@10.168.24.40:/appl/pcsgfa/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/GFA/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > GFA.txt

#INTEGRA
cd /app/home/wasadmin/scripts/app/INTEGRA/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsinteg@10.160.3.126 "/adapter/integra/pcs_rbac/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsinteg@10.160.3.126:/adapter/integra/pcs_rbac/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/INTEGRA/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > INTEGRA.txt

#PORTALPARCELAMENTO
cd /app/home/wasadmin/scripts/app/PORTALPARCELAMENTO/
rm *
ssh -i /app/home/wasadmin/.ssh/script_rsa pcsparqa@10.161.3.90 "/appl/pcsparqa/search.sh"
scp -i /app/home/wasadmin/.ssh/script_rsa pcsparqa@10.161.3.90:/appl/pcsparqa/SEARCH_RESULT.txt /app/home/wasadmin/scripts/app/PORTALPARCELAMENTO/
cat SEARCH_RESULT.txt |cut -d "|" -f3 > PORTALPARCELAMENTO.txt

#Declarando variavel para pesquisa de ldap
APP="ASP BDOH CBCF CLARIFYVN P2B SIAC SIEBEL SIEBELPOS SISJUR KPI PDV_LIVE PDV_MGMT PDV_GL PDVGN PROTOCOLOS TIMFILAS PLOGISTICA ICRC FELETRONICAPG FELETRONICA VCE UCM SFA VERO SALES GFA INTEGRA PORTALPARCELAMENTO"

#Laco para pesquisa em cada app
for ANSWER in ${APP[*]}
do
cd /app/home/wasadmin/scripts/app/$ANSWER
#LDAP para consulta de todas as usuários ativos no aplicação
ldapsearch -h 10.170.57.23 -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br" -b "ou=people,dc=tim,dc=com,dc=br" "(&(statusflag=Active)(Applrole=$ANSWER))" uid > BIRU.tmp
cat BIRU.tmp | grep uid: | awk '{print $2}' | sort > BIRU_ATIVO.txt
ldapsearch -h 10.170.57.23 -w '!t!mb!ru3s3' -D uid="itim, ou=Special Users,dc=tim,dc=com,dc=br" -b "ou=people,dc=tim,dc=com,dc=br" "(&(statusflag=Active)(disabledApplrole=$ANSWER))" uid > BIRU_DESATIVO.tmp
cat BIRU_DESATIVO.tmp | grep uid: | awk '{print $2}' | sort > BIRU_DESATIVO.txt
sed -e ':a' -e 'N;$!ba' -e 's/\n/ /g'  BIRU_ATIVO.txt> BIRU_ATIVO_VAR.txt
sed -e ':a' -e 'N;$!ba' -e 's/\n/ /g'  BIRU_DESATIVO.txt> BIRU_DESATIVO_VAR.txt
k1=$(cat BIRU_DESATIVO_VAR.txt)
k2=$(cat BIRU_ATIVO_VAR.txt)
k="$k1"
w="$k2"
        for ANSWER1 in ${k[*]} ; do
                cat  SEARCH_RESULT.*| grep $ANSWER1 >> $ANSWER.Desativados_no_BIRU_e_Ativos_na_app.txt
				
        done
			for ANSWER2 in ${w[*]} ; do
				/usr/sfw/bin/ggrep -q $ANSWER2 SEARCH_RESULT.* && echo 'found' > found.tmp || echo $ANSWER2 >> $ANSWER.Ativos_no_BIRU_e_Desativos_na_app.tmp
				cat $ANSWER.Ativos_no_BIRU_e_Desativos_na_app.tmp | cut -d "|" -f2 > $ANSWER.Ativos_no_BIRU_e_Desativos_na_app.txt		
            done
rm *.tmp		
done