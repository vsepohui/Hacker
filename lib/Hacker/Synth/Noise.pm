package Hacker::Synth::Noise;

use 5.022;
use warnings;

use base 'Hacker::Synth';


sub generate {
	my $class  = shift;
	return rand();
}

1;
