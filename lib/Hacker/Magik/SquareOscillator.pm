package Hacker::Magik::SquareOscillator;

use Math::Trig qw(pi);


sub angle {
	my $deg = shift;
	return pi() * $deg / 180.0;
}

sub calc {
	my $class = shift;
	my ($anglex) = @_;
	
	while ($anglex >= 360) {
		$anglex -= 360;
	}
	
	while ($anglex < 0) {
		$anglex += 360;
	}
	
	my ($x0, $y0);
	if ($anglex > 270) {
		$x0 = -1 * cos(angle($anglex - 270));
		$y0 = sin(angle($anglex - 270));
	} elsif ($angle > 180) {
		$x0 = -1 * sin(angle($anglex - 180));
		$y0 = -1 * cos(angle($anglex - 180));
	} elsif ($anglex > 90) {
		$x0 = cos(angle($anglex - 90));
		$y0 = -1 * sin(angle($anglex - 90));
	} else {
		$x0 = sin(angle($anglex));
		$y0 = cos(angle($anglex));		
	}
	
	return ($x0, $y0);
}

1;
