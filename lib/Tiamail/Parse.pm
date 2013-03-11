package Tiamail::Parse;

use strict;
use warnings;

use base qw( Tiamail::Base );

=doc

Parsers expect arguments.  

All expect where to find the logs.

http parsers expect to find a GET /something/something record.
stmp parsers expect to parse the smtp logs for details.

=cut

sub _init {
	my $self = shift;
	unless ($self->{args}->{file}) {
		die "file param not specified";
	}
}
1;
