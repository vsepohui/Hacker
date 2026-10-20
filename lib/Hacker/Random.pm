package Hacker::Random;

use 5.022;
use warnings;

use Strong::Random;

state $rand = new Strong::Random;;


sub srand {
	$rand->srand();
}


sub rand {
	return $rand->rand();
}


1;
