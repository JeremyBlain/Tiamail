package Tiamail::Sender::SMTP;

use strict;
use warnings;

sub send {
	my ($self, $data, $ips, $message) = @_;
	my $entry = int(rand(@{ $ips }));
	my $smtp = Net::SMTP->new( $ips->{rand} );
	$smtp->mail($data->{from});
	$smtp->to($data->{to});
	$smtp->data()
	$smtp->datasend($data->{email});
	$smtp->dataend();
}


1;
