package Hacker;

use 5.022;
use warnings;

use Hacker::Player;
use Hacker::Render;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Triangle;

use constant DEFAULT_SAMPLE_RATE 	=> 44100;
use constant DEFAULT_VOLUME      	=> 1;
use constant DRIVERS			 	=> [qw/ProAudio ALSA/];
use constant DEFAULT_DRIVER		 	=> 'ALSA';
use constant NOTES_FREQUES 			=> [reverse qw/8372.018 7902.133 7458.620 7040.000 6644.875 6271.927 5919.911 5587.652 5274.041 4978.032 4698.636 4434.922 4186.009 3951.066 3729.310 3520.000 3322.438 3135.963 2959.955 2793.826 2637.020 2489.016 2349.318 2217.461 2093.005 1975.533 1864.655 1760.000 1661.219 1567.982 1479.978 1396.913 1318.510 1244.508 1174.659 1108.731 1046.502 987.7666 932.3275 880.0000 830.6094 783.9909 739.9888 698.4565 659.2551 622.2540 587.3295 554.3653 523.2511 493.8833 466.1638 440.0000 415.3047 391.9954 369.9944 349.2282 329.6276 311.1270 293.6648 277.1826 261.6256 246.9417 233.0819 220.0000 207.6523 195.9977 184.9972 174.6141 164.8138 155.5635 146.8324 138.5913 130.8128 123.4708 116.5409 110.0000 103.8262 97.99886 92.49861 87.30706 82.40689 77.78175 73.41619 69.29566 65.40639 61.73541 58.27047 55.00000 51.91309 48.99943 46.24930 43.65353 41.20344 38.89087 36.70810 34.64783 32.70320 30.86771 29.13524 27.50000 25.95654 24.49971 23.12465 21.82676 20.60172 19.44544 18.35405 17.32391 16.35160 15.43385 14.56762 13.75000/]; 
use constant NOTES					=> ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'H'];

sub new {
	my $class = shift;
	my %opts  = (
		driver => Hacker->DEFAULT_DRIVER(),
		@_,
	);
	
	my $self = {
		driver => $opts{driver},
	};
	
	return bless $self, $class;	
}

sub parse_note {
	my $self = shift;
	my $note = shift;
	return $note if $note =~ /^-?\d+$/;
	
	state %notes = ();

	my $notes = $self->NOTES;
	
	unless (%notes) {
		my $n = scalar @$notes;
		for (my $i = 0 ; $i < $n ; $i ++) {
			$notes{$notes->[$i]} = $i;
		}
	}
	
	my $octave = 4;
	
	if ($note =~ /^(\w\#?)(\d*)$/) {
		$note   = uc $1;
		$octave = $2;
	}
	
	die "Wrong note: $note" unless exists $notes{$note};
	
	return $notes{$note} + 12 * ($octave - 4);
}

sub sample_rate {
	my $self = shift;
	return $self->DEFAULT_SAMPLE_RATE;
}

sub player {
	my $self = shift;
	return Hacker::Player->init($self->{driver});
}

sub play {
	my $self = ref $_[0] ? shift : new shift;
	my @signal	= @_;
	
	$self->player()->play(@signal);
}

sub render {
	my $self = ref $_[0] ? shift : new shift;
	my $filename = shift;
	my @signal   = @_;
	
	my $render = new Hacker::Render(filename => $filename);
	$render->render(@signal);
}

sub pattern {
	my $self   = shift;
	my $code   = shift;
	my $length = shift;
	
	return map {$code->($_)} 0..$self->sample_rate * $length;
}

sub sun {
	my $class  = shift;
	return Hacker::Synth::Sun->generate(@_);
}

sub saw {
	my $class  = shift;
	return Hacker::Synth::Saw->generate(@_);
}


sub triangle {
	my $class  = shift;
	return Hacker::Synth::Triangle->generate(@_);
}


1;
