use strict;
use warnings;

use Tags::HTML::Tree::Manager;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Tags::HTML::Tree::Manager::VERSION, 0.01, 'Version.');
