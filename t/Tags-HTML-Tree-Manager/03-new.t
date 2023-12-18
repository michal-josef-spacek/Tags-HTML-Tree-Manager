use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Tree::Manager;
use Tags::Output::Raw;
use Test::MockObject;
use Test::More 'tests' => 8;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::Tree::Manager->new;
isa_ok($obj, 'Tags::HTML::Tree::Manager');

# Test.
$obj = Tags::HTML::Tree::Manager->new(
	'tags' => Tags::Output::Raw->new,
);
isa_ok($obj, 'Tags::HTML::Tree::Manager');

# Test.
eval {
	Tags::HTML::Tree::Manager->new(
		'tags' => 'bad_tags',
	);
};
is($EVAL_ERROR, "Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Parameter 'tags' must be a 'Tags::Output::*' class (bad string).");
clean();

# Test.
eval {
	Tags::HTML::Tree::Manager->new(
		'tags' => 0,
	);
};
is($EVAL_ERROR, "Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Parameter 'tags' must be a 'Tags::Output::*' class (bad number).");
clean();

# Test.
my $test_obj = Test::MockObject->new;
eval {
	Tags::HTML::Tree::Manager->new(
		'tags' => $test_obj,
	);
};
is($EVAL_ERROR, "Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Parameter 'tags' must be a 'Tags::Output::*' class (bad object)");
clean();

# Test.
eval {
	Tags::HTML::Tree::Manager->new(
		'css' => 'bad_css',
	);
};
is($EVAL_ERROR, "Parameter 'css' must be a 'CSS::Struct::Output::*' class.\n",
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class (bad string).");
clean();

# Test.
eval {
	Tags::HTML::Tree::Manager->new(
		'css' => 0,
	);
};
is($EVAL_ERROR, "Parameter 'css' must be a 'CSS::Struct::Output::*' class.\n",
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class (bad number).");
clean();
