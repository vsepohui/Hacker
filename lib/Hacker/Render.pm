package Hacker::Render;

use 5.022;
use warnings;

use base 'Hacker::Player';


sub new {
	my $class = shift;
	my %opts  = (
		volume		=> $class->DEFAULT_VOLUME(),
		filename	=> undef,
		@_,
	);
	
	my $volume      = $opts{volume};
	my $filename	= $opts{filename} or die "Filename is not specified";
	
	my $max_amplitude 	= 32767 * $volume;

	return $class->SUPER::new(
		volume			=> $volume,
		max_amplitude 	=> $max_amplitude,
		filename		=> $filename,
	);
}

sub render {
	my $self = shift;
	my @signal = @_;
	
	
	my $filename = $self->{filename};
	
	open my $fh, '>' . $filename;
	
	# Render PCM
	my @s = ();
	for my $s (@signal) {
		$s = $self->limiter($s);
		
		my $sample = $s * $self->{max_amplitude};
		my $int_sample = int($sample + 0.5);

		print $fh pack('s', $int_sample);
	}
	close $fh;

	return;
}

1;
