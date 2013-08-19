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

	my $total = 0; # total number of successful entires
	my $res;

	foreach my $rec (@{ $json }) {
		unless (exists($rec->{ $self->{args}->{email} })) {
			die "Record missing email field";
		}
		$res = $self->{persist}->add_entry($rec->{ $self->{args}->{email} }, $rec);
		if ($res)
		{
			$total += $res;
		}
	}

	return $total;
}
1;
