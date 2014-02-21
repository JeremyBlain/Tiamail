package Tiamail::Template::QuotedPrint;

use MIME::QuotedPrint;
use Email::Date::Format qw( email_date );
use Email::MessageID;

use strict;
use warnings;

use base qw( Tiamail::Template::File );

sub render {
	my ($self, $params) = @_;

	my $body = $self->{body};
	my $headers = $self->{headers};

	# some sanity cleanup after headers
	$headers =~ s/[\r\n]+$//;

	$headers = $self->_search_replace($headers, $params);
	$body = $self->_search_replace($body, $params);
	if ($self->{tracking}) {
		$body = $self->_add_tracking($body, $params->{$self->{id}}, $self->{template_id}, $self->{base_url});
	}

	# sanitize headers
	# first strip out \r
	$headers =~ s/\r//;

	# strip out encoding header
	$headers =~ s/^Content-Transfer-Encoding:.*?$//mi;
	$headers =~ s/^Date:.*?$//mi;
	$headers =~ s/^Message-Id:.*?//mi;

	$headers =~ s/\n\n/\n/g;

	$headers .= "\nMessage-ID: " . Email::MessageID->new->in_brackets;

	$headers .= "\nDate: " . email_date();

	$headers .= "\nContent-Transfer-Encoding: quoted-printable";

	# fix up \r\n for headers
	$headers =~ s/\n/\r\n/g;

	$body = encode_qp($body, "\r\n");

	# clean up some ugliness in QP
	$body =~ s/=20/ /g;
	$body =~ s/ =\r\n/ \r\n/g;

	return $headers . "\r\n\r\n" . $body;
}
1;
