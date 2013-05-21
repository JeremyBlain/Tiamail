package Tiamal::Parse::OpenClick;

use strict;
use warnings;

use base qw( Tiamail::Parse::File );

sub read_line {
	my $lines = shift;
	foreach ( @{$lines} ) {
		chomp;
		next if $_ =~ //;
		next unless $_ =~ m#^"([\d\.\, ]+)".*?GET /(r|x.gif)/([A-Za-z0-9_]+)/([A-Za-z0-9_]+)/#;
		if ($2 eq 'r') {
			# record click
			record_email_click($3, $4, $1);
		}
		else {
			# record open
			record_email_open($3, $4, $1);
		}
	}
}

1;
