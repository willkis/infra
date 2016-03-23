#!/bin/bash

#### Search user Day
#pesquserday.ksh

#VARIABLES
data=`date +%Y%m%d_%H%M%S`

userdat=`cat /app/home/pcsopn3/scripts/newstatus/TmpUserDT.txt`

grep -i $user1 /app/sm6.0/siteminder/log/smaccess.log > search_user_day_$data.txt