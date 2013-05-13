package Tiamail::SMTP::Pool;

use strict;
use warnings;

use base qw( Tiamail::MTA::SMTP );


sub init {
	my $self = shift;
	if ($self->{_init}) {
		return 1;
	}

	unless ($self->{args}->{hosts} && ref($self->{args}->{hosts}) eq 'ARRAY') {
		die "hosts argument required";
	}
	$self->{hosts} = $self->{args}->{hosts};
	$self->{_init} = 1;
	$self->{current} = 0;
}


sub get_smtp {
	my $self = shift;
	
	if (!exists($self->{hosts}->[ $self->{current} ])) {
		$self->{current} = 0;
	}
	my $smtp = Net::SMTP->new( $self->{hosts}->[ $self->{current} ], Timeout => $self->{args}->{timeout} ? $self->{args}->{timeout} : 5 );
	if ($smtp) {
		$self->{current}++;
		return $smtp;	
	}
	return undef;
}

1;
