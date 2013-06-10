package Tiamail::Filter::List::MySQL;

use strict;
use warnings;

use base qw( Tiamail::Filter Tiamail::ListGenerator::MySQL::SingleValue );

sub init {
	my $self = shift;

	if ($self->{filter_map}) {
		return 1;
	}
	unless ($self->{args}->{field}) {
		die "field param is required";
	}

	my $filter_list = $self->execute();
	
	my %filter = map { $_ => 1 } @{ $filter_list };
	
	$self->{filter_map} = \%filter;

}

sub filter {
	my $self = shift;
	my $list = shift;

	my @new_list = ();
	foreach my $entry (@{ $list }) {
		if (!exists( $self->{filter_map}->{ $entry->{ $self->{args}->{field} } } )) {
			push(@new_list, $entry);
		}
	}
	return \@new_list;
}

1;
