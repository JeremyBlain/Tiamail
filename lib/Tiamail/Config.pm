package Tiamail::Config;

use strict;
use warnings;

=doc

Simple configuration module.

TODO:

Eventually rework to wrap around a more generic/well thought out configuration tool from CPAN

=cut

my $CONF = {
	base_dir => '/home/jeremy/devel/Tiamail',
	lib_dir => '/home/jeremy/devel/Tiamail/lib',
	content_dir => '/home/jeremy/devel/Tiamail/work/content',
	data_dir => '/home/jeremy/devel/Tiamail/work/data',
};

# get the value
sub get {
	my $key = shift;
	return $CONF->{$key};
}	

1;
