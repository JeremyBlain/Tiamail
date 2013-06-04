package Tiamail::Filter::List::Array;

use strict;
use warnings;

use base qw( Tiamail::Filter );

sub init {
	if (!$self->{_init}) {
		unless ($self->{args}->{list} && UNIVERSAL::isa($self->{args}->{list}, 'ARRAY')) {
			die "Must specify a list argument to new, which must be an array ref";
		}
		my %hash = map { lc($_) => 1 } @{ $self->{args}->{list} };
		$self->{hash} = \%hash;
		$self->{_init} = 1;
	}
	return 1;
}

sub filter {
	my $self = shift;
	my $list = shift;
	unless ($list && UNIVERSAL::isa($list, 'ARRAY')) {
		die "filter expects a an array list as an argument";
	}

	$self->init();

	# this should be able to be made more memory efficient not dereferencing list
	# and making a second copy
	my @new_list = ();
	foreach my $entry (@{ $list }) {
		# if the entry does not appear in our filter list, add it to the new list.
		if (!exists( $self->{hash}->{ lc($entry->{ $self->{args}->{field} }) }) ) {
			push(@new_list, $entry);
		}
	}
	# override list
	return \@new_list; 
}
1;
