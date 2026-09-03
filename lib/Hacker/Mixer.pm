package Hacker::Mixer;

use 5.022;
use warnings;

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
	my $max = 0;
	for (my $i = 0 ; $i < $n ; $i ++) {
		
		my $s = 0;
		for (@{$self->{channels}}) {
			$s += $_->[$i];
		}
		
		$max = abs($s) if abs($s) > $max;
		push @master, $s;
	}

	@master = map {$_ / $max} @master;
	
	return @master;
}

1;
