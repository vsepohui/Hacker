package Hacker::Random;

use 5.022;
use warnings;

use Time::HiRes;

state $SEED = get_time();

sub get_time {
	return join '.', Time::HiRes::gettimeofday;
}

sub srand {
	$SEED = shift // get_time();
}


sub harmonic {
	my $x = shift;
	
	state $half_freq = 2/7.0;

	my $step = int ($x / $half_freq);
	$x -= $step * $half_freq;

	return ($step % 2 ? -1 : 1) * sqrt (1 - $x*$x);
}
	

sub rand {
	my $num = shift;
	
	my $r = (harmonic($SEED)+1)/2.0;
	$SEED *= $r+1.5;
	$SEED /= 2 if ($SEED >= 100000000);

	my $s = $r;
	$s =~ s/\.//;
	$r *= substr($s, -5, -1) || 0;
	$r = substr($r, 0, 22);
	$r =~ s/\.//;
	#$r = $r;
	$r = '0.'.$r;

	return $num ? int $num * $r : $r;
}


1;
