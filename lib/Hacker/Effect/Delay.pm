package Hacker::Effect::Delay;

use 5.022;
use warnings;

use base 'Hacker::Effect';

use Hacker::Effect::Normalize;


sub new {
	my $class = shift;
	my %opts  = (
		time 			=> 0.3, # Delay time
		frames			=> 0,
		level			=> 0.5, # Mix level
		original_level 	=> 1,   # Original audio stream level
		#feedback 	=> 0.5,
		@_,
	);
	
	return $class->SUPER::new(%opts);
}

sub process {
	my $self = shift;
	my @s = @_;
	
	my @copy = @s;
	
	my $rate = $self->sample_rate;
	my $step = $self->{frames} || int $self->{time} * $rate;
	
	my $n = scalar @s;
	for (my $i = 0 ; $i < $n ; $i ++) {
		if ($i >= $step) {
			$s[$i] = $s[$i] * $self->{original_level} + $copy[$i - $step] * $self->{level};
		}
	}
	
	for (my $i = 0 ; $i < $step ; $i ++) {
		push @s, $copy[$n-$step+$i] * $self->{level};
	}
	
	return Hacker::Effect::Normalize->process(@s);
}

1;
