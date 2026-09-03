package Hacker::Player::Aplay;

use 5.022;
use warnings;

use base 'Hacker::Player';

use File::Temp qw(tempfile);


sub new {
	my $class = shift;
	my %opts  = (
		sample_rate => $class->DEFAULT_SAMPLE_RATE(),
		volume		=> $class->DEFAULT_VOLUME(),
		@_,
	);
	
	my $sample_rate = $opts{sample_rate};
	my $volume      = $opts{volume};
	
	my $max_amplitude 	= 32767 * $volume;

	return $class->SUPER::new(
		sample_rate		=> $sample_rate,
		volume			=> $volume,
		max_amplitude 	=> $max_amplitude,
	);
}

sub play {
	my $self = shift;
	my @signal = @_;
	
	# Create tmp file to store PCM
	my ($fh, $filename) = tempfile();
	
	# Render wave
	my @s = ();
	for my $s (@signal) {
		my $sample = $s * $self->{max_amplitude};
		my $int_sample = int($sample + 0.5);

		print $fh pack('s', $int_sample);
	}
	close $fh;

	# Let's play audio by aplay utility
	my $rate = $self->{sample_rate};
	`aplay -f s16_le -r $rate -c 1 $filename`;

	# Remove tmp PCM file
	unlink $filename;
}

1;
