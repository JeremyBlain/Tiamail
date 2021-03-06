package Tiamail::Persist::MySQL;

use strict;
use warnings;

use base qw( Tiamail::Persist::SQL Tiamail::Util::MySQL );

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist_id";
	}

	$self->{dbh} = $self->mysql_connect();
	
	my $tablename = $self->{dbh}->quote_identifier($self->{args}->{persist_id});

	my $create = "CREATE TABLE IF NOT EXISTS $tablename  (id varchar(255), value mediumblob, primary key(id))";

	if (!$self->{dbh}->do($create)) {
		die "Error creating table";
	}

	$self->{add} = $self->{dbh}->prepare("REPLACE INTO $tablename (id, value) VALUES (?,?)");

	$self->{get} = $self->{dbh}->prepare("SELECT id,value FROM $tablename LIMIT 1");
	$self->{delete} = $self->{dbh}->prepare("DELETE FROM $tablename WHERE id=?");

}


1;
