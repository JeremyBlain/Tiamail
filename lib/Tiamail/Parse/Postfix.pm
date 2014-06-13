package Tiamail::Parse::Postfix;

use strict;
use warnings;

use base qw( Tiamail::Parse::File );

# Mar 15 04:10:11 server postfix/smtp[2756]: 0B4797E2E: to=<to@example.com>, relay=gmail-smtp-in.l.google.com[74.125.142.27], delay=1, status=sent (250 2.0.0 OK 1363335073 fn5si1865101igc.56 - gsmtp)

sub read_line {
	my $self = shift;
	my $line = shift;
	
	# Mar 15 04:10:11 server postfix/smtp[2756]: 0B4797E2E: to=<to@example.com>, relay=gmail-smtp-in.l.google.com[74.125.142.27], delay=1, status=sent (250 2.0.0 OK 1363335073 fn5si1865101igc.56 - gsmtp)
	# Jun  8 06:26:31 1 postfix-smtp3/smtp[459]: CBD4C166F14: to=<treyr33@yahoo.com>, relay=mta7.am0.yahoodns.net[63.250.192.46]:25, delay=1.2, delays=0.1/0/0.25/0.82, dsn=5.0.0, status=bounced (host mta7.am0.yahoodns.net[63.250.192.46] said: 554 delivery error: dd Sorry your message to treyr33@yahoo.com cannot be delivered. This account has been disabled or discontinued [#102]. - mta1603.mail.gq1.yahoo.com (in reply to end of DATA command))
	# Jun  8 06:27:18 1 postfix/error[1119]: F30B1167389: to=<sadasdfhgs@gmaill.com>, relay=none, delay=17277, delays=17277/0.01/0/0.01, dsn=4.4.3, status=deferred (delivery temporarily suspended: Host or domain name not found. Name service error for name=gmaill.com type=MX: Host not found, try again)

	return unless $line =~ m#\bpostfix\b.*/(?:smtp|error)\b.*?to=<([^>]+)>.*?\bstatus=(sent|bounced|deferred|expired)\b#;

	if ($2 eq 'bounced' || $2 eq 'expired') {
		$self->record_email_hard_bounce($1);
	}
	elsif ($2 eq 'deferred') {
		$self->record_email_soft_bounce($1);
	}
	elsif ($2 eq 'sent') {
		$self->record_email_success($1);
	}
}


1; 
