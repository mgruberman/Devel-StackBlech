use strict;
use warnings;
use ExtUtils::MakeMaker;
use 5.006_000; # at least.

WriteMakefile(
    NAME                => 'Devel::StackBlech',
    AUTHOR              => 'Joshua ben Jore <jjore@cpan.org>',
    VERSION_FROM        => 'lib/Devel/StackBlech.pm',
    ABSTRACT_FROM       => 'lib/Devel/StackBlech.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'        => 0,
        'Sub::Exporter'     => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Devel-StackBlech-*' },
);
