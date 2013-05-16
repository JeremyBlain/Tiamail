package Tiamail::Sender;

use strict;
use warnings;

use base qw( Tiamail::Base );

sub _verify {
	my $self = shift;
	unless ($self->{args}->{template}) {
		die "template not specified";
	}
	unless ($self->{args}->{persist}) {
		die "persist not specified";
	}
	unless ($self->{args}->{mta}) {
		die "MTA not specified";
	}
	unless ($self->{args}->{from}) {
		die "from not specified";
	}
}

sub send {
	my ($self) = @_;

	$self->_verify();

	while (my ($email, $template_data) = $self->{args}->{persist}->get_entry()) {
		my $result = $self->{args}->{mta}->send(
				$self->{args}->{from},
				$email,
				$self->{args}->{template}->render($template_data)
			);
		
		if ($result) {
			$self->{args}->{persist}->remove_entry($email);
		}
		else {
			die sprintf("Send failed for %s\n", $email);
		}

	}
}


1;
