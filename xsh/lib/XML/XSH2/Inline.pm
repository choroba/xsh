# $Id: Inline.pm,v 1.2 2004-12-02 17:52:07 pajas Exp $

package XML::XSH2::Inline;

use vars qw($VERSION $terminator);

use strict;
use XML::XSH2 qw();
$VERSION = '0.1';
$terminator = undef;

use Filter::Simple;

sub filter {
  my $t=defined($terminator) ? $terminator : '__END__';
  s/$terminator\s*$// if defined($terminator);
  $_="XML::XSH2::xsh(<<'$t');\n".$_."$t\n";
  $_;
};

FILTER(\&filter);

1;

=head1 NAME

XML::XSH2::Inline - Insert XSH commands directly into your Perl scripts

=head1 SYNOPSIS

   # perl code

   use XML::XSH2::Inline;

   # XSH Language commands (see L<XSH>)

   no XML::XSH2::Inline;

   # perl code

=head1 REQUIRES

Filter::Simple, XML::XSH2

=head1 EXPORTS

None.

=head1 AUTHOR

Petr Pajas, pajas@matfyz.cz

=head1 SEE ALSO

L<xsh>, L<XSH>, L<XML::XSH2>

=cut
