use strict;
use warnings;

use Tags::HTML::Tree::Manager;
use Tags::Output::Indent;
use Test::More 'tests' => 4;
use Test::NoWarnings;
use Tree;

# Test.
#my $tags = Tags::Output::Indent->new;
#my $tree = Tree->new;
#my $obj = Tags::HTML::Tree::Manager->new(
#	'tags' => $tags,
#);
#$obj->init($tree);
#$obj->process;
#my $ret = $tags->flush(1);
#my $right_ret = <<'END';
#END
#chomp $right_ret;
#is($ret, $right_ret, 'Blank tree.');

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
$obj->init($tree);
$obj->process;
my $ret = $tags->flush(1);
my $right_ret = <<'END';
<div class="tree">
  <h2>
    Tree Manager
  </h2>
  <h3>
    Current Tree:
  </h3>
  <table>
    <tr>
      <th>
        Depth
      </th>
      <th>
        Tree Nodes
      </th>
    </tr>
    <tr>
      <td>
        0
      </td>
      <td>
        [P: NONE ID: 1]
      </td>
    </tr>
  </table>
  <form method="post">
    Add Node To:
    &nbsp;
    <input type="text" id="pid" name="pid" placeholder="PID">
    </input>
    <br>
    </br>
    <input type="submit" id="add" name="add" value="Add">
    </input>
  </form>
</div>
END
chomp $right_ret;
is($ret, $right_ret, 'Only root tree.');

# Test.
$tags = Tags::Output::Indent->new;
$tree = Tree->new;
$tree->meta({
	'id' => 1,
	'parent' => '',
});
my $subtree1 = Tree->new;
$subtree1->meta({
	'id' => 2,
	'parent' => 1,
});
$tree->add_child($subtree1);
my $subtree2 = Tree->new;
$subtree2->meta({
	'id' => 3,
	'parent' => 1,
});
$tree->add_child($subtree2);
$obj = Tags::HTML::Tree::Manager->new(
	'tags' => $tags,
);
$obj->init($tree);
$obj->process;
$ret = $tags->flush(1);
$right_ret = <<'END';
<div class="tree">
  <h2>
    Tree Manager
  </h2>
  <h3>
    Current Tree:
  </h3>
  <table>
    <tr>
      <th>
        Depth
      </th>
      <th>
        Tree Nodes
      </th>
    </tr>
    <tr>
      <td>
        0
      </td>
      <td>
        [P: NONE ID: 1]
      </td>
    </tr>
    <tr>
      <td>
        1
      </td>
      <td>
        [P: 1 ID: 2]
        [P: 1 ID: 3]
      </td>
    </tr>
  </table>
  <form method="post">
    Add Node To:
    &nbsp;
    <input type="text" id="pid" name="pid" placeholder="PID">
    </input>
    <br>
    </br>
    <input type="submit" id="add" name="add" value="Add">
    </input>
  </form>
</div>
END
chomp $right_ret;
is($ret, $right_ret, 'Root tree with two children.');

# Test.
$tags = Tags::Output::Indent->new;
$tree = Tree->new;
$tree->meta({
	'id' => 1,
	'parent' => '',
});
$obj = Tags::HTML::Tree::Manager->new(
	'tags' => $tags,
);
$obj->process;
$ret = $tags->flush(1);
$right_ret = <<'END';
END
chomp $right_ret;
is($ret, $right_ret, 'No init, blank output.');
