package Tiamail::MTA::SMTP;

use strict;
use warnings;

use Net::SMTP;

use base qw( Tiamail::MTA );

sub _init {
	my $self = shift;
	unless ($self->{args}->{hosts} && ref($self->{args}->{hosts}) eq 'ARRAY') {
		die "hosts argument required";
	}
}

sub send {
	my ($self, $from, $to, $message) = @_;
	unless ($self->{_init}) {
		$self->_init();
	}
	my $entry = int(rand(@{ $self->{args}->{hosts} }));
	my $smtp = Net::SMTP->new( $self->{args}->{hosts}->[$entry] );
	$smtp->mail($from);
	$smtp->to($to);
	$smtp->data();
	$smtp->datasend($message);
	$smtp->dataend();
	$smtp->quit();
}


1;
