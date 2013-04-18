package Tiamail::Sender;

use strict;
use warnings;

use base qw( Tiamail::Base );

sub _verify {
	my $self = shift;
	unless ($self->{args}->{template}) {
		die "template not specified";
	}
	unless ($self->{args}->{list}) {
		die "list not specified";
	}
	unless ($self->{args}->{mta}) {
		die "MTA not specified";
	}
	unless ($self->{args}->{from}) {
		die "from not specified";
	}
	unless ($self->{args}->{field}) {
		die "field name for email not specified";
	}	
}

sub send {
	my ($self) = @_;

	$self->_verify();

	foreach my $record (@{ $self->{args}->{list} }) {
		$self->{args}->{mta}->send(
			$self->{args}->{from},
			$record->{ $self->{args}->{field} },
			$self->{args}->{template}->render($record)
		);
	}

}


1;
