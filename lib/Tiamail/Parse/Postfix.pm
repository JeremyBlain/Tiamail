package Tiamail::Parse::Postfix;

use strict;
use warnings;

use base qw( Tiamail::Parse::File );

# Mar 15 04:10:11 server postfix/smtp[2756]: 0B4797E2E: to=<to@example.com>, relay=gmail-smtp-in.l.google.com[74.125.142.27], delay=1, status=sent (250 2.0.0 OK 1363335073 fn5si1865101igc.56 - gsmtp)
sub read_line {
	my $lines = shift
	foreach ( @{$lines} ) {
		chomp;
		next if $_ =~ //;
		next unless $_ =~ m#postfix/smtp.*?to=<([^>]+)>.*? status=sent/#;
		_record_send($1);
	}
	
}





1; 
