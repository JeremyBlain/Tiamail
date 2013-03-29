package Tiamail::API::JSON;

use JSON;

use base qw( Timail::API );

use strict;
use warnings;

sub parse {
	my ($self, $body) = @_;

	my $json = JSON->new();
	
	my $data = $json->decode($body);

	# We assume if it decoded correctly someone formatted it correctly.
	# json maps well to the data structure it expects.
	# upper level module will explode if needed.

	$self->{data} = $data;
}

1; 
