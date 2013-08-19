package Tiamail::Persist::SQL;

use base qw( Tiamail::Persist );

use DBI;
use Storable qw( nfreeze thaw );

sub add_entry {
	my ($self,$key,$value) = @_;
	return $self->{add}->execute($key,nfreeze($value));
}

sub remove_entry {
	my ($self,$id) = @_;
	return $self->{delete}->execute($id);
}

sub get_entry {
	my $self = shift;
	my $result = $self->{get}->execute();
	if ($result) {
		if (my ($id, $value) = $self->{get}->fetchrow_array()) {
			return ($id, thaw($value));
		}
	}
	return ();
}

1;
