package Tiamail::API;

use base qw( Tiamail::Base );

use strict;
use warnings;

=doc

Tiamail::API expects to process a large string of characters that it interprets as a message send request.

While differing API's are free to structure their format however they like, 

Enough information to include the following should be specified:

{
	template => {
		type => 'Basic',
		template_id => 200,
		base_url => 'http://tiamail.example/',
		tracking => 0,
		args => {
			# hashref of args to pass to the template object initializer
		},
	},
	email => [
		{ 
			email => 'foo@example.com', 
			id => 'unique_identifer', 
			template_args => { 
				# hashref of template args for this record
			}
		},
		{ 
			email => 'foo2@example.com', 
			id => 'unique_identifer2', 
			template_args => { 
				# hashref of template args for this record
			}
		},
		{ 
			email => 'foo3@example.com', 
			id => 'unique_identifer3', 
			template_args => { 
				# hashref of template args for this record
			}
		},
	],	

	
	
}

=cut

sub parse {
	die "Must override parse method";
}

sub execute {
	my ($self, $data) = @_;

	$self->parse($data);

	unless ($self->{data}) {
		die "parse must have failed.  data not set";
	}

	my $template = $self->get_template();
}

# read the template object, make sure it's sane.
sub get_template {
	my $self = shift;

	unless ($self->{data}->{template}) {
		die "template missing";
	}

	my $type = $self->{data}->{template}->{type};
	unless ($type) {
		die "template type missing";
	}

	if ($type eq 'Basic') {
		$self->{template} = Tiamail::Template::Basic->new(
			%{ $self->{data}->{template}->{args} }
		);
	}
	elsif ($type eq 'File') {
		$self->{template} = Tiamail::Template::File->new(
			%{ $self->{data}->{template}->{args} }
		);
	}
	else {
		die "unknown template type";
	}
}

1;
