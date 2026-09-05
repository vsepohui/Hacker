package Hacker::Effect::Crop;

use 5.022;
use warnings;

use base 'Hacker::Effect';


sub new {
	my $class  = shift;
	my $length = shift;
	
	die "Length is not specified" unless defined $length;
	
	return $class->SUPER::new(length => $length);
}

sub process {
	my $self = shift;
	my @s = @_;
	
	my $size = int ($self->sample_rate * $self->{length});
	
	if (scalar @s >= $size) {
		return @s[0..$size];
	} else {
		return @s, (0) x ($size - scalar @s);
	}
}

1;
