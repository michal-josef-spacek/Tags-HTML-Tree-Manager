use strict;
use warnings;

use CSS::Struct::Output::Indent;
use Tags::HTML::Tree::Oracle;
use Test::More 'tests' => 3;
use Test::NoWarnings;

# Test.
my $css = CSS::Struct::Output::Indent->new;
my $obj = Tags::HTML::Tree::Oracle->new(
	'css' => $css,
);
$obj->process_css;
my $ret = $css->flush(1);
my $right_ret = <<'END';
.tree {
	padding: 0.5em;
	border: 1px solid black;
}
.tree h2 {
	text-align: center;
}
.tree table {
	margin: 1em;
}
.tree table, .tree th, .tree td {
	border: 1px solid black;
	border-collapse: collapse;
}
.tree td, .tree th {
	padding: 0.5em;
}
.tree th {
	font-weight: bold;
}
END
chomp $right_ret;
is($ret, $right_ret, 'Fetch CSS code (default CSS class name).');

# Test.
$css = CSS::Struct::Output::Indent->new;
$obj = Tags::HTML::Tree::Oracle->new(
	'css_tree' => 'foo',
	'css' => $css,
);
$obj->process_css;
$ret = $css->flush(1);
$right_ret = <<'END';
.foo {
	padding: 0.5em;
	border: 1px solid black;
}
.foo h2 {
	text-align: center;
}
.foo table {
	margin: 1em;
}
.foo table, .foo th, .foo td {
	border: 1px solid black;
	border-collapse: collapse;
}
.foo td, .foo th {
	padding: 0.5em;
}
.foo th {
	font-weight: bold;
}
END
chomp $right_ret;
is($ret, $right_ret, 'Fetch CSS code (explicit CSS class name).');
