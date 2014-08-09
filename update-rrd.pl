#!/usr/bin/env perl

# File: update-rrd.pl
# Author: Ramses J. Matabadal <ramses at matabadal dot nl>

use strict;
use POSIX;
use RRDs;

print "apcupsd-rrd v0.1a\n\n";

open STATUS, "/usr/local/sbin/apcaccess status blowfish |"
    or die "can't fork: $1";

my $rrd = "/home/da/apcupsd-rrd/apcupsd.rrd";
my ($linev, $loadpct, $bcharge, $timeleft, $itemp);

while (<STATUS>) {
	chomp;

	# get utility input voltage
	if (/LINEV\s+:\s+(\d+\.\d+)\s+Volts/) {
		$linev = ceil($1);
		next;
	}

	# get UPS load
	if (/LOADPCT\s+:\s+(\d+\.\d+)\s+Percent Load Capacity/) {
		$loadpct = ceil($1);
		next;
	}

	# get battery charge
	if (/BCHARGE\s+:\s+(\d+\.\d+)\s+Percent/) {
		$bcharge = ceil($1);
		next;
	}

	# get battery run time
	if (/TIMELEFT\s+:\s+(\d+\.\d+)\s+Minutes/) {
		$timeleft = ceil($1);
		next;
	}

	# get UPS temperature
	if (/ITEMP\s+:\s+(\d+\.\d+)\s+C Internal/) {
		$itemp = $1;
		next;
	}
}

print "linev: $linev\n";
print "loadpct: $loadpct\n";
print "bcharge: $bcharge\n";
print "timeleft: $timeleft\n";
print "itemp: $itemp\n";

RRDs::update $rrd, "--template=linev:loadpct:bcharge:timeleft:itemp",
	"N:$linev:$loadpct:$bcharge:$timeleft:$itemp";

my $err = RRDs::error;

die "ERROR while updating $rrd: $err\n" if $err;
