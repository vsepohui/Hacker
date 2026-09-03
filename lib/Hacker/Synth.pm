package Hacker::Synth;

use 5.022;
use warnings;


sub new {
	my $class = shift;
	my $self = {};
	return bless $self, $class;
}

sub signal {
	my $self 		= ref $_[0] ? $_[0] : new shift;
	my $modulation 	= shift // 110 / 44100.0;
	my $length 		= shift // 5;
	
	return map{$self->generate($_ * $modulation)} 0 .. 44100 * $length;
}


sub generate {
	...
}

1;
