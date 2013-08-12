package Tiamail::ListGenerator::MySQL;

use strict;
use warnings;

use base qw( Tiamail::ListGenerator Tiamail::Util::MySQL );
use DBI;
use DBD::mysql;
use Data::Dumper;

sub initialize_connections {
	my $self = shift;

	return if $self->{dbh};

	my $query = $self->{args}->{query};
	unless ($query) {
		die "query param must be specified";
	}

	$self->{query} = $query;

	my $query_params = $self->{args}->{query_params};
	if (!$query_params) {
		$query_params = [];
	}

	$self->{query_params} = $query_params;

	if (!UNIVERSAL::isa($query_params, 'ARRAY')) {
		die "param query_params expects a list ref";
	}

	$self->{dbh} = $self->mysql_connect();
	die $! unless $self->{dbh};
}

sub _init {
	my $self = shift;
	$self->initialize_connections();
}

sub execute {
	my $self = shift;
	$self->initialize_connections();
	my $sth = $self->{dbh}->prepare($self->{query});
	$sth->execute( @{ $self->{query_params} } ) or die $!;

	return $self->_generate_list($sth);
}

sub _generate_list {
	my $self = shift;
	die "_generate_list should be overridden";
}

1;
