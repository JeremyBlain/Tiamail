package Tiamail::ListGenerator::MySQL::List;

use strict;
use warnings;

use base qw( Tiamail::ListGenerator::MySQL );

sub _generate_list {
	my ($self, $sth) = @_;
	my @list = ();
	while (my $row = $sth->fetchrow_arrayref()) {
		push(@list, $row);
	}
	return \@list;
}

1;
