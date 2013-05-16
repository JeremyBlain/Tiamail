package Tiamail::Recorder::Null;

use strict;
use warnings;

use base qw( Tiamail::Recorder );

=doc

Null recorder.  Does nothing.

=cut

sub record_email_hard_bounce {
	return 1;
}
sub record_email_soft_bounce {
	return 1;
}
sub record_email_success {
	return 1;
}
sub record_email_send {
	return 1;
}
sub record_email_open {
	return 1;
}
sub record_email_click {
	return 1;
}
1;
