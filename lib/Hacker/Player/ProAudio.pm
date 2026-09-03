package Hacker::Player::ProAudio;

use 5.022;
use warnings;

use base 'Hacker::Player';

use Audio::PortAudio;



sub new {
	my $class = shift;
	my %opts  = (
		sample_rate => $class->DEFAULT_SAMPLE_RATE(),
		@_,
	);
	
	my $sample_rate = $opts{sample_rate};

	my $api = Audio::PortAudio::default_host_api();
	my $device = $api->default_output_device;

	my $stream = $device->open_write_stream(
		{ channel_count => 1 },
		$sample_rate,
		400,
		0
	);


	return $class->SUPER::new(
		api 		=> $api,
		device		=> $device,
		stream		=> $stream,
		sample_rate	=> $sample_rate,
	);
}

sub play {
	my $self   = shift;
	my @signal = @_;
	
	my $wave = pack "f*", map {$_ > 1 ? 1 : $_ < -1 ? -1 : $_} map {$_ * $self->{volume}} @signal;
	
	$self->{stream}->write($wave);
}

1;
