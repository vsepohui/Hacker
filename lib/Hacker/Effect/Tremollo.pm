package Hacker::Effect::Tremollo;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub new {
	my $class = shift;
	my $value = shift;

	use Carp;
	confess $value unless $value =~ /^\d+$/;
	
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
		push @out, $s[int $i] * ($x % 2 ? -1 : 1);
		$s ++;
	}
	return @out;
}

1;
