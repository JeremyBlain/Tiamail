package Tiamail::Template;

use strict;
use warnings;

use base qw( Tiamail::Base );

=doc


templates should expose one function:

render($id, $template_id, $base_url, $track, \%params)

$id should be a unique identifier to the user we are emailing.  This can be the email address or another identifier that should be unique to the user.

$template_id should be a unique identifier to the template we are using.  

$base_url is the base url of our tracking server.

$track is a true/false value on whether tracking links should be included.

\%params is a hashref containing data for the template to search/replace or otherwise use in personalization.

The template may provide defaults for some personalization values.

Any personalization value that does not have a default and is not provided in %params should cause the template to die rather than render brokenly.


example:
render(26, 'foo_template', 'http://tiamail.example/', 0, $mysql_row_hashref);


Tracking:

If $tracking is true, the template should be sure to:

modify the body to add:
<img src="http://tiamail.example/x.gif/26/foo_template"/>

change any hrefs to be modified:

<a href="http://tiamail.example/r/26/foo_template/http://my.website.example/">

TODO: url modification options

=cut

sub _init {
	my $self = shift;

	unless ($self->{args}->{body}) {
		die "templates must have a body";
	}
	unless ($self->{args}->{headers}) {
		die "templates must have headers";
	}
}

sub render {
	my $self = shift;
	die "templates must provide a render function";
}

1;
