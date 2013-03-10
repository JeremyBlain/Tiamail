package Tiamail::Filter::File;

use strict;
use warnings;

use FileHandle;

use base qw( Tiamail::Filter Tiamail::ListGenerator::File );

sub _init {
	my $self = shift;

	$self->SUPER::_init();

	unless ($self->{args}->{field}) {
		die "field param is required";
	}
}

sub filter {
	my $self = shift;
	my $list = shift;
	unless ($list && UNIVERSAL::isa($list, 'ARRAY')) {
		die "filter expects a an array list as an argument";
	}
	
	# map the list to a hash for faster lookups
	my %hash = map { $_ => 1 } @{ $self->{list} };


	# this should be able to be made more memory efficient not dereferencing list
	# and making a second copy
	my @new_list = ();
	foreach my $entry (@{ $list }) {
		# if the entry does not appear in our filter list, add it to the new list.
		if (!exists( $hash{ $entry->{ $self->{args}->{field} } }) ) {
			push(@new_list, $entry);
		}
	}
	# override list
	return \@new_list; 
}
1;
