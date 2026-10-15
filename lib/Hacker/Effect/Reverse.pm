package Hacker::Effect::Reverse;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub process {
	my $self = shift;
	return reverse @_;
}

1;
