package Tiamail::Template::File;

use strict;
use warnings;

use base qw( Tiamail::Template Tiamail::Template::SearchReplace );

=doc 

File based Tiamail template

Requires arguments of:

body => the file for the body of the email
headers => the file for the headers of the email

Replacement is handled via Tiamail::Template::SearchReplace methods

=cut



sub render {
	my ($self, $id, $template_id, $base_url, $tracking, $params) = @_;

	unless ($self->{args}->{body} && $self->{args}->{headers}) {
		die ref($self) . " requires arguments of body and headers";
	}

	# slurp in body and headers

	my $body = Tiamail::Util::slurp_file(Tiamail::Conf::get('content_dir') . $self->{args}->{body});
	my $headers = Tiamail::Util::slurp_file(Tiamail::Conf::get('content_dir') . $self->{args}->{headers});

	unless ($body && $headers) {
		die ref($self) . " either body or headers or both failed to read";
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
