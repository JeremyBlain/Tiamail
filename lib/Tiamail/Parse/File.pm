package Tiamail::Parse::File;

use strict;
use warnings;
use File::Tail::Multi;

use base qw ( Tiamail::Parse );

sub _init {
	my $self = shift;
	unless ($self->{args}->{file}) { 
		die "file is a required param";	
	}
	unless (-f $self->{args}->{file}) {
		die "file $self->{args}->{file} is not a normal file";
	}
	
}

sub parse {
	my $self = shift;

	my $tail = File::Tail::Multi->new( 
		Function => \&read_line,
		LastRun_File => "/tmp/$self->{args}->{file}.tmp",
		File => $self->{args}->{file},
	);
}

sub read_ine {
	die "Must override read_line!";
}

1;
