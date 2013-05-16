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

record_email_send(
	id => $id, 
	template_id => $template, 
	mta_id => $mta_id,
	email => $email)

record_email_open(
	id => $id, 
	template_id => $template, 
	ip => $ip)

record_email_click(
	id => $id, 
	template_id => $template, 
	ip => $ip)

=cut


sub record_email_hard_bounce {
	die "record_email_hard_bounce";
}
sub record_email_soft_bounce {
	die "record_email_soft_bounce";
}
sub record_email_success {
	die "record_email_success";
}
sub record_email_send {
	die "record_email_send";
}
sub record_email_open {
	die "record_email_open";
}
sub record_email_click {
	die "record_email_click";
}

1;
