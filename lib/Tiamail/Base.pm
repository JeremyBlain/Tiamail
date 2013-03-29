package Tiamail::Base;

use strict;
use warnings;

use Tiamail::Conf;

=item new

Basic new method with args

=cut

sub new {
	my $class = shift;
	my %args = @_;
	my $self = {};
	$self->{args} = \%args;
	bless($self, $class);

	return $self;	
}


1;
