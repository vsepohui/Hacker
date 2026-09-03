package Hacker::Effect;

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

# Acessor
sub proc {
	my $self = ref $_[0] ? shift : new shift;
	$self->process(@_);
}

# Process signal
sub process {
	my $self = ref $_[0] ? shift : new shift;
	my @s = shift;
	return @s;	
}

1;
