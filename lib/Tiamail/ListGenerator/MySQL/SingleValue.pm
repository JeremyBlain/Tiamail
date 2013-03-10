package Tiamail::ListGenerator::MySQL::SingleValue;

use strict;
use warnings;

use base qw( Tiamail::ListGenerator::MySQL );

sub _generate_list {
	my ($self, $sth) = @_;
	my @list = ();
	while (my ($row) = $sth->fetchrow_array()) {
		push(@list, $row);
	}
	return \@list;
}

1;
