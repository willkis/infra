#!/bin/bash

#### Search user Day
# perquserrece.ksh

#VARIABLES
data=`date +%Y%m%d_%H%M%S`

userer=`cat /app/home/pcsopn3/scripts/newstatus/TmpUserER.txt`

cat /app/sm6.0/siteminder/log/smaccess.log | tail -1000 | grep -i $user1 > search_user_rece_$data.txt