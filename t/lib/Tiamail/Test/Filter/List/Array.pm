package Tiamail::Test::Filter::List::Array;

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
	use_ok( 'Tiamail::Filter::List::Array' );
	isa_ok(Tiamail::Filter::List::Array->new( list => [ 'a@a.com' ], field => 'email' ), 'Tiamail::Filter::List::Array' ) or $self->BAILOUT('new failed!');
};

sub filter : Test(3) {
	my $self = shift;
	my $t = Tiamail::Filter::List::Array->new( 
		list => [ 'a@a.com' ],
		field => 'email',
	);
	ok($t->filter($self->{list})->[0]->{email} eq 'b@b.com', 'filter 1 address works');
	
	$t = Tiamail::Filter::List::Array->new( 
		list => [ 'd@d.com', 'e@e.com' ],
		field => 'email',
	);
	ok($t->filter($self->{list})->[3]->{email} eq 'F@F.com', 'filter 2 address works');

	$t = Tiamail::Filter::List::Array->new( 
		list => [ 'd@d.com', 'e@e.com', 'f@f.com' ],
		field => 'email',
	);
	ok($t->filter($self->{list})->[3]->{email} eq 'G@G.com', 'case insentivity works');
};
1;
