package Hacker::Effect::Delay;

use 5.022;
use warnings;

use base 'Hacker::Effect';

use Hacker::Effect::Normalize;


sub new {
	my $class = shift;
	my %opts  = (
		time 		=> 0.3,
		level		=> 0.5,
		#feedback 	=> 0.5,
		@_,
	);
	
	return $class->SUPER::new(%opts);
}

sub process {
	my $self = shift;
	my @s = @_;
	
	my $rate = 44100;
	my $step = int $self->{time} * $rate;
	
	my $n = scalar @s;
	for (my $i = 0 ; $i < $n ; $i ++) {
		if ($i >= $self->{time} * $rate) {
			$s[$i] += $s[$i - $step] * $self->{level};
		}
	}
	
	for (my $i = 0 ; $i < $step ; $i ++) {
		push @s, $s[$n-$step+$i] * $self->{level};
	}
	
	return Hacker::Effect::Normalize->process(@s);
}

1;
