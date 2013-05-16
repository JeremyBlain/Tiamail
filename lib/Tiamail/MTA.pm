package Tiamail::MTA;

use strict;
use warnings;

use base qw( Tiamail::Base );

=doc

Base class for Tiamail MTA's.

=cut

sub send {
	die "Subclasses should override send";
}

1;
