package Tiamail::ListGenerator::MySQL;

use strict;
use warnings;

use base qw( Tiamail::ListGenerator );
use DBI;
use DBD::mysql;

sub _init {
	my $self = shift;

	my $host = $self->{args}->{host};

	unless ($host) {
		die "host param required";
	}

	my $port = $self->{args}->{port} || 3306;
	unless ($port && $port =~ /^\d+$/) {
		die "port $port param is invalid";
	}

	my $database = $self->{args}->{database};

	unless ($database) {
		die "database param must be specified";
	}

	my $query = $self->{args}->{query};
	unless ($query) {
		die "query param must be specified";
	}

	$self->{query} = $query;

	my $connstr = sprintf('DBI:mysql:database=%s;host=%s;port=%s', $database, $host, $port);

	my @auth_options = ();
	if ($self->{args}->{user}) {
		push(@auth_options, $self->{args}->{user});
	}
	if (defined($self->{args}->{pass})) {
		push(@auth_options, $self->{args}->{pass});
	}
	if (defined($self->{args}->{options})) {
		push(@auth_options, $self->{args}->{options});
	}

	my $query_params = $self->{args}->{query_params};
	if (!$query_params) {
		$query_params = [];
	}

	$self->{query_params} = $query_params;

	if (!UNIVERSAL::isa($query_params, 'ARRAY')) {
		die "param query_params expects a list ref";
	}

	my $dbh = DBI->connect($connstr, @auth_options);
	unless ($dbh) {
		die "Failed to connect " . $DBI::errstr;
	}
	$self->{dbh} = $dbh;
}

sub execute {
	my $self = shift;
	my $sth = $self->{dbh}->prepare($self->{query});
	$sth->execute( @{ $self->{query_params} } ) or die $!;

	return $self->_generate_list($sth);
}

sub _generate_list {
	my $self = shift;
	die "_generate_list should be overridden";
}

1;
