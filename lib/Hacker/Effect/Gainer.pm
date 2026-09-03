package Hacker::Effect::Gainer;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub new {
	my $class = shift;
	my %opts  = (
		value => 1,
		@_,
	);
	
	return $class->SUPER::new(%opts);
}

sub process {
	my $self = shift;
	my @s = @_;
	
	my $v = $self->{value};

	for (@s) {
		$_ *= $v;
		$_ = 1 if ($_ > 1);
		$_ = -1 if ($_ < -1);
	}

	return @s;
}

1;
