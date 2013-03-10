use strict;
use warnings;

use lib "../lib";

use Tiamail::Selector::MySQL;
use Tiamail::Filter::File;
use Tiamail::Seed::File;
use Tiamail::Seed::MySQL;
use Tiamail::Filter::MySQL;

# select our addresses
my $selector = Tiamail::Selector::MySQL->new(
	database => 'general',
	host => 'localhost',
	port => '3306',
	user => 'edate',
	pass => 'foobar',
	query => 'select email,nick_name from Profile order by id asc limit 50',
);

# filter them based on a list of email addresses that should not be mailed
my $filter = Tiamail::Filter::File->new(
	file => './filter.txt',
	field => 'email'
);

# filter some more based on mysql query, use query params 
# this should strip out 10@10.com to 14@14.com
my $myfilter = Tiamail::Filter::MySQL->new(
	database => 'general',
	host => 'localhost',
	port => 3306,
	user => 'edate',
	pass => 'foobar',
	query => 'select email from Profile where id >= ? AND id <= ?',
	query_params => [ 1501580, 1501584 ],
	field => 'email'
);

# seed the resulting list, use the lst record in the list for our template data
my $seed = Tiamail::Seed::File->new(
	file => './seed.txt',
	field => 'email',
	record => 'last'
);

# mysql seed list, use the first record in the list as our template data
my $myseed = Tiamail::Seed::MySQL->new(
	database => 'general',
	host => 'localhost',
	port => 3306,
	user => 'edate',
	pass => 'foobar',
	query => 'select email from Profile order by id asc limit 100,10',
	field => 'email',
	record => 'first'
);

# execute the selector, getting a reference to a list
my $list = $selector->execute();

# filter the list
$list = $filter->filter($list);

# filter some more via mysql

$list = $myfilter->filter($list);

# filter via mysql single queries (transactional style mailers)

#$list = $mytransfilter->filter($list);

# seed it via a file
$list = $seed->seed($list);

# seed it some more from mysql
$list = $myseed->seed($list);

foreach my $entry (@{ $list }) {
	printf("%s => %s\n", $entry->{email}, $entry->{nick_name});
}

