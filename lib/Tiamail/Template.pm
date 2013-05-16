package Tiamail::Template;

use strict;
use warnings;

use base qw( Tiamail::Base );

=doc


my $template = Tiamail::Template::File->new(
	headers => 'test/headers',
	body => 'test/body',
	template_id => 'test1',
	id => 'id',
	tracking => 1,
);

Templates should include the following arguments to new:

id => This is the key in the params that uniquely identifies a user.  It could be an email address or another field.
template_id => This is an identifier of this template.
tracking => whether to enable tracking of clicks/opens.
body => the body of the email (or as in the File example, the path to it)
headers => the headers of the email. (or as in the File example, the path to it)


Templates should expose the following function:
render(\%params)

\%params is a hashref containing data for the template to search/replace or otherwise use in personalization.



The template may provide defaults for some personalization values.

Any personalization value that does not have a default and is not provided in %params should cause the template to die rather than render brokenly.


If any module initialization is required that is not handled in new() then render should take care of it.


Tracking:

If $tracking is true, the template should be sure to:

modify the body to add:
<img src="http://tiamail.example/x.gif/26/foo_template"/>

change any hrefs to be modified:

<a href="http://tiamail.example/r/26/foo_template/http://my.website.example/">

TODO: url modification options


=cut

sub prepare {
	my $self = shift;
	die "templates should override prepare";
}

sub render {
	my $self = shift;
	
	die "templates must provide a render function";
}

1;
