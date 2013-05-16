package Tiamail::MTA::SMTP::Dumb;

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
	$self->{_init} = 1;
}

sub get_smtp {
	my $self = shift;
	my $entry = int(rand(@{ $self->{args}->{hosts} }));
	my $smtp = Net::SMTP->new( $self->{args}->{hosts}->[$entry], Timeout => $self->{args}->{timeout} ? $self->{args}->{timeout} : 5 );
	if ($smtp) {
		return {
			obj =>	$smtp,
			id => $self->{args}->{hosts}->[$entry],
		};
	}
	return;
}

