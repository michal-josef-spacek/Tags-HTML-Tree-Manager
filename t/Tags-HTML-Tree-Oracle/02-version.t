use strict;
use warnings;

use Tags::HTML::Tree::Oracle;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Tags::HTML::Tree::Oracle::VERSION, 0.01, 'Version.');
