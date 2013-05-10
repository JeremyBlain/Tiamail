package Tiamail::Persist::MySQL;

use base qw( Tiamail::Persist::SQL );

use Digest::SHA1;

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist_id";
	}

	# yes, in theory we don't need all these parameters, but most setups do.  
	unless ($self->{args}->{host} && $self->{args}->{db} && $self->{args}->{user} && $self->{args}->{pass}) {
		die "Must specify host, db, user, pass";
	}
	my $port = $self->{args}->{port} ? $self->{args}->{port} : 3306;

	my $dsn = sprintf("DBI:mysql:database=%s;host=%s;port=%s", $self->{args}->{db}, $self->{args}->{host}, $port);

	my $dbh = DBI->connect(
		$dsn, $self->{args}->{user}, $self->{args}->{pass},
		{ AutoCommit => 1, RaiseError => 1}
	);

	die $! unless $dbh;
	$self->{dbh} = $dbh;
	
	my $tablename = Digest::SHA1::sha1_hex($self->{args}->{persist_id});

	if (!$self->{dbh}->do("CREATE TABLE IF NOT EXISTS $tablename (id varchar(255), value blob, PRIMARY KEY(id))")) {
		die "Error creating table";
	}
	$self->{add} = $dbh->prepare("REPLACE INTO $tablename (id, value) VALUES (?,?)");
	$self->{get} = $dbh->prepare("SELECT id,value FROM $tablename LIMIT 1");
	$self->{delete} = $dbh->prepare("DELETE FROM $tablename WHERE id=?");
}


1;
