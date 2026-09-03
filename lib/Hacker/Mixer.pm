package Hacker::Mixer;

use 5.022;
use warnings;

use base 'Hacker';

use Hacker::Effect::Normalize;



sub new {
	my $class = shift;
	my %opts  = (
		channels => [],
		@_,
	);
	
	my $self = {%opts};
	
	return bless $self, $class;
}

sub master {
	my $self = shift;
	
	my @master;

	my $n = scalar @{$self->{channels}->[0]};
	for (my $i = 0 ; $i < $n ; $i ++) {
		my $s = 0;
		for (@{$self->{channels}}) {
			$s += $_->[$i] // 0;
		}
		push @master, $s;
	}

	return Hacker::Effect::Normalize->process(@master);
}

1;
