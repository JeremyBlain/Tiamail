package Tiamail::Filter::List::MySQL;

use strict;
use warnings;

use base qw( Tiamail::Filter Tiamail::ListGenerator::MySQL::SingleValue );

sub _init {
	my $self = shift;

	unless ($self->{args}->{field}) {
		die "field param is required";
	}

	$self->SUPER::_init();
}

sub filter {
	my $self = shift;
	my $list = shift;

	my $filter_list = $self->execute();
	
	my %filter = map { $_ => 1 } @{ $filter_list };

	my @new_list = ();
	foreach my $entry (@{ $list }) {
		if (!exists( $filter{ $entry->{ $self->{args}->{field} } } )) {
			push(@new_list, $entry);
		}
	}
	return \@new_list;
}

1;
