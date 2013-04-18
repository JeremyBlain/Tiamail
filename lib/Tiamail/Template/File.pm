package Tiamail::Template::File;

use strict;
use warnings;

use base qw( Tiamail::Template::SearchReplace Tiamail::Template );

=doc 

File based Tiamail template

Requires arguments of:

body => the file for the body of the email
headers => the file for the headers of the email
template_id => the identifier for this template
base_url => the base url for tracking purposes
id => the field in the params that uniquely identifies the user.  
tracking => 1 or 0 should we add tracking.

Replacement is handled via Tiamail::Template::SearchReplace methods

=cut


sub prepare {
	my $self = shift;
	# not much to prepare in this one, we're just working with strings
	$self->{body} = Tiamail::Util::slurp_file(Tiamail::Config::get('content_dir') . '/' . $self->{args}->{body});
	$self->{headers} = Tiamail::Util::slurp_file(Tiamail::Config::get('content_dir') . '/' . $self->{args}->{headers});
	$self->{template_id} = $self->{args}->{template_id};
	$self->{base_url} = $self->{args}->{base_url};
	$self->{id} = $self->{args}->{id};
	$self->{tracking} = $self->{args}->{tracking};

	unless ($self->{body} && $self->{headers}) {
		die ref($self) . " requires arguments of body and headers";
	}
	unless ($self->{template_id}) {
		die ref($self) . " requires template_id argument";
	}
	unless ($self->{base_url}) {
		die ref($self) . " requires base_url argument";
	}
	unless ($self->{id}) {
		die ref($self) . " requires id argument";
	}
}

1;
