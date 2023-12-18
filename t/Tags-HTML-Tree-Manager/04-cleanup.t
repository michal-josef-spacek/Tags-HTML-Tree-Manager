use strict;
use warnings;

use Tags::HTML::Tree::Manager;
use Tags::Output::Indent;
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Tree;

# Test.
my $tags = Tags::Output::Indent->new;
my $tree = Tree->new;
$tree->meta({
	'id' => 1,
	'parent' => '',
});
my $obj = Tags::HTML::Tree::Manager->new(
	'tags' => $tags,
);
my $ret = $obj->init($tree);
# XXX Internal structure.
is(ref $obj->{'_tree'}, 'Tree', 'Internal structure set.');
$obj->cleanup;
is($obj->{'_tree'}, undef, 'Internal structure cleaned.');
