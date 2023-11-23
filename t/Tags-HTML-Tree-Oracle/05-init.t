use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Tree::Oracle;
use Tags::Output::Indent;
use Test::MockObject;
use Test::More 'tests' => 5;
use Test::NoWarnings;
use Tree;

# Test.
#my $tags = Tags::Output::Indent->new;
#my $tree = Tree->new;
#my $obj = Tags::HTML::Tree::Oracle->new(
#	'tags' => $tags,
#);
#$obj->init($tree);

# Test.
my $tags = Tags::Output::Indent->new;
my $tree = Tree->new;
$tree->meta({
	'id' => 1,
	'parent' => '',
});
my $obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
my $ret = $obj->init($tree);
is($ret, undef, 'Right init.');

# Test.
$tags = Tags::Output::Indent->new;
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->init('bad');
};
is($EVAL_ERROR, "Data object for tree is not valid.\n",
	"Data object for tree is not valid (bad).");
clean();

# Test.
$tags = Tags::Output::Indent->new;
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->init(Test::MockObject->new);
};
is($EVAL_ERROR, "Data object for tree is not valid.\n",
	"Data object for tree is not valid (bad object).");
clean();

# Test.
$tags = Tags::Output::Indent->new;
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->init;
};
is($EVAL_ERROR, "Data object for tree is not valid.\n",
	"Data object for tree is not valid (undef).");
clean();
