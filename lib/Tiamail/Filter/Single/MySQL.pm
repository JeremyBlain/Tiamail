package Tiamail::Filter::Single::MySQL;

use strict;
use warnings;

use base qw( Tiamail::Filter Tiamail::Util::MySQL );

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

	my $dbh = $self->mysql_connect();
	my $sth = $dbh->prepare($self->{args}->{query});

	my @new_list = ();
	foreach my $entry (@{ $list }) {
		if ($sth->execute( $entry->{ $self->{args}->{field} } ) && !$sth->rows()) {
			push(@new_list, $entry);
		}
	}
	return \@new_list;
}

1;
