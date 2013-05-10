package Tiamail::Persist::BDB;

use strict;
use warnings;

use base qw( Tiamail::Persist::DBM );

use Fcntl;
use DB_File;
use Digest::SHA1;

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist_id";
	}
	my %h;
	tie(%h, 'DB_File', sprintf("%s/%s.bdb", Tiamail::Config::get('temp_dir'), Digest::SHA1::sha1_hex($self->{args}->{persist_id})), O_RDWR|O_CREAT, 0666, $DB_HASH) or die $!;
	$self->{store} = \%h;
}

1;
