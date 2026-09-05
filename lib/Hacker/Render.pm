package Hacker::Render;

use 5.022;
use warnings;

use base 'Hacker::Player';

use File::Temp qw(tempfile);


sub new {
	my $class = shift;
	my %opts  = (
		volume		=> Hacker->config->{DEFAULT_VOLUME},
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
	
	my $ffmpeg = $filename =~ /\.(wav|mp3|flac|ogg|m4a)$/;
	my $fh;
	
	($fh, $ffmpeg) = tempfile() if $ffmpeg;
	
	open $fh, '>' . $filename if ($filename ne '<STDOUT>' && !$ffmpeg);

	
	# Render PCM
	my @s = ();
	for my $s (@signal) {
		$s = $self->limiter($s);
		
		my $sample = $s * $self->{max_amplitude};
		my $int_sample = int($sample + 0.5);

		if ($filename ne '<STDOUT>') {
			print $fh pack('s', $int_sample);
		} else {
			print pack('s', $int_sample);
		}
	}
	
	close $fh if ($filename ne '<STDOUT>');
	
	`ffmpeg -loglevel quiet -f s16le -ar 44100 -ac 1 -i $ffmpeg $filename` if $ffmpeg;

	return;
}

1;
