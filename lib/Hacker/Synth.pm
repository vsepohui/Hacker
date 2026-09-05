package Hacker::Synth;

use 5.022;
use warnings;

use base 'Hacker';


sub new {
	my $class = shift;
	my %opts = @_;
	my $self = {%opts};
	return bless $self, $class;
}

# Accessor
sub sig {
	my $self = ref $_[0] ? shift : new shift;
	return $self->signal(@_);
}

# Accessor
sub play {
	my $self = ref $_[0] ? shift : new shift;
	return $self->sig(@_);
}

sub signal {
	my $self 	= ref $_[0] ? shift : new shift;
	my $note 	= shift // 0;
	my $length	= shift // 5;
	
	my $modulation = $self->note_rate($self->parse_note($note)) / $self->sample_rate;
	
	return $self->pattern(sub{$self->generate($_ * $modulation)} => $length);
}

# Accessor
sub gen {
	my $self = ref $_[0] ? shift : new shift;
	return $self->generate(@_);
}

sub generate {
	...
}

1;
