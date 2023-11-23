package Tags::HTML::Tree::Oracle;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use Scalar::Util qw(blessed);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my ($object_params_ar, $other_params_ar) = split_params(
		['css_tree', 'title'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	# CSS style for tree.
	$self->{'css_tree'} = 'tree';

	# Title.
	$self->{'title'} = 'Tree Manager';

	# Process params.
	set_params($self, @{$object_params_ar});

	# Object.
	return $self;
}

sub _cleanup {
	my $self = shift;

	delete $self->{'_tree'};

	return;
}

sub _init {
	my ($self, $tree) = @_;

	return $self->_set_tree($tree);
}

sub _prepare {
	my ($self, $tree) = @_;

	return $self->_set_tree($tree);
}

# Process 'Tags'.
sub _process {
	my $self = shift;

	if (! exists $self->{'_tree'}) {
		return;
	}

	$self->{'tags'}->put(
		['b', 'div'],
		['a', 'class', $self->{'css_tree'}],

		['b', 'h2'],
		['d', $self->{'title'}],
		['e', 'h2'],

		['b', 'h3'],
		['d', 'Current Tree:'],
		['e', 'h3'],

		['b', 'table'],

		['b', 'tr'],
		['b', 'th'],
		['d', 'Depth'],
		['e', 'th'],
		['b', 'th'],
		['d', 'Tree Nodes'],
		['e', 'th'],
		['e', 'tr'],
	);
	my $trees_to_process = [$self->{'_tree'}];
	my $depth = 0;
	while (@{$trees_to_process}) {
		my @new_trees;
		$self->{'tags'}->put(
			['b', 'tr'],
			['b', 'td'],
			['d', $depth],
			['e', 'td'],

			['b', 'td'],
		);
		foreach my $tree (@{$trees_to_process}) {
			$self->{'tags'}->put(
				['d', $self->_print_node($tree)],
			);
			push @new_trees, $tree->children;
		}
		$self->{'tags'}->put(
			['e', 'td'],
			['e', 'tr'],
		);
		$trees_to_process = \@new_trees;
		$depth++;
	}
	$self->{'tags'}->put(
		['e', 'table'],

		# Form.
		['b', 'form'],
		['a', 'method', 'post'],
		['d', 'Add Node To:'],

		['d', '&nbsp;'],

		['b', 'input'],
		['a', 'type', 'text'],
		['a', 'id', 'pid'],
		['a', 'name', 'pid'],
		['a', 'placeholder', 'PID'],
		['e', 'input'],

		['b', 'br'],
		['e', 'br'],

		['b', 'input'],
		['a', 'type', 'submit'],
		['a', 'id', 'add'],
		['a', 'name', 'add'],
		['a', 'value', 'Add'],
		['e', 'input'],

		['e', 'form'],

		['e', 'div'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	$self->{'css'}->put(
		['s', '.'.$self->{'css_tree'}],
		['d', 'padding', '0.5em'],
		['d', 'border', '1px solid black'],
		['e'],

		['s', '.'.$self->{'css_tree'}.' h2'],
		['d', 'text-align', 'center'],
		['e'],

		['s', '.'.$self->{'css_tree'}.' table'],
		['d', 'margin', '1em'],
		['e'],

		['s', '.'.$self->{'css_tree'}.' table'],
		['s', '.'.$self->{'css_tree'}.' th'],
		['s', '.'.$self->{'css_tree'}.' td'],
		['d', 'border', '1px solid black'],
		['d', 'border-collapse', 'collapse'],
		['e'],

		['s', '.'.$self->{'css_tree'}.' td'],
		['s', '.'.$self->{'css_tree'}.' th'],
		['d', 'padding', '0.5em'],
		['e'],

		['s', '.'.$self->{'css_tree'}.' th'],
		['d', 'font-weight', 'bold'],
		['e'],
	);

	return;
}

sub _set_tree {
	my ($self, $tree) = @_;

	if (! defined $tree || ! blessed($tree) || ! $tree->isa('Tree')) {
		err 'Data object for tree is not valid.';
	}

	$self->{'_tree'} = $tree;

	return;
}

sub _print_node {
	my ($self, $tree) = @_;

	my $parent = $tree->meta->{'parent'};
	if ($parent eq '') {
		$parent = 'NONE';
	}

	my $id = $tree->meta->{'id'};

	return '[P: '.$parent.' ID: '.$id.']';
}

1;
