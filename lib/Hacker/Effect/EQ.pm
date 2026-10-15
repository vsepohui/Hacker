package Hacker::Effect::EQ;

use 5.022;
use warnings;

use base 'Hacker::Effect';

use Math::Trig qw(pi);

# Port from C code
# Copy-pasted from https://www.musicdsp.org/en/latest/Filters/236-3-band-equaliser.html

sub new {
	my $class = shift;
	my %opts  = (
		low_freq 	=> 880,
		high_freq 	=> 5000,
		low_gain 	=> 1.0,
		mid_gain	=> 1.0,
		high_gain	=> 1.0,
		@_,
	);
	
	my $low_freq	= $opts{low_freq};
	my $high_freq 	= $opts{high_freq};

	my $low_gain	= $opts{low_gain};
	my $mid_gain 	= $opts{mid_gain};
	my $high_gain	= $opts{high_gain};
		
	my $self = {
		# Filter #1 (Low band)
		lf		=> 2 * sin(pi() * ($low_freq / $class->sample_rate())), # Frequency
		f1p0	=> 0,	# Poles ...
		f1p1	=> 0,
		f1p2	=> 0,
		f1p3	=> 0,

		# Filter #2 (High band)
		hf		=> 2 * sin(pi() * ($high_freq / $class->sample_rate())), # Frequency
		f2p0 	=> 0, 	# Poles ...
		f2p1	=> 0,
		f2p2	=> 0,
		f2p3	=> 0,

		# Sample history buffer
		sdm1	=> 0, 	# Sample data minus 1
		sdm2	=> 0, 	# 2
		sdm3	=> 0, 	# 3

		# Gain Controls
		lg		=> $low_gain,	# low  gain
		mg 		=> $mid_gain,	# mid  gain
		hg		=> $high_gain,	# high gain
	};
	
	return $class->SUPER::new(%$self);
}

# Very small amount (Denormal Fix)
sub vsa {
	return 1.0 / 4294967295.0;
}

sub do_eq {
	my $self 	= shift;
	my $sample 	= shift;
	
	# Locals
	my ($l, $m, $h); # Low / Mid / High - Sample Values

	# Filter #1 (lowpass)

	$self->{f1p0}  += ($self->{lf} * ($sample       - $self->{f1p0})) + $self->vsa;
	$self->{f1p1}  += ($self->{lf} * ($self->{f1p0} - $self->{f1p1}));
	$self->{f1p2}  += ($self->{lf} * ($self->{f1p1} - $self->{f1p2}));
	$self->{f1p3}  += ($self->{lf} * ($self->{f1p2} - $self->{f1p3}));

	$l = $self->{f1p3};

	# Filter #2 (highpass)
	$self->{f2p0}  += ($self->{hf} * ($sample       - $self->{f2p0})) + $self->vsa;
	$self->{f2p1}  += ($self->{hf} * ($self->{f2p0} - $self->{f2p1}));
	$self->{f2p2}  += ($self->{hf} * ($self->{f2p1} - $self->{f2p2}));
	$self->{f2p3}  += ($self->{hf} * ($self->{f2p2} - $self->{f2p3}));

	$h = $self->{sdm3} - $self->{f2p3};

	# Calculate midrange (signal - (low + high))
	$m = $self->{sdm3} - ($h + $l);

	# Scale, Combine and store
	$l *= $self->{lg};
	$m *= $self->{mg};
	$h *= $self->{hg};

	# Shuffle history buffer
	$self->{sdm3} = $self->{sdm2};
	$self->{sdm2} = $self->{sdm1};
	$self->{sdm1} = $sample;

	# Return result
	return $l + $m + $h;
}


sub process {
	my $self = shift;
	my @s = @_;
	return map {$self->do_eq($_)} @s;
}

1;
