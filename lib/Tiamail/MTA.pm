package Tiamail::MTA;

use base qw( Tiamail::Base );

sub send {
	die "Subclasses should override send";
}

1;
