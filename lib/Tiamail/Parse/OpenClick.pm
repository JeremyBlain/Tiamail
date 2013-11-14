package Tiamail::Parse::OpenClick;

use strict;
use warnings;

use base qw( Tiamail::Parse::File );

use Date::Parse qw( str2time );

sub read_line {
	my $self = shift;
	my $line = shift;

	# "-" - - [21/May/2013:17:26:42 -0400] "GET /r/10/1000001/http://www.google.ca/ HTTP/1.1" 302 245 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.68 Safari/537.17"

	return unless $line =~ m#^"(\-|[\d\.\, ]+)"\s+\-\s+\-\s+\[(\d+\/[A-Za-z]+\/\d+:\d+:\d+:\d+\s+[\+\-]\d+)\]\s+\"GET /(r|x.gif)/([A-Za-z0-9_]+)/([A-Za-z0-9_]+)(\/?.*?)$#;

#	return unless $line =~ m#^"(\-|[\d\.\, ]+)"\s.*?GET /(r|x.gif)/([A-Za-z0-9_]+)/([A-Za-z0-9_]+)(\/?.*?)$#;

	my $type = $3;
	my $id = $4;
	my $template_id = $5;
	my $ip = $1;
	my $link = $6;
	my $time = generate_time($2);
	$link =~ s/^\///g;

	if ($type eq 'r') {
		$link =~ s/^\///g;
		# record click
		$self->record_email_click(
			id => $id,
			template_id => $template_id,
			ip => $ip,
			link => $link,
			time => $time
		);
	}
	else {
		# record open
		$self->record_email_open(
			id => $id,
			template_id => $template_id,
			ip => $ip,
			time => $time
		);
	}
}
sub generate_time {
	my $string = shift;
	return str2time($string);
}
1;
