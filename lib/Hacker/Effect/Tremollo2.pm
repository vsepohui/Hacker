package Hacker::Effect::Tremollo2;

use 5.022;
use warnings;

use base 'Hacker::Effect::Tremollo';


sub process {
	my $self = shift;
	my @s = @_;
	
	my $v = $self->{value};


	my @out;
	my $s = 0;
	my $x = 0;
	my $n = scalar @s;
	for (my $i = 0 ; $i < $n ; $i ++) {
		if ($s >= $v) {
			$s -= $v;
			$x ++;
		}
		push @out, $s[int $i] * ($x % 2 ? -1 : 1);
		$s ++;
	}
	return @out;
}

1;
