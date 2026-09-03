package Hacker::Synth::Triangle;

use 5.022;
use warnings;

use base 'Hacker::Synth';


sub generate {
	my $class  = shift;
	my $offset = shift;
	
	my ($x, $y);
	
	my $step = int $offset;
	$x = $offset - $step;
	
	my $s = $step % 4;
	
	if ($s == 0) {
		$y = 1 - $x;
	} elsif ($s == 3) {
		$y = $step - $x;
	} elsif ($s == 1) {
		$y = $step - $x - 1;
	} else {
		$y = -$x;
	}
	
	return $y;
}

1;
