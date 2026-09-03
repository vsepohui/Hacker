package Hacker::Mixer;

use 5.022;
use warnings;

use Hacker::Effect::Normalize;


sub new {
	my $class = shift;
	
	my $self = {
		channels => [],
		@_,
	};
	
	return bless $self, $class;
}

sub add_channel {
	my $self   = shift;
	my @signal = @_;
	
	push @{$self->{channels}}, \@signal;
}

sub master {
	my $self = shift;
	
	my @master;

	my $n = scalar @{$self->{channels}->[0]};
	for (my $i = 0 ; $i < $n ; $i ++) {
		my $s = 0;
		for (@{$self->{channels}}) {
			$s += $_->[$i];
		}
		push @master, $s;
	}

	return Hacker::Effect::Normalize->process(@master);
}

1;
