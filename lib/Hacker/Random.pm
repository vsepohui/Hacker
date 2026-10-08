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
	my $t = shift;
	
	my $half_freq = 2/7.0;

	my $j;
	my $step = int ($t / $half_freq);

	if (($step % 2) == 0) {
		$j = 1;
	} else {
		$j = -1;
	}
	$t -= $step * $half_freq;
	
	return $j*sqrt (1 - $t*$t);
}
	

sub rand {
	my $num = shift;
	
	my $r = (harmonic($SEED)+1)/2.0;
	$SEED *= $r+0.5;
	$SEED /= 101 if ($SEED >= 10**22);
	

	my $s = $r;
	$s =~ s/\.//;
	$r = $r * substr($s, -5, -1);
	$r = substr($r, 0, 22);
	$r =~ s/\.//;
	#$r = $r;
	$r = '0.'.$r;

	return $num ? int $num * $r : $r;
}


1;
