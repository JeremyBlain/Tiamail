package Tiamail::Populator;

use strict;
use warnings;

use base qw( Tiamail::Base );

sub add {
	die "Populator must specify an add method";
}

1;
