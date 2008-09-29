#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Devel::StackBlech' );
}

diag( "Testing Devel::StackBlech $Devel::StackBlech::VERSION, Perl $], $^X" );
