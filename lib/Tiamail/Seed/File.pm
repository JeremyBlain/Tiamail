package Tiamail::Seed::File;

use base qw( Tiamail::Seed Tiamail::ListGenerator::File );

sub _init {
	my $self = shift;

	$self->SUPER::_init();

	unless ($self->{args}->{field}) {
		die "field param is required";
	}

	unless ($self->{args}->{record}) {
		$self->{args}->{record} = 'first';	
	}

	unless ($self->{args}->{record} =~ /^(?:first|last|rand)$/) {
		die "param record must be first/last/rand - defaults to first";	
	}
}

sub seed {
	my $self = shift;
	my $list = shift;
	unless ($list && UNIVERSAL::isa($list, 'ARRAY')) {
		die "seed expects a an array list as an argument";
	}

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

	foreach my $seed ( @{ $self->{list} } ) {
		# dereference for proper copy
		my %seed_hash = %{ $seed_data };
		$seed_hash{ $self->{args}->{field} } = $seed;
		push(@{ $list }, \%seed_hash);
	}
	return $list;
}

1;
