package Hacker::Synth::CosPart;

use 5.022;
use warnings;

use base 'Hacker::Synth';

use Math::Trig;


sub generate {
	my $class  = shift;
	my $offset = shift;
	
	state $pi2 = pi() / 2.0;
	
	my $n = 0;
	while ($offset >= $pi2) {
		$n ++;
		$offset -= $pi2;
	}
	
	return cos($offset) * ($n % 2 ? -1 : 1);
}

1;
