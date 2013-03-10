package Tiamail::Seed::MySQL;

use strict;
use warnings;

use base qw( Tiamail::Seed Tiamail::ListGenerator::MySQL::SingleValue );

sub _init {
	my $self = shift;

	unless ($self->{args}->{field}) {
		die "field param is required";
	}

	unless ($self->{args}->{record}) {
		$self->{args}->{record} = 'first';
	}

	unless ($self->{args}->{record} =~ /^(?:first|last|rand)$/) {
		die "param record must be first/last/rand - defaults to first";
	}

	$self->SUPER::_init();	
}

sub seed {
	my $self = shift;
	my $list = shift;

        my $seed_data;
	if ($self->{args}->{record} eq 'first') {
		$seed_data = $list->[0];
	}
	if ($self->{args}->{record} eq 'last') {
		$seed_data = $list->[-1];
	}
        if ($self->{args}->{record} eq 'rand') {
		# depending on list size, this could be horribly inefficient
		my $rec = int(rand(scalar(@{ $list })));
		$seed_data = $list->[$rec];
	}
	
	my $seed_list = $self->execute();

	foreach my $seed (@{ $seed_list }) {
		# dereference for proper copy
		my %seed_hash = %{ $seed_data };
		$seed_hash{ $self->{args}->{field} } = $seed;
		push(@{ $list }, \%seed_hash);
	}
	return $list;
}

1;
