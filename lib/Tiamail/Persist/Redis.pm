package Tiamail::Persist::Redis;

use strict;
use warnings;

use Redis;

use base qw( Tiamail::Persist );

use Storable qw( nfreeze thaw );

sub create_storage {
	my $self = shift;
	unless ($self->{args}->{persist_id}) {
		die "Must specify a valid persist id";
	}

	my $redis = Redis->new(
		server => $self->{args}->{redis_server},
		reconnect => $self->{args}->{redis_reconnect} ? $self->{args}->{redis_reconnect} : 60,
	);
	$self->{redis} = $redis;
}

sub add_entry {
	my ($self,$key,$value) = @_;
	
	$self->{redis}->lpush($self->{args}->{persist_id}, nfreeze([ $key, $value ]));
}

sub remove_entry {
	my $self = shift;
	# no need to do anything here.
	return 1;
}
sub get_entry {
	my $self = shift;
	my $val;
	if ($self->{args}->{redis_block}) {
		$val = $self->{redis}->blpop($self->{args}->{persist_id});
	}
	else {
		$val = $self->{redis}->lpop($self->{args}->{persist_id});
	}
	if ($val) {
		my $arr = thaw($val);
		return @{ $arr };
	}
	return ();
}

1;
