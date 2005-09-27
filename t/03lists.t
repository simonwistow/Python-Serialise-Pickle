use Test::More tests => 14;
use strict;

use_ok('Python::Serialise::Pickle');

ok(my $ps = Python::Serialise::Pickle->new('t/lists'), "open");


is_deeply($ps->load,[1, 2, 4], "simple list");
is_deeply($ps->load,['spam', 'eggs', 100, 1234], "mixed list");
is_deeply($ps->load, [1, 2, ['a','b','c']], "nested list");


ok(my $pw = Python::Serialise::Pickle->new('>t/tmp'));


ok($pw->dump([1, 2, 4]),"write simple");
ok($pw->dump(['spam', 'eggs', 100, 1234]), "write mixed");
ok($pw->dump([1, 2, ['a','b','c']]), "write nested");

ok($pw->close(), "close");

ok(my $pr = Python::Serialise::Pickle->new('t/tmp'), "open for reading");


is_deeply($pr->load,[1, 2, 4],"dog food simple");
is_deeply($pr->load,['spam', 'eggs', 100, 1234], "dog food mixed");
is_deeply($pr->load, [1, 2, ['a','b','c']],"dogfodd nested");

