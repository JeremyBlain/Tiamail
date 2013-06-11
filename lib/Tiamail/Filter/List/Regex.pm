package Tiamail::Filter::List::Regex;

use strict;
use warnings;

use base qw( Tiamail::Filter );

sub init {
	return;
}

sub filter {
	my $self = shift;
	my $list = shift;
	unless ($list && UNIVERSAL::isa($list, 'ARRAY')) {
		die "filter expects a an array list as an argument";
	}

	unless ($self->{args}->{field}) {
		die "filter needs a field parameter";
	}
	unless ($self->{args}->{patterns} && UNIVERSAL::isa($self->{args}->{patterns}, 'ARRAY')) {
		die "patterns must be passed to new, and must be an array reference";
	}

	my @new_list = ();
	foreach my $entry (@{ $list }) {
		my $match = 0;
		foreach my $regex (@{ $self->{args}->{patterns} }) {
			if ($entry->{ $self->{args}->{field} } =~ /$regex/) {
				$match = 1;
				last;
			}
		}

		# if the entry does not appear in our filter list, add it to the new list.
		if ( !$match ) {
			push(@new_list, $entry);
		}
	}
	# override list
	return \@new_list; 
}
1;

1;
