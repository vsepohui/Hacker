package Hacker::Synth;

use 5.022;
use warnings;

use base 'Hacker';


sub new {
	my $class = shift;
	my $self = {};
	return bless $self, $class;
}

sub note_rate {
	my $self = shift;
	my $note = shift;
	
	return $self->NOTES_FREQUES->[$note + 51];
}

sub signal {
	my $self 		= ref $_[0] ? $_[0] : new shift;
	my $note 		= shift // 0;
	my $length 		= shift // 5;
	
	my $modulation = $self->note_rate($self->parse_note($note)) / $self->sample_rate;
	
	return $self->pattern(sub{$self->generate($_ * $modulation)} => $length);
}


sub generate {
	...
}

1;
