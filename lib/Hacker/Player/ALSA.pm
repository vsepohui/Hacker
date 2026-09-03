package Hacker::Player::ALSA;

use 5.022;
use warnings;

use base 'Hacker::Player';

use Hacker::Render;

use File::Temp qw(tempfile);


sub play {
	my $self = shift;
	my @signal = @_;
	
	# Create tmp file
	my (undef, $filename) = tempfile();
	
	my $render = new Hacker::Render(filename => $filename);
	$render->render(@signal);

	# Let's play audio by aplay utility
	my $rate = $self->sample_rate;
	`aplay -q -f s16_le -r $rate -c 1 $filename`;

	# Remove tmp PCM file
	unlink $filename;
}

1;
