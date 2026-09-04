package Hacker::Effect::Chiptune;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub process {
	my $self = shift;
	my @s = @_;
	
	return map {
		int ($_ * 16) / 16.0
	} @s;
}

1;
