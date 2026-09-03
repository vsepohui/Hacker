package Hacker::Synth::Sun;

use 5.022;
use warnings;

use base 'Hacker::Synth';


sub generate {
	my $class  = shift;
	my $offset = shift;
	
	my ($x, $y);
	
	my $step = int $offset;
	if ($step % 4 ~~ [0, 3]) {
		$x = $offset - $step;
		$y = sqrt(1 - $x * $x);
	} else {
		$x = $offset - $step;
		$y = -1 * sqrt(1 - $x * $x);
	}
	
	return $y;
}

1;
