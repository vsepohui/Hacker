package Hacker::Synth::Virtual;

use 5.022;
use warnings;

use base 'Hacker::Synth';


sub new {
	my $class = shift;
	my $code  = shift;
	
	return $class->SUPER::new('code' => $code);
}

sub generate {
	my $self 	= shift;
	my $offset 	= shift;
	
	return $self->{code}->($offset);
}

1;
