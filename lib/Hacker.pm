package Hacker;

use 5.022;
use warnings;

use Exporter qw(import);
our @EXPORT = qw(sampler seq sequenser mix mixer rev crop silence transpose delay noise process_command_line triangle sine sun saw load);

use Getopt::Long qw(GetOptions);

use Hacker::Player;
use Hacker::Render;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Sin;
use Hacker::Synth::Triangle;
use Hacker::Synth::Sampler;
use Hacker::Synth::Sequensor;
use Hacker::Synth::Noise;
use Hacker::Synth::Silence;
use Hacker::Synth::Virtual;
use Hacker::Mixer;
use Hacker::Effect::Transpose;
use Hacker::Effect::Reverse;
use Hacker::Effect::Delay;
use Hacker::Effect::Crop;

use Hacker::Config;
use Hacker::Project;

use Carp;


# Constructor
sub new {
	my $class = shift;
	my %opts  = (
		driver => $class->config->{DEFAULT_DRIVER},
		@_,
	);
	
	my $self = {%opts};
	return bless $self, $class;	
}

# Config accessor
sub config {
	return new Hacker::Config;
}

# Note parsing, getting integer and string note return number of note
sub parse_note {
	my $self = shift;
	my $note = shift;
	
	# May this is integer note?
	return $note if $note =~ /^-?\d+$/;
	
	
	my $notes = $self->config->{NOTES};
	my $n = scalar @$notes;

	# Cache
	state %notes = ();	
	# Init state %notes cache value
	unless (%notes) {
		for (my $i = 0 ; $i < $n ; $i ++) {
			$notes{$notes->[$i]} = $i;
		}
	}
	
	# Default octave
	my $octave = 4;
	
	# Parse string note
	if ($note =~ /^(\w\#?)(\d*)$/) {
		$note   = uc $1;
		$octave = $2;
	}
	
	# Validation note
	confess "Wrong note: $note" unless exists $notes{$note};
	
	# Return note value
	return $notes{$note} + $n * ($octave - 4);
}

# Accessor to config
sub sample_rate {
	my $self = shift;
	return $self->config->{DEFAULT_SAMPLE_RATE};
}

# Accessor to Hacker object driver param
sub driver {
	my $self = shift;
	my $driver = shift;
	
	# If gettet, setup new value
	if ($driver) {
		# Validate value by config
		confess "Wrong driver \"$driver\"" unless ($driver ~~ $self->config->{DRIVERS});
		$self->{driver} = $driver;
	}
	
	return $self->{driver};
}

# Player accessor
sub player {
	my $self = shift;
	# Init state player
	state $player = Hacker::Player->init($self->{driver});
	return $player;
}

# Accessor
sub play {
	my $self = ref $_[0] ? shift : new shift;
	my @signal	= @_;
	$self->player()->play(@signal);
}

# Accessor
sub render {
	my $self = ref $_[0] ? shift : new shift;
	
	my $filename = shift;
	my @signal   = @_;
	
	my $render = new Hacker::Render(filename => $filename);
	$render->render(@signal);
}

# Usefull tool for a hackers
sub pattern {
	my $self   = shift;
	my $code   = shift;
	my $length = shift;
	
	return map {$code->($_)} 0..$self->sample_rate * $length;
}

# Accessor
sub sun {
	return Hacker::Synth::Sun->sig(@_);
}

# Accessor
sub sine {
	return Hacker::Synth::Sin->sig(@_);
}

# Accessor
sub saw {
	return Hacker::Synth::Saw->sig(@_);
}

# Accessor
sub triangle {
	return Hacker::Synth::Triangle->sig(@_);
}

# Accessor
sub sampler {
	return Hacker::Synth::Sampler->new(@_);
}

# Accessor
sub noise {
	return Hacker::Synth::Noise->sig(@_);
}

# Accessor
sub seq {
	return sequenser(@_);
}

# Accessor
sub sequenser {
	my $pattern = pop;
	my @opts    = @_;
	return Hacker::Synth::Sequensor->new(@opts)->sig($pattern);
}

# Accessor
sub mix {
	return mixer(@_);
}

# Accessor
sub mixer {
	return Hacker::Mixer->new(@_)->mix;
}

# Accessor
sub silence {
	my $length = shift;
	return Hacker::Synth::Silence->signal(0, $length);
}

# Accessor
sub transpose {
	my $signal = shift;
	my $value  = shift;
	return Hacker::Effect::Transpose->new($value)->process(@$signal);
}

# Accessor
sub rev {
	return Hacker::Effect::Reverse->new()->process(@_);
}

# Accessor
sub crop {
	my $signal = shift;
	my $length = shift;

	return Hacker::Effect::Crop->new($length)->process(@$signal);
}

# Accessor
sub delay {
	my $signal = shift;
	my %params = @_;
	
	Hacker::Effect::Delay->new(%params)->process(@$signal);
}

# Accessor
sub load {
	Hacker::Project->new()->load_project(@_);
}

# Usefull util for parsing command-line
sub process_command_line {
	my $usage = pop; # Get last param, it's Usage text
	my @opts  = @_;  # Get params
	
	# Prepare from GetOptions syntax option to key-names
	my $prepare = sub {
		my $opt = shift;
		$opt =~ s/\=s$//;
		$opt =~ s/^\w\|(\w+)$/$1/;
		return $opt;
	};
	
	my %args = ();
	GetOptions(map {$_ => \$args{$prepare->($_)}} @opts);
	
	# Show usage, it catchet --help command-line param
	say $usage and exit() if $args{help};
	
	return %args;
}


1;
