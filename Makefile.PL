use lib '.';
use strict;
use warnings;

use inc::Module::Install;

# Definition.
abstract 'Tags helper for tree manager.';
author 'Michal Josef Spacek <skim@cpan.org>';
author_requires 'English' => 0;
author_requires 'File::Object' => 0.03;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
license 'bsd';
name 'Tags-HTML-Tree-Manager';
readme_from 'Manager.pm';
recursive_author_tests('xt');
requires 'Class::Utils' => 0.02;
requires 'Error::Pure' => 0.07;
requires 'Scalar::Util' => 0;
requires 'Tags::HTML' => 0;
requires 'perl' => '5.8.0';
resources 'bugtracker' => 'https://github.com/michal-josef-spacek/Tags-HTML-Tree-Manager/issues';
resources 'homepage' => 'https://github.com/michal-josef-spacek/Tags-HTML-Tree-Manager';
resources 'repository' => 'git://github.com/michal-josef-spacek/Tags-HTML-Tree-Manager';
test_requires 'CSS::Struct::Output::Indent' => 0;
test_requires 'English' => 0;
test_requires 'Error::Pure::Utils' => 0;
test_requires 'Tags::Output::Indent' => 0;
test_requires 'Tags::Output::Raw' => 0;
test_requires 'Test::MockObject' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Tree' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
