package Tiamail::ListGenerator::File;

use FileHandle;

use base qw( Tiamail::ListGenerator );

sub _init {
	my $self = shift;
	unless ($self->{args}->{file}) {
		die "file param is required";
	}

	my $file = FileHandle->new();
	unless ($file->open($self->{args}->{file}, 'r')) {
		die "Failed to open " . $self->{args}->{file} . " " . $!;
	}

	my @list = ();
	while (<$file>) {
		chomp;
		push(@list, $_);
	}
	$file->close();
	$self->{list} = \@list;
}

1;
