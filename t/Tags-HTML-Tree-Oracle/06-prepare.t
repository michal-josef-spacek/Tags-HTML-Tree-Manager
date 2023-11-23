use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Tree::Oracle;
use Tags::Output::Indent;
use Test::MockObject;
use Test::More 'tests' => 8;
use Test::NoWarnings;
use Tree;

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
my $ret = $obj->prepare($tree);
is($ret, undef, 'Right prepare.');

# Test.
$tags = Tags::Output::Indent->new;
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->prepare('bad');
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
	$obj->prepare(Test::MockObject->new);
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
	$obj->prepare(Test::MockObject->new);
};
is($EVAL_ERROR, "Data object for tree is not valid.\n",
	"Data object for tree is not valid (undef).");
clean();

# Test.
$tags = Tags::Output::Indent->new;
$tree = Tree->new;
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->prepare($tree);
};
is($EVAL_ERROR, "Tree object doesn't contain required meta data.\n",
	"Tree object doesn't contain required meta data (no metadata).");
clean();

# Test.
$tags = Tags::Output::Indent->new;
$tree = Tree->new;
$tree->meta({
	'parent' => '',
});
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->prepare($tree);
};
is($EVAL_ERROR, "Tree object doesn't contain required meta data.\n",
	"Tree object doesn't contain required meta data (only parent metadata).");
clean();

# Test.
$tags = Tags::Output::Indent->new;
$tree = Tree->new;
$tree->meta({
	'id' => '',
});
$obj = Tags::HTML::Tree::Oracle->new(
	'tags' => $tags,
);
eval {
	$obj->prepare($tree);
};
is($EVAL_ERROR, "Tree object doesn't contain required meta data.\n",
	"Tree object doesn't contain required meta data (only id metadata).");
clean();
