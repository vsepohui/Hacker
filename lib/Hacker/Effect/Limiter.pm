package Hacker::Effect::Limiter;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub process {
	my $self  = shift;
	my $limit = pop;
	my @s = @_;
	
	return map {$_ > 0 ? ($_ > $limit ? $limit : $_ ) : ($_ <= 0 && $_ < -1 * $limit ) ? -1 * $limit : $_} @s;
}

1;
