package Tiamail::Util::MySQL;

use strict;
use warnings;

use base qw( Tiamail::Base );

use Params::Validate;

sub mysql_connect {
	my $self = shift;

	return $self->mysql_custom_connect(
		database => $self->{args}->{database},
		host => $self->{args}->{host},
		user => $self->{args}->{user},
		pass => $self->{args}->{pass},
		port => $self->{args}->{port});
}

sub mysql_custom_connect {
	my $self = shift;

	my %params = validate (@_, {
		database => 1,
		user => 1,
		pass => 1,
		host => 1,
		port => 0
		});

	my $port = $params{port} ? $params{port} : 3306;

	my $dsn = sprintf("DBI:mysql:database=%s;host=%s;port=%s", $params{database}, $params{host}, $port);

	my $dbh = DBI->connect(
		$dsn, $params{user}, $params{pass},
		{ AutoCommit => 1, RaiseError => 1}
	);

	die $! unless $dbh;

	return $dbh;

}

1;
