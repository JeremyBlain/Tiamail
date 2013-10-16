package Tiamail::Parse::File;

use strict;
use warnings;

use File::Tail;
use FileHandle;

use base qw ( Tiamail::Parse );

sub _init {
	my $self = shift;
	unless ($self->{args}->{file}) { 
		die "file is a required param";	
	}
}

sub parse {
	my $self = shift;

	my $tail = File::Tail->new(
		name => $self->{args}->{file},
		maxinterval => 10,
		adjustafter => 10,
		ignore_nonexistant => 1,
		tail => -1,
		reset_tail => -1,
	);

	while (defined( my $line = $tail->read ) ) {
		$self->read_line($line);
	}
}

sub read_line {
	die "Must override read_line!";
}

1;
