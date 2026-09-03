package Hacker::Effect::Crop;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub new {
	my $class = shift;
	my %opts  = (
		length => undef,
		@_,
	);
	
	die "Length is not specified" unless defined $opts{length};
	
	return $class->SUPER::new(%opts);
}

sub process {
	my $self = shift;
	my @s = @_;
	
	my $size = int ($self->sample_rate * $self->{length});
	return @s[0..$size];
}

1;
