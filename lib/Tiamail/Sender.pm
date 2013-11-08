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
	unless ($self->{args}->{recorder}) {
		die "recorder not specified";
	}
	if ($self->{args}->{test} && ref($self->{args}->{test} ne 'ARRAY')) {
		die "test parameter must be an array reference of email addresses";
	}
}

sub send {
	my ($self) = @_;

	$self->_verify();

	while (my ($email, $template_data) = $self->{args}->{persist}->get_entry()) {

		if ($self->{args}->{test} && ref($self->{args}->{test}) eq 'ARRAY') {
			foreach my $email (@{ $self->{args}->{test} }) {
				$template_data->{email} = $email;
				my $mta_id = $self->{args}->{mta}->send(
					$self->{args}->{from},
					$email,
					$self->{args}->{template}->render($template_data),
				);
			}
			return;
		}
		my $mta_id = $self->{args}->{mta}->send(
				$self->{args}->{from},
				$email,
				$self->{args}->{template}->render($template_data)
			);
		
		if ($mta_id) {
			$self->{args}->{recorder}->record_email_send(
				id => $template_data->{ $self->{args}->{template}->{id} },
				email => $email,
				template_id => $self->{args}->{template}->{template_id},
				mta_id => $mta_id,
			);

			$self->{args}->{persist}->remove_entry($email);
		}
		else {
			die sprintf("Send failed for %s\n", $email);
		}

	}
}


1;
