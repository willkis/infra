#!/usr/bin/perl

################################################################
# Script que recebe como parâmetro a quantidade 			#
# de segundos que deve ser somada ou subtraída			#
# do horário atual para cálculo de tempo.				#
# Retorna o resultado da conta no formato dd/mm/yyyy hh:mm:ss	#
################################################################ 

#############################
# Tabela de Conversão	#
#				#
# day = 86400			#
# month = 2678400		#
# year = 31622400		#
# hour = 3600			#
# minute = 60			#
# second = 1			#
#				#
#############################


$qtde=@ARGV[0];

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time + $qtde);

$year=$year+1900;

$mon=$mon+1;

if($mon<10)
{$mon="0$mon";}

if($mday<10)
{$mday="0$mday";}

if($hour<10)
{$hour="0$hour";}

if($min<10)
{$min="0$min";}

if($sec<10)
{$sec="0$sec";}

print "$year$mon$mday";