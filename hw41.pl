use strict;
use warnings;
use PerlIO::via::Numerator;
$\="\n";
open(my $in,">:via(Numerator)",'newtext.txt');
open(my $in2,"<:via(Numerator)",'newtext.txt');
