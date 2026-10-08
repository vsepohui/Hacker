package Hacker::Effect::Distortion;

use 5.022;
use warnings;

use base 'Hacker::Effect';

use POSIX qw(fmod);


sub new {
	my $class = shift;
	my $threshold = shift;
	
	return $class->SUPER::new(
		threshold => $threshold,
	);
}

sub process {
	my $self = shift;
	my @s = @_;
	
	return map {
		$_ > $self->{threshold} || $_ < -1* $self->{threshold} ? (
			abs(abs(fmod($_ - $self->{threshold}, $self->{threshold}*4)) - $self->{threshold}*2) - $self->{threshold}
		) : $_
	} @s;
}

1;
