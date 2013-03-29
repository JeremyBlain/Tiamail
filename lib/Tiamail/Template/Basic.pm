package Tiamail::Template::Basic;

use strict;
use warnings;

use base qw( Tiamail::Template Tiamail::Template::SearchReplace );

=doc 

Very basic/simple Tiamail template.

Does a search/replace on ##field## replacing it with args{field}

Requires arguments of:

body => the body text of the email
headers => the header text of the email.

=cut

sub render {
	my ($self, $id, $template_id, $base_url, $tracking, $params) = @_;

	my $body = $self->{args}->{body};
	my $headers = $self->{args}->{headers};

	unless ($body && $headers) {
		die ref($self) . " requires arguments of body and headers";
	}

	# some sanity cleanup after headers
	$headers =~ s/[\r\n]+$//;

	$headers = $self->_search_replace($headers, $params);
	$body = $self->_search_replace($body, $params);
	if ($tracking) {
		$body = $self->_add_tracking($body, $id, $template_id, $base_url);
	}
	return $headers . "\n\n" . $body;
}



1;
