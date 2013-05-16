package Tiamail::MTA::SMTP;

use strict;
use warnings;

use Net::SMTP;

use base qw( Tiamail::MTA );

=doc

Base SMTP MTA

=cut

sub send {
	my ($self, $from, $to, $message) = @_;
	
	unless ($from && $to && $message) {
		die "\$mta->send(\$from, \$to, \$message);\n"
	}

	$self->init();
	
	my $smtp = $self->get_smtp();
	if (!$smtp) {
		return undef;
	}

	if ( $smtp->mail($from) && $smtp->to($to) && $smtp->data() && $smtp->datasend($message) && $smtp->dataend() && $smtp->quit() ) {
		# if it's all good, return true
		return 1;
	}
	return undef;
}

sub init {
	die "Must override init";
}

sub get_smtp {
	die "Must override get_smtp";
}
1;
