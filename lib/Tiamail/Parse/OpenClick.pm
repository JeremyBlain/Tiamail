package Tiamail::Parse::OpenClick;

use strict;
use warnings;

use base qw( Tiamail::Parse::File );

sub read_line {
	my $self = shift;
	my $line = shift;

	# "-" - - [21/May/2013:17:26:42 -0400] "GET /r/10/1000001/http://www.google.ca/ HTTP/1.1" 302 245 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.68 Safari/537.17"

	return unless $line =~ m#^"(\-|[\d\.\, ]+)".*?GET /(r|x.gif)/([A-Za-z0-9_]+)/([A-Za-z0-9_]+)#;
	if ($2 eq 'r') {
		# record click
		$self->record_email_click(
			id => $3,
			template_id => $4,
			ip => $1
		);
	}
	else {
		# record open
		$self->record_email_open(
			id => $3,
			template_id => $4,
			ip => $1
		);
	}
}

1;
