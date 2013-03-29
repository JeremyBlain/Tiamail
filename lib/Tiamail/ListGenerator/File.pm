package Tiamail::ListGenerator::File;

use FileHandle;

use base qw( Tiamail::ListGenerator );

sub _init {
	my $self = shift;
	unless ($self->{args}->{file}) {
		die "file param is required";
	}

	my $fh = FileHandle->new();
	my $file = Tiamail::Config::get('data_dir') . "/" . $self->{args}->{file};
	unless ($fh->open($file, 'r')) {
		die "Failed to open " . $file . " " . $!;
	}

	my @list = ();
	while (<$fh>) {
		chomp;
		push(@list, $_);
	}
	$fh->close();
	$self->{list} = \@list;
}

1;
