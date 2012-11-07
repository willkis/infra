#!/bin/bash
### Block all traffic from AFGHANISTAN (af) and CHINA (CN). Use ISO code ###
ISO="ad ae af ag ai al am an ao ap ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo bq bs bt bw by bz ca cd cf cg ch ci ck cl cm cn co cr cs cu cv cw cy cz de dj dk dm do dz ec ee eg er es et eu fi fj fm fo fr ga gb gd ge gf gg gh gi gl gm gn gp gq gr gt gu gw gy hk hn hr ht hu id ie il im in io iq ir is it je jm jo jp ke kg kh ki km kn kp kr kw ky kz la lb lc li lk lr ls lt lu lv ly ma mc md me mf mg mh mk ml mm mn mo mp mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa pe pf pg ph pk pl pm pr ps pt pw py qa re ro rs ru rw sa sb sc sd se sg si sk sl sm sn so sr ss st sv sy sz tc td tg th tj tk tl tm tn to tr tt tv tw tz ua ug uk us uy uz va vc ve vg vi vn vu wf ws ye za zm zw"
 
### Set PATH ###
IPT=/sbin/iptables
WGET=/usr/bin/wget
EGREP=/bin/egrep
 
### No editing below ###
SPAMLIST="countrydrop"
ZONEROOT="/root/iptables"
DLROOT="http://www.ipdeny.com/ipblocks/data/countries"
 
cleanOldRules(){
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
$IPT -P INPUT ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT
}
 
# create a dir
[ ! -d $ZONEROOT ] && /bin/mkdir -p $ZONEROOT
 
# clean old rules
cleanOldRules
 
# create a new iptables list
$IPT -N $SPAMLIST
 
for c  in $ISO
do
	# local zone file
	tDB=$ZONEROOT/$c.zone
 
	# get fresh zone file
	$WGET  $tDB $DLROOT/$c.zone
 
	# country specific log message
	SPAMDROPMSG="$c Country Drop"
 
	# get 
	BADIPS=$(egrep -v "^#|^$" $tDB)
	for ipblock in $BADIPS
	do
	   $IPT -A $SPAMLIST -s $ipblock -j LOG --log-prefix "$SPAMDROPMSG"
	   $IPT -A $SPAMLIST -s $ipblock -j DROP
	done
done
 
# Drop everything 
$IPT -I INPUT -j $SPAMLIST
$IPT -I OUTPUT -j $SPAMLIST
$IPT -I FORWARD -j $SPAMLIST
 
# call your other iptable script
# /path/to/other/iptables.sh
 
exit 0
