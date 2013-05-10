package Tiamail::Persist::DBM;

use strict;
use warnings;

use base qw( Tiamail::Persist );

use Storable qw( nfreeze thaw );


sub add_entry {
	my ($self,$key,$value) = @_;
	
	$self->{store}->{$key} = nfreeze($value);
}

sub remove_entry {
	my ($self,$key) = @_;
	delete($self->{store}->{$key});
}

sub get_entry {
	my $self = shift;
	if (my ($key,$value) = each $self->{store}) {
		return ($key, thaw($value));
	}
	return ();
}

1;
