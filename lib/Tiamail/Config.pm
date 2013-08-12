package Tiamail::Config;

use strict;
use warnings;

=doc

Simple configuration module.

TODO:

Eventually rework to wrap around a more generic/well thought out configuration tool from CPAN

=cut

my $BASE = $ENV{TIAMAIL_HOME} ? $ENV{TIAMAIL_HOME} : $ENV{HOME};

my $CONF = {
	base_dir => $BASE,
	content_dir => $BASE . '/content',
	data_dir => $BASE . '/data',
	temp_dir => $BASE . '/tmp',
};

foreach my $key (keys %{ $CONF }) {
	unless (-d get($key) && -r get($key)) {
		die get($key) . " is not a directory readable by the current user";
	}
} 

# get the value
sub get {
	my $key = shift;
	return $CONF->{$key};
}	

1;
