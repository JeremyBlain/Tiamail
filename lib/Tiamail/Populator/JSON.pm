package Tiamail::Populator::JSON;

use strict;
use warnings;

use JSON qw( decode_json );

use base qw( Tiamail::Populator );

sub init {
	my $self = shift;

	if ($self->{_init}) {
		return 1;
	}
	unless ($self->{args}->{persist}) {
		die "persist system must be specified";
	}
	
	unless ($self->{args}->{email}) {
		die "email must be specified";
	}

	$self->{persist} = $self->{args}->{persist};
	
	

	$self->{persist}->create_storage();

	$self->{_init} = 1;
	return 1;
}

sub add {
	my ($self,$json_text) = @_;
	
	$self->init();

	my $json = decode_json( $json_text );

	foreach my $rec (@{ $json }) {
		unless (exists($rec->{ $self->{args}->{email} })) {
			die "Record missing email field";
		}
		$self->{persist}->add_entry($rec->{ $self->{args}->{email} }, $rec);
	}
	return 1;
}
1;
