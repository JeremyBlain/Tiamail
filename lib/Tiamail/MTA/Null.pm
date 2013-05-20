package Tiamail::MTA::Null;

use strict;
use warnings;

use base qw( Tiamail::MTA );

=doc

Null MTA.

Calls all methods a real Tiamail::MTA would with the exception of the actual delivery.

Useful in testing the rest of your system without firing mail out.

Always reports a successful send.

=cut

sub send {
	my ($self,$from,$to,$message) = @_;

	unless ($from && $to && $message) {
		die "\$mta->send(\$from, \$to, \$message);\n"
	}
	return '127.0.0.1';
}


1;
