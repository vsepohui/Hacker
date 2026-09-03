package Hacker::Effect;

use 5.022;
use warnings;


sub new {
	my $class = shift;
	my $self = {};
	return bless $self, $class;
}

sub process {
	my $self = ref $_[0] ? shift : new shift;
	my @s = shift;
	return @s;	
}

1;
