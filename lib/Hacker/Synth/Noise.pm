package Hacker::Synth::Noise;

use 5.022;
use warnings;

use base 'Hacker::Synth';

use Hacker::Random;


sub generate {
	my $class  = shift;
	#return (Hacker::Random::rand() - 0.5)*2;
	return (rand()-0.5)*2;
}

1;
