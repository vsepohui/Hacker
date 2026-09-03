package Hacker::Player;

use 5.022;
use warnings;

use Audio::PortAudio;

use constant DEFAULT_SAMPLE_RATE => 44100;
use constant DEFAULT_VOLUME      => 1.0;

sub new {
	my $class = shift;
	my %opts  = (
		sample_rate => DEFAULT_SAMPLE_RATE(),
		volume		=> DEFAULT_VOLUME(),
		@_,
	);
	
	my $self = {%opts};
	
	return bless $self, $class;
}

sub play {
	my $self   = shift;
	my @signal = @_;
	...
}

1;
