package Hacker::Player;

use 5.022;
use warnings;

use base 'Hacker';


sub new {
	my $class = shift;
	my %opts  = (
		@_,
	);
	
	my $self = {%opts};
	
	return bless $self, $class;
}

sub limiter {
	my $self = shift;
	my $s = shift;
	return $s > 1 ? 1 : $s < -1 ? -1 : $s;
}

sub play {
	my $self   = shift;
	my @signal = @_;
	
	...
}

sub drivers {
	my $class = shift;
	return $class->DRIVERS();
}

sub init {
	my $class  = shift;
	my $driver = shift // $class->DEFAULT_DRIVER;
	
	die "Wrond driver \"$driver\"" unless $driver ~~ $class->drivers();

	my $c = $class.'::'.$driver;
	
	eval  "use $c";
	my $player = eval "new $c";
	return $player;
}

1;
