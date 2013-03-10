package Tiamail::ListGenerator;

use strict;
use warnings;

use base qw( Tiamail::Base );

sub new {
	my $class = shift;
	my $self = $class->SUPER::new(@_);

	$self->_init();

	return $self;	
}


=item _init

Initialize (make connections, open files, ect).

Prepare to go.  At this point $self->{args} should be available with all parameters.

Selectors should override this method, and die if anything fails here.

=cut

sub _init {
	my $self = shift;
	die ref($self) . "should override _init";
}

1;
