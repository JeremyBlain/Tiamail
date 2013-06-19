package Tiamail::Persist::MySQL;

use base qw( Tiamail::Persist::SQL Tiamail::Util::MySQL );

use Digest::SHA1;

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist_id";
	}

	$self->{dbh} = $self->mysql_connect();
	
	my $tablename = Digest::SHA1::sha1_hex($self->{args}->{persist_id});

	# if we have unique defined as false do not add the unique index.
	my $index = ", PRIMARY KEY(id)";
	if (exists($self->{args}->{unique}) && !$self->{args}->{unique}) {
		$index = "";
	}

	if (!$self->{dbh}->do("CREATE TABLE IF NOT EXISTS `$tablename` (id varchar(255), value blob $index)")) {
		die "Error creating table";
	}

	if (exists($self->{args}->{unique}) && !$self->{args}->{unique}) {
		$self->{add} = $self->{dbh}->prepare("INSERT INTO `$tablename` (id, value) VALUES (?,?)");
	}
	else {
		$self->{add} = $self->{dbh}->prepare("REPLACE INTO `$tablename` (id, value) VALUES (?,?)");
	}
	$self->{get} = $self->{dbh}->prepare("SELECT id,value FROM `$tablename` LIMIT 1");
	$self->{delete} = $self->{dbh}->prepare("DELETE FROM `$tablename` WHERE id=?");

}


1;
