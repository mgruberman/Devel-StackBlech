package Devel::StackBlech;

use warnings;
use strict;

=head1 NAME

Devel::StackBlech - Dumps your stack, all of it, somewhere

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.03';

require DynaLoader;
our @ISA = 'DynaLoader';
DynaLoader::bootstrap( __PACKAGE__ );

sub dl_load_flags { 0x01 }

use Sub::Exporter -setup => { exports => [qw[ dumpStack ]] };






=head1 FUNCTIONS

=over

=item stackBlech()

Dumps your stack to C<Perl_debug_log> which is usually pointed at
STDERR. Happens to also display DB::sub calls which are normally
invisible. Please hack on this if you want more features. Commit bits
are handed out freely.

=cut






=head1 AUTHOR

The internet. Kthxbai.






=head1 BUGS

Please report any bugs or feature requests to C<bug-devel-stackblech
at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Devel-StackBlech>.  I
will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.





=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Devel::StackBlech

You can also look for information at:

=over

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Devel-StackBlech>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Devel-StackBlech>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Devel-StackBlech>

=item * Search CPAN

L<http://search.cpan.org/dist/Devel-StackBlech>

=back






=head1 ACKNOWLEDGEMENTS





=head1 COPYRIGHT & LICENSE

Copyright 2008 Joshua ben Jore, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

() = -.0
