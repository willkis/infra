#!/bin/bash

./scripts.lib

SIM=`text_color green; echo -n SIM;text_color white`
NAO=`text_color red; echo -n NAO;text_color white`

CKBK=$(ps -ef | grep boks | wc -l)
CKBRIDGE=$(ps -ef |grep boks_bridge |wc -l)
CKBKSINIT=$(ps -ef |grep boks_init |wc -l)
CKDRAINMAST=$(ps -ef |grep boks_drainmast |wc -l)
CKEVENT=$(ps -ef |grep boks_eventd |wc -l)
CKBKCRON=$(ps -ef |grep boks_cron |wc -l)
CKBKSHTTP=$(ps -ef |grep httpsrv | wc -l)
CKNKSSERV=$(ps -ef |grep boks_servc | wc -l)
CKBKSXD=$(ps -ef |grep boks_xd | wc -l)
CKBKSM=$(ps -ef |grep boks_master| wc -l)
CKBKSHOST=$(ps -ef |grep boks_host | wc -l)
CKBKSD=$(ps -ef |grep boks_bksd | wc -l)
CKACED=$(ps -ef |grep boks_aced | wc -l)
CKAUTHD=$(ps -ef |grep boks_authd | wc -l)
CKCPSSD=$(ps -ef |grep boks_csspd | wc -l)
CKUDSQD=$(ps -ef |grep boks_udsqd | wc -l)
CKCACHED=$(ps -ef |grep boks_cached | wc -l)
CKCLNTD=$(ps -ef |grep boks_clntd | wc -l)
CKHOSTLOOKUP=$(ps -ef |grep boks_hostlookupd | wc -l)
CKAUTOREGISTRED=$(ps -ef |grep boks_hostlookupd | wc -l)

echo "##################VERIFICANDO BOKS Todos os processos################################"
  if [ $CKBK -lt 33 ]; then
   echo "###BOKS OK?    $NAO###"
   echo ""
  else
   echo "###BOKS OK?    $SIM###"
   echo ""
fi

#Verificando processos separadamente
  if [ $CKBRIDGE -lt 13 ]; then
   echo "###BRIDGE OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKBKSINIT -lt 2 ]; then
   echo "###INIT OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKDRAINMAST -lt 4 ]; then
   echo "###DRAINMAST OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKBKCRON -lt 2 ]; then
   echo "###CRON OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKBKSHTTP -lt 3 ]; then
   echo "###HTTP OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKBKSXD -lt 5 ]; then
   echo "###SERVICE OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKBKSM -lt 2 ]; then
   echo "###MASTER OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKBKSHOST -lt 2 ]; then
   echo "###HOST OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKACED -lt 2 ]; then
   echo "###ACED OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKAUTHD -lt 2 ]; then
   echo "###AUTHD OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKCPSSD -lt 2 ]; then
   echo "###AUTHD OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKCACHED -lt 2 ]; then
   echo "###CACHE OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKCLNTD -lt 2 ]; then
   echo "###CLNTD OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKHOSTLOOKUP -lt 2 ]; then
   echo "###HOSTLOOKUP OK?  $NAO, FAVOR VERIFICAR###"
  fi

  if [ $CKAUTOREGISTRED -lt 2 ]; then
   echo "###AUTOREGISTRED OK?  $NAO, FAVOR VERIFICAR###"
  fi
