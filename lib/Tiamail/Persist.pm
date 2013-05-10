package Tiamail::Persist;

=doc

Persistence module for tiamail

=cut


use strict;
use warnings;
use base qw( Tiamail::Base );

sub create_storage {
	die "Must override create_storage";
}
sub add_entry {
	die "Must override add_entry";
}
sub remove_entry {
	die "Must override remove_entry";
}

1;
