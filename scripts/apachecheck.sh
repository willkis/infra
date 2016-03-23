#!/bin/bash

./scripts.lib

SIM=`text_color green; echo -n SIM;text_color white`
NAO=`text_color red; echo -n NAO;text_color white`

CKAPACHE=$(ps -ef |grep /appl/apache/bin/ | wc -l)
CKAPACHE2=$(ps -ef |grep /appl/apache2/bin/ | wc -l)
CKLLWAP=$(ps -ef |grep  /appl/apache/conf/WebAgent.conf |wc -l)
CKLLWAP2=$(ps -ef |grep  /appl/apache2/conf/WebAgent.conf |wc -l)
#CHECANDO APACHE
echo "##################VERIFICANDO APACHE################################"
  if [ $CKAPACHE -lt 8 ]; then
   echo "###APACHE OK?    $NAO###"
   echo ""
  else
   echo "###APACHE OK?    $SIM###"	
   echo ""
fi

  if [ $CKLLWAP -lt 2 ]; then
   echo "###LLAWP OK?    $NAO###"
   echo "####################################################################"
   echo ""

  else
   echo "###LLAWP OK?    $SIM###"
   echo "####################################################################"
   echo ""	
fi

#CHECANDO APACHE2
echo "#################VERIFICANDO APACHE2################################"
  if [ $CKAPACHE2 -lt 8 ]; then
   echo "###APACHE OK?    $NAO###"
   echo ""
  else
   echo "###APACHE OK?    $SIM###"
   echo ""
fi

  if [ $CKLLWAP2 -lt 2 ]; then
   echo "###LLAWP OK?    $NAO###"
   echo "####################################################################"
   echo ""

  else
   echo "###LLAWP OK?    $SIM###"
   echo "####################################################################"
   echo ""
fi

