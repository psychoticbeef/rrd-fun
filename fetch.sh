#!/bin/sh

RRD="apcupsd.rrd"

rrdtool fetch ${RRD} AVERAGE
