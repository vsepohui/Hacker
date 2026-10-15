package Hacker::Synth::Sequensor;

use 5.022;
use warnings;

use base 'Hacker::Synth';

use Hacker::Effect::Transpose;

sub new {
	my $class  = shift;
	my $sample = shift or die "Sample is not specified";
	my $bpm    = shift // 120;
		
	my $self = {
		sample	=> $sample,
		bpm 	=> $bpm,
	};
	
	return bless $self, $class;
}


sub signal {
	my $self    = ref $_[0] ? shift : new shift;
	my $pattern = shift;
	#$length //= scalar @{$self->{sample}} - 1;
	
	return $self->render_pattern($pattern);
}



sub render_pattern {
	my $self    = shift;
	my $pattern = shift;
	
	my @steps = split /,/, $pattern;
	
	my $step_time = 60 / $self->{bpm};
	my $max = $step_time * scalar (@steps) * $self->sample_rate;
	
	my $next_step = 1;
	my $current_step = -1;
	my $offset = 0;
	my @buff;
	my @s;
	
	for (my $i = 0 ; $i < $max ; $i ++) {
		my $step = int $i / ($self->sample_rate * $step_time);
		if ($step == $current_step) { 
			push @s, @buff && $buff[$offset] ? $buff[$offset] : 0;
		} else {
			$current_step = $step;
			my $x = $steps[$step];
			if ($x =~ /^-?\d+$/ || $x =~ /^\w\#?\d*$/) {
				$offset = 0;
				@buff = Hacker::Effect::Transpose->new($self->parse_note($x))->process(@{$self->{sample}});
				push @s, $buff[$offset];
			} elsif ($x eq '#') {
				@buff = ();
				push @s, 0;
			} else {
				push @s, @buff && $buff[$offset] ? $buff[$offset] : 0;
			}
			
		}
		
		$offset ++;
	}

	return @s;
}

1;
