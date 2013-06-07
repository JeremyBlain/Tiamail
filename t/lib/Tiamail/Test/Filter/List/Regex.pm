package Tiamail::Test::Filter::List::Regex;

use strict;
use warnings;

use base qw( Test::Class );
use Test::More;

sub before : Test(startup) {
	my $self = shift;
	$self->{list} = [ 
		{ email => 'a@a.com'},
		{ email => 'b@b.com'},
		{ email => 'c@c.com'},
		{ email => 'd@d.com'},
		{ email => 'e@e.com'},
		{ email => 'F@F.com'},
		{ email => 'G@G.com'},
		{ email => 'H@H.com'},
		{ email => 'I@I.com'},
		{ email => 'J@J.com'},
	];
}

sub _new : Test(2) {
	my $self = shift;
	use_ok( 'Tiamail::Filter::List::Regex' );
	isa_ok(Tiamail::Filter::List::Regex->new( patterns => [ 'a@a.com' ], field => 'email' ), 'Tiamail::Filter::List::Regex' ) or $self->BAILOUT('new failed!');
};

sub filter : Test(5) {
	my $self = shift;
	my $t = Tiamail::Filter::List::Regex->new( 
		patterns => [ 'a@a.com' ],
		field => 'email',
	);
	ok($t->filter($self->{list})->[0]->{email} eq 'b@b.com', 'filter 1 address works');
	
	$t = Tiamail::Filter::List::Regex->new( 
		patterns => [ 'd@d.com', 'e@e.com' ],
		field => 'email',
	);
	ok($t->filter($self->{list})->[3]->{email} eq 'F@F.com', 'filter 2 address works');

	$t = Tiamail::Filter::List::Regex->new( 
		patterns => [ 'com' ],
		field => 'email',
	);
	ok(!exists($t->filter($self->{list})->[0]), 'cleared list');

	$t = Tiamail::Filter::List::Regex->new( 
		patterns => [ '^[abcd]' ],
		field => 'email',
	);
	ok($t->filter($self->{list})->[0]->{email} eq 'e@e.com', 'filter pattern ^[abcd] works');

	$t = Tiamail::Filter::List::Regex->new( 
		patterns => [ '[abcd]' ],
		field => 'email',
	);
	ok(!exists($t->filter($self->{list})->[0]), 'filter pattern [abcd] works');


};
1;
