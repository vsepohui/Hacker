package Hacker::Synth::MagikOscillator;

use 5.022;
use warnings;

use base 'Hacker::Synth';

use Hacker::Magik::SquareOscillator;
use Hacker::Synth::Triangle;


sub generate {
	my $class  = shift;
	my $offset = shift;
	
	my $a = Hacker::Synth::Triangle->generate($offset*10)/10;
	
	my ($x, $y) = Hacker::Magik::SquareOscillator->calc($a);
	
	return [Hacker::Synth::Sin->generate(int 100*$x)*$x, Hacker::Synth::Sin->generate(int 240*$y)*$y];
}

1;
