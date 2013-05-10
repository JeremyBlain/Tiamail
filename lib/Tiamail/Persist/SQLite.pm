package Tiamail::Persist::SQLite;

use base qw( Tiamail::Persist::SQL );

use Digest::SHA1;

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist_id";
	}
	my $dbh = DBI->connect(
		sprintf("dbi:SQLite:%s", sprintf("%s/%s.sqlite.db", Tiamail::Config::get('temp_dir'), Digest::SHA1::sha1_hex($self->{args}->{persist_id}))),
		"","",
		{ AutoCommit => 1, RaiseError => 1}
	);

	die $! unless $dbh;
	$self->{dbh} = $dbh;
	
	if (!$self->{dbh}->do("CREATE TABLE IF NOT EXISTS Tiamail (key text PRIMARY KEY, value blob)")) {
		die "Error creating table";
	}
	$self->{add} = $dbh->prepare("INSERT OR REPLACE INTO Tiamail (key, value) VALUES (?,?)");
	$self->{get} = $dbh->prepare("SELECT key,value FROM Tiamail LIMIT 1");
	$self->{delete} = $dbh->prepare("DELETE FROM Tiamail WHERE key=?");
}

1;
