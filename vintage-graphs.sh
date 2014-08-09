#!/bin/sh

RRD="/home/da/apcupsd-rrd/apcupsd.rrd"
WEB="/var/www/htdocs/power/"
COLOR="-c BACK#5b7470 -c CANVAS#ac6e31 -c SHADEA#d8cd95 -c SHADEB#d8cd95 -c GRID#ad9a8c -c MGRID#5b7470 -c FONT#ad9a8c"

rrdtool graph linev.png DEF:voltage=${RRD}:linev:AVERAGE LINE1:voltage#911c2f:"Voltage" $COLOR --disable-rrdtool-tag HRULE:230#5B7470:""
mv linev.png ${WEB} 

rrdtool graph loadpct.png DEF:loadpct=${RRD}:loadpct:AVERAGE LINE1:loadpct#00ff00:"Load (%)" DEF:bcharge=${RRD}:bcharge:AVERAGE LINE2:bcharge#0000ff:"Battery charge (%)" $COLOR --disable-rrdtool-tag -u 100 -l 0
mv loadpct.png ${WEB} 

#rrdtool graph bcharge.png DEF:bcharge=${RRD}:bcharge:AVERAGE LINE1:bcharge#00ff00:"Battery charge (%)" $COLOR --disable-rrdtool-tag
#mv bcharge.png ${WEB}

rrdtool graph timeleft.png DEF:timeleft=${RRD}:timeleft:AVERAGE LINE1:timeleft#00ff00:"Run time remaining (minutes)" $COLOR --disable-rrdtool-tag
mv timeleft.png ${WEB}

