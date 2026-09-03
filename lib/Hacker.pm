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
	my $self	= shift;
	my @signal	= @_;
	
	$self->player()->play(@signal);
}

sub render {
	my $self	 = shift;
	my $filename = shift;
	my @signal   = @_;
	
	my $render = new Hacker::Render(filename => $filename);
	$render->render(@signal);
}

1;
