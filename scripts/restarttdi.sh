#!/bin/bash

#Nome Dos Projetos
SAPINT='/app/IBM/IBMDirectoryIntegrator/solutions/workspace/SAPInt/Runtime-SAPInt/SAPInt.xml'
SAPEXT='/app/IBM/IBMDirectoryIntegrator/solutions/workspace/SAPExt/Runtime-SAPExt/SAPExt.xml'
MASSIV='/app/IBM/IBMDirectoryIntegrator/solutions/workspace/Massive/Runtime-Massive/Massive.xml'
INAC='/app/IBM/IBMDirectoryIntegrator/solutions/workspace/Inactivation/Runtime-Inactivation/Inactivation.xml'
SAN45='/app/IBM/IBMDirectoryIntegrator/solutions/workspace/Saneamento45/Runtime-Saneamento45/Saneamento45.xml'
SAPCLEAN='/app/IBM/IBMDirectoryIntegrator/solutions/workspace/SAPCleanup/Runtime-SAPCleanup/SAPCleanup.xml'

#Nome Dos AssemblyLines
SAPINTIMER='SAPIntReconciliation_Timer'
SAPEXTIMER='SAPExtReconciliation_Timer'
MASSIVTIMER='MassiveImport_Timer'
INACTIMER='Inactivation_Timer'
SAN45TIMER='Saneamento45_Timer'
SAPCLEANTIMER='Deactivate_Timer'

function menu_stop() { menu ()
{
b="ok"

while true $b !="ok"
do
  echo "Escolha o servico que deseja parar"
   echo ""
   echo "1 - SAP Interno"
   echo "2 - SAP Externo"
   echo "3 - Massive Import"
   echo "4 - Inativation"
   echo "5 - Saneamento45"
   echo "6 - SAP Cleanup"
   echo "7 - Todos os servicos"
   echo "8 - Voltar ao menu anterior"
   echo ""
   echo "OBS. pressione 'ctrl+c' p/ sair do script"
   echo ""
   read b
   case $b in
   1)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPINT;clear;;
   2)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPEXT;clear;;
   3)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $MASSIV;clear;;
   4)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $INAC;clear;;
   5)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAN45;clear;;
   6)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c $SAPCLEAN;clear;;
   7)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPINT ;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPEXT;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $MASSIV;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $INAC;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAN45;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c $SAPCLEAN;clear;;
   8)clear;menu_principal;;

   esac
done
}

menu
}

function menu_start() { menu ()
{
b="ok"

while true $b !="ok"
do
  echo "Escolha o servico que deseja iniciar"
   echo ""
   echo "1 - SAP Interno"
   echo "2 - SAP Externo"
   echo "3 - Massive Import"
   echo "4 - Inactivation"
   echo "5 - Saneamento45"
   echo "6 - SAP Cleanup"
   echo "7 - Todos os servicos"
   echo "8 - Voltar ao menu anterior"
   echo ""
   echo "OBS. pressione 'ctrl+c' p/ sair do script"
   echo ""
   read b
   case $b in
   1)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPINT  -r $SAPINTIMER;clear;;
   2)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPEXT -r $SAPEXTIMER;clear;;
   3)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $MASSIV -r $MASSIVTIMER;clear;;
   4)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $INAC -r $INACTIMER;clear;;
   5)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAN45 -r $SAN45TIMER;clear;;
   6)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c $SAPCLEAN -r $SAPCLEANTIMER;clear;;
   7)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPINT  -r $SAPINTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPEXT -r $SAPEXTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $MASSIV -r $MASSIVTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $INAC -r $INACTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAN45 -r $SAN45TIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c $SAPCLEAN -r $SAPCLEANTIMER;clear;;
   8)clear;menu_principal;;

   esac
done
}

menu
}

function menu_restart() { menu ()
{
c="ok"

while true $c !="ok"
do
  echo "Escolha o servico que deseja reiniciar"
   echo ""
   echo "1 - SAP Interno"
   echo "2 - SAP Externo"
   echo "3 - Massive Import"
   echo "4 - Inactivation"
   echo "5 - Saneamento45"
   echo "6 - SAP Cleanup"
   echo "7 - Todos os Servicos"
   echo "8 - Voltar ao menu anterior"
   echo ""
   echo "OBS. pressione 'ctrl+c' p/ sair do script"
   echo ""
   read c
   case $c in
   1)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPINT;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPINT  -r $SAPINTIMER;clear;;
   2)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPEXT;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPEXT -r $SAPEXTIMER;clear;;
   3)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $MASSIV;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $MASSIV -r $MASSIVTIMER;clear;;
   4)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $INAC;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $INAC -r $INACTIMER;clear;;
   5)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAN45;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAN45 -r $SAN45TIMER;clear;;
   6)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c $SAPCLEAN;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c $SAPCLEAN -r $SAPCLEANTIMER;clear;;
   7)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPINT ;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAPEXT;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $MASSIV;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $INAC;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c  $SAN45;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPINT  -r $SAPINTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAPEXT -r $SAPEXTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $MASSIV -r $MASSIVTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $INAC -r $INACTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c  $SAN45 -r $SAN45TIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op stop -c $SAPCLEAN;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op start -c $SAPCLEAN -r $SAPCLEANTIMERclear;clear;;
   8)clear;menu_principal;;
   esac
done
}

menu
}

function menu_status() { menu ()
{
c="ok"

while true $c !="ok"
do
  echo "Escolha o servico que deseja visualizar o status"
   echo ""
   echo "1 - SAP Interno"
   echo "2 - SAP Externo"
   echo "3 - Massive Import"
   echo "4 - Inactivation"
   echo "5 - Saneamento45"
   echo "6 - SAP Cleanup"
   echo "7 - Todos os servicos"
   echo "8 - Voltar ao menu anterior"
   echo ""
   echo "OBS. pressione 'ctrl+c' p/ sair do script"
   echo ""
   read c
   case $c in
   1)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $SAPINT -r $SAPINTIMER ;;
   2)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $SAPEXT -r $SAPEXTIMER;;
   3)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $MASSIV -r $MASSIVTIMER;;
   4)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $INAC -r $INACTIMER;;
   5)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $SAN45 -r $SAN45TIMER;;
   6)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $SAPCLEAN1 -r $SAPCLEANTIMER;;
   7)/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c $SAPINT -r $SAPINTIMER ;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c SAPExt_v1.5 -r $SAPEXTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c Massiva_1.4.6 -r $MASSIVTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c Inactivation_v1.4.5 -r $INACTIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c Saneamento45_v1.4.4 -r $SAN45TIMER;/app/IBM/IBMDirectoryIntegrator/bin/tdisrvctl -op status -c SAPCleanup_v1.1 -r $SAPCLEANTIMER;;
   8)clear;menu_principal;;

   esac
done
}

menu
}


function menu_principal() { menu ()
{
a="ok"

while true $a !="ok"
do
   echo "Reinicio de servicos TDI"
   echo ""
   echo "1 - Stop"
   echo "2 - Start"
   echo "3 - Restart"
   echo "4 - Status"
   echo ""
   echo "OBS. pressione 'ctrl+c' p/ sair do script"
   echo ""
   echo "Digite a opcao desejada: "
   read a
   case $a in
   1)clear;menu_stop;;
   2)clear;menu_start;;
   3)clear;menu_restart;;
   4)clear;menu_status
  
   esac
done
}

menu
}


menu_principal
