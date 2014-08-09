#!/bin/sh

RRD="apcupsd.rrd"

rrdtool create ${RRD} --step 60 \
	DS:linev:GAUGE:120:0:275 \
	DS:loadpct:GAUGE:120:0:100 \
	DS:bcharge:GAUGE:120:0:100 \
	DS:timeleft:GAUGE:120:0:35 \
	DS:itemp:GAUGE:120:0:70 \
	RRA:AVERAGE:0.5:1:525600
