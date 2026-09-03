package Hacker::Player::Aplay;

use 5.022;
use warnings;

use base 'Hacker::Player';

use Hacker::Render;

use File::Temp qw(tempfile);


sub new {
	my $class = shift;
	my %opts  = (
		volume		=> $class->DEFAULT_VOLUME(),
		@_,
	);
	
	my $volume      = $opts{volume};
	
	my $max_amplitude 	= 32767 * $volume;

	return $class->SUPER::new(
		volume			=> $volume,
		max_amplitude 	=> $max_amplitude,
	);
}

sub play {
	my $self = shift;
	my @signal = @_;
	
	# Create tmp file
	my (undef, $filename) = tempfile();
	
	my $render = new Hacker::Render(filename => $filename);
	$render->render(@signal);

	# Let's play audio by aplay utility
	my $rate = $self->sample_rate;
	`aplay -f s16_le -r $rate -c 1 $filename`;

	# Remove tmp PCM file
	unlink $filename;
}

1;
