package Hacker::Synth::Virtual;

use 5.022;
use warnings;

use base 'Hacker::Synth';


sub new {
	my $class = shift;
	my %opts  = (
		generate => undef,
		@_,
	);
	
	return $class->SUPER::new(%opts);
}

sub generate {
	my $self 	= shift;
	my $offset 	= shift;
	
	return $self->{generate}->($self, $offset);
}

1;
