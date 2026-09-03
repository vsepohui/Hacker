package Hacker;

use 5.022;
use warnings;

use Hacker::Player;
use Hacker::Render;

use Carp;


sub new {
	my $class = shift;
	my %opts  = (
		player_driver => Hacker::Player->DEFAULT_DRIVER(),
		@_,
	);
	
	my $self = {
		player_driver => $opts{player_driver},
	};
	
	return bless $self, $class;	
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
	
	return map {$code->($_)} 0..44100 * $length;
}

1;
