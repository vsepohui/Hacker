package Hacker::Effect::Tremollo;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub new {
	my $class = shift;
	my $value = shift;

	use Carp;
	if ($value =~ /^(\d+\.?\d*)(s|f)?$/) { 
		$value = $1;
		my $m = $2 // 's';
		$value = $class->sample_rate() * $value if $m eq 's';
	} else {
		confess "Worng value: $value";
	}
	
	return $class->SUPER::new(value => $value);
}

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
		push @out, $s[int $i] * ($x % 2 ? 0 : 1);
		$s ++;
	}
	return @out;
}

1;
