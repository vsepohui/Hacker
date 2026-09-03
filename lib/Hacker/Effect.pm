package Hacker::Effect;

use 5.022;
use warnings;


sub new {
	my $class = shift;
	my %opts  = (
		@_,
	);
	
	my $self = {%opts};
	
	return bless $self, $class;
}

sub process {
	my $self = ref $_[0] ? shift : new shift;
	my @s = shift;
	return @s;	
}

1;
