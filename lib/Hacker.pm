package Hacker;

use 5.022;
use warnings;

use Hacker::Player;


sub new {
	my $class = shift;
	
	my $self = {};
	
	return bless $self, $class;	
}

sub player {
	my $self 	= shift;
	my $driver 	= shift // Hacker::Player->DEFAULT_DRIVER();
	
	return Hacker::Player->init($driver);
}

sub play {
	my $self = shift;
	my %opts = (
		signal => undef,
		driver => undef,
		@_,
	);
	
	my $signal 	= $opts{signal};
	my $driver 	= $opts{driver};
	
	die "No signal\n" unless $signal && @$signal;

	$self->player($driver)->play(@$signal);
}

1;
