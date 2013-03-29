package Tiamail::Util;

use strict;
use warnings;

use FileHandle;

sub slurp_file {
	($file) = @_;
	unless (-f $file) {
		die "$file is not a normal file or does not exist";
	}
	my $fh = FileHandle->new();
	$fh->open($file, "r") or die $!;
	local $/ = undef;
	my $data = <$fh>;
	$fh->close();
	return $data; 
}

1;
