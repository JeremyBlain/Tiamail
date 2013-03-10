package Mmail::Seed;

use strict;
use warnings;

use base qw( Tiamail::Base );

sub seed {
	my $self = shift;
	die "filter must be overridden";
}

1;

