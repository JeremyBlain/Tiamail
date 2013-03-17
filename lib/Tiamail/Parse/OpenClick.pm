package Tiamal::Parse::OpenClick;

use strict;
use warnings;

use base qw( Tiamail::Parse::HTTP );

sub read_line {
	my $lines = shift
	foreach ( @{$lines} ) {
		chomp;
		next if $_ =~ //;
		next unless $_ =~ m#/(r|x.gif)/([A-Za-z0-9_]+)/([A-Za-z0-9_]+)/#;
		if ($1 eq 'r') {
			# record click
			_record_click($2, $3);
		}
		else {
			# record open
			_record_open($2, $3);
		}
	}
}

1;
