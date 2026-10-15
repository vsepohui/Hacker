package Hacker::Effect::Normalize;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub process {
	my $self = shift;
	my @s = @_;
	
	my $n = scalar @s;
	my $max = 0;

	for (my $i = 0 ; $i < $n ; $i ++) {
		my $s = $s[$i];
		$max = abs($s) if abs($s) > $max;
	}

	return map {$_ / $max} @s;
}

1;
