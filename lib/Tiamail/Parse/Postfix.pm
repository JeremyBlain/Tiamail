package Tiamail::Parse::Postfix;

use strict;
use warnings;

use base qw( Tiamail::Parse::File );

sub read_line {
	my $self = shift;
	my $line = shift;

	# Success :
	# Mar 15 04:10:11 server postfix/smtp[2756]: 0B4797E2E: to=<to@example.com>, relay=gmail-smtp-in.l.google.com[74.125.142.27], delay=1, status=sent (250 2.0.0 OK 1363335073 fn5si1865101igc.56 - gsmtp)
	#
	# Errors :
	# Jun  8 06:26:31 1 postfix-smtp3/smtp[459]: CBD4C166F14: to=<treyr33@yahoo.com>, relay=mta7.am0.yahoodns.net[63.250.192.46]:25, delay=1.2, delays=0.1/0/0.25/0.82, dsn=5.0.0, status=bounced (host mta7.am0.yahoodns.net[63.250.192.46] said: 554 delivery error: dd Sorry your message to treyr33@yahoo.com cannot be delivered. This account has been disabled or discontinued [#102]. - mta1603.mail.gq1.yahoo.com (in reply to end of DATA command))
	# Jun  8 06:27:18 1 postfix/error[1119]: F30B1167389: to=<sadasdfhgs@gmaill.com>, relay=none, delay=17277, delays=17277/0.01/0/0.01, dsn=4.4.3, status=deferred (delivery temporarily suspended: Host or domain name not found. Name service error for name=gmaill.com type=MX: Host not found, try again)
	# Sep  8 13:31:19 1 postfix-smtp6/smtp[1907]: CB577161F3A: host d48458a.ess.barracudanetworks.com[64.235.150.197] refused to talk to me: 451 Server too busy, try again later
	# Sep 10 16:06:52 1 postfix-smtp7/smtp[21111]: DE674161C4F: host mx1.safe-mail.net[212.29.227.74] refused to talk to me: 421 Too many connections
	# Sep 10 17:06:37 1 postfix-smtp3/smtp[22902]: ED41A16212E: to=<faustinalove@facebook.com>, relay=msgin.t.facebook.com[66.220.159.18]:25, delay=155720, delays=155719/0.01/0.22/0.18, dsn=4.7.1, status=deferred (host msgin.t.facebook.com[66.220.159.18] said: 421 4.7.1 RCP-T4 http://postmaster.facebook.com/response_codes?ip=65.39.225.213#unavailable Recipient account is unavailable (in reply to RCPT TO command))
	# Sep 10 21:46:14 1 postfix-smtp6/smtp[31064]: 9DCD3161D91: host mta7.am0.yahoodns.net[66.196.118.34] said: 451 4.3.2 Internal error reading data (in reply to MAIL FROM command)

	return unless $line =~ m#\bpostfix\b.*/(?:smtp|error)\b.*?to=<([^>]+)>.*?\bstatus=(sent|bounced|deferred|expired)\b#;

	if ($2 eq 'sent') {
		$self->record_email_success(email => $1);
	}
	else {
		if ($2 eq 'bounced' || $2 eq 'expired') {
			$self->record_email_hard_bounce(email => $1);
		}
		elsif ($2 eq 'deferred') {
			$self->record_email_soft_bounce(email => $1);
		}

		if ($line =~ /\b(?:me|said): (\d+)/) {
			$self->record_email_error($1);
		}
	}
}


1; 
