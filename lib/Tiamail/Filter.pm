package Tiamail::Filter;

use strict;
use warnings;

use base qw( Tiamail::Base );

sub filter {
	my $self = shift;
	die "filter must be overridden";
}

1;

