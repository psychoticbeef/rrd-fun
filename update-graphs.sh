#!/bin/sh

RRD="/home/da/apcupsd-rrd/apcupsd.rrd"
WEB="/var/www/htdocs/power/"
COLOR="-c BACK#111111 -c CANVAS#000000 -c SHADEA#444444 -c SHADEB#666666 -c GRID#3c3c3c -c MGRID#732828 -c ARROW#732828 -c FONT#AC6E31"

rrdtool graph linev.png DEF:voltage=${RRD}:linev:AVERAGE LINE1:voltage#D8CD95:"Voltage" $COLOR --disable-rrdtool-tag HRULE:230#5B7470:"" -v "Volts" -x MINUTE:30:HOUR:1:HOUR:2:0:%H
mv linev.png ${WEB} 

rrdtool graph linev-7d.png DEF:voltage=${RRD}:linev:AVERAGE:end=now:start=end-1w LINE1:voltage#D8CD95:"Voltage" $COLOR --disable-rrdtool-tag HRULE:230#5B7470:"" -v "Volts" --end now --start end-1w -x HOUR:8:DAY:1:DAY:1:0:%a
mv linev-7d.png ${WEB} 

rrdtool graph loadpct.png DEF:loadpct=${RRD}:loadpct:AVERAGE LINE1:loadpct#D8CD95:"Load" DEF:bcharge=${RRD}:bcharge:AVERAGE LINE2:bcharge#942F37:"Battery charge" $COLOR --disable-rrdtool-tag -u 100 -l 0 -r -v "Percent (%)" -x MINUTE:30:HOUR:1:HOUR:2:0:%H
mv loadpct.png ${WEB}

rrdtool graph loadpct-7d.png DEF:loadpct=${RRD}:loadpct:AVERAGE LINE1:loadpct#D8CD95:"Load" DEF:bcharge=${RRD}:bcharge:AVERAGE LINE2:bcharge#942F37:"Battery charge" $COLOR --disable-rrdtool-tag -u 100 -l 0 -r -v "Percent (%)" --start end-1w -x HOUR:8:DAY:1:DAY:1:0:%a
mv loadpct-7d.png ${WEB}

rrdtool graph timeleft.png DEF:timeleft=${RRD}:timeleft:AVERAGE LINE1:timeleft#D8CD95:"Run time remaining" $COLOR --disable-rrdtool-tag -v "Minutes" -x MINUTE:30:HOUR:1:HOUR:2:0:%H
mv timeleft.png ${WEB}

rrdtool graph timeleft-7d.png DEF:timeleft=${RRD}:timeleft:AVERAGE LINE1:timeleft#D8CD95:"Run time remaining" $COLOR --disable-rrdtool-tag -v "Minutes" --start end-1w -x HOUR:8:DAY:1:DAY:1:0:%a
mv timeleft-7d.png ${WEB}
