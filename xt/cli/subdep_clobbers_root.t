use strict;
use Test::More;
use lib ".";
use xt::CLI;

subtest 'sub dependencies clobbers root requirements' => sub {
    my $app = cli();

    $app->write_cpanfile(<<EOF);
requires 'Cookie::Baker';
requires 'URI';
EOF

    $app->run("install");

    $app->run("show", "URI");
    unlike $app->stderr, qr/Can't find a module named 'URI'/;
};

done_testing;
