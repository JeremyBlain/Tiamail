package Tiamail::Persist::GDBM;

use strict;
use warnings;

use base qw( Tiamail::Persist::DBM );

use Fcntl;
use GDBM_File;
use Digest::SHA1;

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist_id";
	}
	my %h;
	tie(%h, 'GDBM_File', sprintf("%s/%s.gdbm", Tiamail::Config::get('temp_dir'), Digest::SHA1::sha1_hex($self->{args}->{persist_id})), O_RDWR|O_CREAT, 0666) or die $!;
	$self->{store} = \%h;
}

1;
