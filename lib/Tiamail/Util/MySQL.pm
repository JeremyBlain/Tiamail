package Tiamail::Util::MySQL;

use base qw( Tiamail::Base );

sub mysql_connect {
	my $self = shift;

	# yes, in theory we don't need all these parameters, but most setups do.  
	unless ($self->{args}->{host} && $self->{args}->{database} && $self->{args}->{user} && $self->{args}->{pass}) {
		die "Must specify host, database, user, pass";
	}
	my $port = $self->{args}->{port} ? $self->{args}->{port} : 3306;

	my $dsn = sprintf("DBI:mysql:database=%s;host=%s;port=%s", $self->{args}->{database}, $self->{args}->{host}, $port);

	my $dbh = DBI->connect(
		$dsn, $self->{args}->{user}, $self->{args}->{pass},
		{ AutoCommit => 1, RaiseError => 1}
	);

	die $! unless $dbh;

	return $dbh;
}

1;
