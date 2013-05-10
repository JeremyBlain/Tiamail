package Tiamail::Persist::SQL;

use base qw( Tiamail::Persist );

use DBI;
use Storable qw( nfreeze thaw );

sub add_entry {
	my ($self,$key,$value) = @_;
	
	$self->{add}->execute($key,nfreeze($value));
}

sub remove_entry {
	my ($self,$key) = @_;
	return $self->{delete}->execute($key);
}

sub get_entry {
	my $self = shift;
	my $result = $self->{get}->execute();
	if ($result) {
		if (my ($key,$value) = $self->{get}->fetchrow_array()) {
			return ($key, thaw($value));
		}
	}
	return ();
}

1;
