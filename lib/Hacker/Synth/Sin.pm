package Hacker::Synth::Sin;

use 5.022;
use warnings;

use base 'Hacker::Synth';


sub generate {
	my $class  = shift;
	my $offset = shift;
	
	return sin($offset);
}

1;
