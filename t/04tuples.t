use Test::More tests => 17;
use strict;

use_ok('Python::Serialise::Pickle');

ok(my $ps = Python::Serialise::Pickle->new('t/tuples'));


is_deeply($ps->load,[1, 2, 4], "simple");
is_deeply($ps->load,['spam', 'eggs', 100, 123], "mixed");
is_deeply($ps->load, [1, 2, ['a','b',['one','two']]], "deeply nested");
is_deeply($ps->load, [1, 2, ['a','b',['one','two']]], "rpeatedly nested");

ok(my $pw = Python::Serialise::Pickle->new('>t/tmp'));


ok($pw->dump([1, 2, 4]), "write simple");
ok($pw->dump(['spam', 'eggs', 100, 1234]), "write mixed");
ok($pw->dump([1, 2, ['a','b',['one','two']]]), "write deeply nested");
ok($pw->dump( [1, 2, ['a','b',['one','two']]]), "write deeply nested again");

ok($pw->close);

ok(my $pr = Python::Serialise::Pickle->new('t/tmp'));

is_deeply($pr->load,[1, 2, 4], "dogfood simple");
is_deeply($pr->load,['spam', 'eggs', 100, 1234], "dogfood mixed");
is_deeply($pr->load, [1, 2, ['a','b',['one','two']]], "dogfood deeply");
is_deeply($pr->load, [1, 2, ['a','b',['one','two']]], "dogfood deeply again");

