package Tiamail::Recorder;

use strict;
use warnings;

use base qw( Tiamail::Base );


=doc

A recorder is intended to allow write back of events from Tiamail into either a statistics system
or custom systems or both.

The following events should be handled by a recorder:


record_email_hard_bounce($email)

record_email_soft_bounce($email)

record_email_success($email)

record_email_send($id, $template)

record_email_open($id, $template)

record_email_click($id, $template)

=cut


sub record_email_hard_bounce {
}
sub record_email_soft_bounce {
}
sub record_email_success {
}
sub record_email_send {
}
sub record_email_open {
}
sub record_email_click {
}

1;
