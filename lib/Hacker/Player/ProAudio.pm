package Hacker::Player::ProAudio;

use 5.022;
use warnings;

use base 'Hacker::Player';

use Audio::PortAudio;



sub new {
	my $class = shift;
	my %opts  = (
		@_,
	);
	
	my $api = Audio::PortAudio::default_host_api();
	my $device = $api->default_output_device;

	my $stream = $device->open_write_stream(
		{ channel_count => 1 },
		$class->sample_rate,
		400,
		0
	);

	return $class->SUPER::new(
		api 		=> $api,
		device		=> $device,
		stream		=> $stream,
	);
}

sub play {
	my $self   = shift;
	my @signal = @_;
	
	my $wave = pack "f*", map {$self->limiter($_)} map {$_ * Hacker->config->{DEFAULT_VOLUME}} @signal;
	$self->{stream}->write($wave);
}

1;
