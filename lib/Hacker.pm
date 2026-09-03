package Hacker;

use 5.022;
use warnings;

use Hacker::Player;
use Hacker::Render;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Triangle;

use constant DEFAULT_SAMPLE_RATE => 44100;
use constant DEFAULT_VOLUME      => 1;
use constant DRIVERS			 => [qw/ProAudio Aplay/];
use constant DEFAULT_DRIVER		 => 'ProAudio';



sub new {
	my $class = shift;
	my %opts  = (
		player_driver => Hacker->DEFAULT_DRIVER(),
		@_,
	);
	
	my $self = {
		player_driver => $opts{player_driver},
	};
	
	return bless $self, $class;	
}

sub sample_rate {
	my $self = shift;
	return $self->DEFAULT_SAMPLE_RATE;
}

sub player {
	my $self = shift;
	return Hacker::Player->init($self->{player_driver});
}

sub play {
	my $self = ref $_[0] ? shift : new shift;
	my @signal	= @_;
	
	$self->player()->play(@signal);
}

sub render {
	my $self = ref $_[0] ? shift : new shift;
	my $filename = shift;
	my @signal   = @_;
	
	my $render = new Hacker::Render(filename => $filename);
	$render->render(@signal);
}

sub pattern {
	my $self   = shift;
	my $code   = shift;
	my $length = shift;
	
	return map {$code->($_)} 0..$self->sample_rate * $length;
}

sub sun {
	my $class  = shift;
	return Hacker::Synth::Sun->generate(@_);
}

sub saw {
	my $class  = shift;
	return Hacker::Synth::Saw->generate(@_);
}


sub triangle {
	my $class  = shift;
	return Hacker::Synth::Triangle->generate(@_);
}


1;
