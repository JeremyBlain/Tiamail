package Tiamail::Parse::OpenClick;

use strict;
use warnings;

use FileHandle;

use base qw ( Tiamail::Parse );

=doc

An open/click parser needs to parse log files and record opens and clicks.

These will usually be via web server logs, GET /foo/bar/whatever

Expects a file to parse

=cut

sub _init {
	my $self = shift;
	unless ($self->{args}->{file}) {
		die "file is a required param";
	}
	unless (-f $self->{args}->{file}) {
		die "file must be readable";
	}
	
	$self->{reader} = FileHandle->new($self->{args}->{file}, 'r');
};

sub process_line {
	my $self = shift;
	my $line = shift;
	if ($_ =~ m#GET /r/([^/]+)/([^/]+)/#) {
		# looks sane for click 
		$self->SUPER::_record_click($1 ,$2);
		
	}
	elsif ($_ =~ m#GET /x.gif/([^/]+)/([^/]+)/#) {
		# looks sane for open
		$self->SUPER::_record_open($1, $2);
	}
}

1;

