package Hacker;

use 5.022;
use warnings;

use Getopt::Long qw(GetOptions);

use Hacker::Player;
use Hacker::Render;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Triangle;
use Hacker::Synth::Sampler;
use Hacker::Synth::Sequensor;
use Hacker::Synth::Silence;
use Hacker::Mixer;
use Hacker::Effect::Transpose;
use Hacker::Effect::Reverse;
use Hacker::Effect::Delay;
use Hacker::Effect::Crop;

use Hacker::Config;

use Carp;


sub new {
	my $class = shift;
	my %opts  = (
		driver => $class->config->{DEFAULT_DRIVER},
		@_,
	);
	
	my $self = {
		%opts,
		config => new Hacker::Config,
	};
	
	return bless $self, $class;	
}

sub config {
	my $class = shift;
	return new Hacker::Config;
}

sub parse_note {
	my $self = shift;
	my $note = shift;
	return $note if $note =~ /^-?\d+$/;
	
	state %notes = ();

	my $notes = $self->config->{NOTES};
	my $n = scalar @$notes;
	
	unless (%notes) {	
		for (my $i = 0 ; $i < $n ; $i ++) {
			$notes{$notes->[$i]} = $i;
		}
	}
	
	my $octave = 4;
	
	if ($note =~ /^(\w\#?)(\d*)$/) {
		$note   = uc $1;
		$octave = $2;
	}
	
	confess "Wrong note: $note" unless exists $notes{$note};
	
	return $notes{$note} + $n * ($octave - 4);
}

sub sample_rate {
	my $self = shift;
	return $self->config->{DEFAULT_SAMPLE_RATE};
}

sub player {
	my $self = shift;
	state $player = Hacker::Player->init($self->{driver});
	return $player;
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
	return Hacker::Synth::Triangle->new(@_);
}

sub sampler {
	my $class = shift;
	return Hacker::Synth::Sampler->new(@_);
}

sub sequenser {
	my $class = shift;
	return Hacker::Synth::Sequensor->new(@_);
}

sub mixer {
	my $class = shift;
	return Hacker::Mixer->new(@_);
}

sub silence {
	my $class = shift;
	my $length = shift;
	
	return Hacker::Synth::Silence->signal(0, $length);
}

sub transpose {
	my $class  = shift;
	my $signal = shift;
	my $value  = shift;
	return Hacker::Effect::Transpose->new($value)->process(@$signal);
}

sub reverse {
	my $class = shift;
	return Hacker::Effect::Reverse->new()->process(@_);
}

sub crop {
	my $class  = shift;
	my $signal = shift;
	my $length = shift;
	
	return Hacker::Effect::Crop->new($length)->process(@$signal);
}

sub delay {
	my $class  = shift;
	my $signal = shift;
	my %params = @_;
	
	Hacker::Effect::Delay->new(%params)->process(@$signal);
}

sub load_project {
	my $self = shift;
	my $file = shift;
	
	my $project;

	my $fi;
	open $fi, $file;
	$project = join '', <$fi>;
	close $fi;

	my @signal = eval $project; die $@ if $@;
	
	return @signal;
}

sub process_command_line {
	my $class = shift;
	my $usage = pop;
	my @opts  = @_;
	
	my $prepare = sub {
		my $opt = shift;
		$opt =~ s/\=s$//;
		$opt =~ s/^\w\|(\w+)$/$1/;
		return $opt;
	};
	
	my %args = ();
	GetOptions(map {$_ => \$args{$prepare->($_)}} @opts);
	
	say $usage and exit() if $args{help};
	
	return %args;
}


1;
