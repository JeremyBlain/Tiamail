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


sub prepare {
	my $self = shift;
	# not much to prepare in this one, we're just working with strings
	$self->{body} = Tiamail::Util::slurp_file(Tiamail::Config::get('content_dir') . '/' . $self->{args}->{body});
	$self->{headers} = Tiamail::Util::slurp_file(Tiamail::Config::get('content_dir') . '/' . $self->{args}->{headers});

	unless ($self->{body} && $self->{headers}) {
		die ref($self) . " requires arguments of body and headers";
	}
}

1;
