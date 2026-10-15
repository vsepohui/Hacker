package Hacker::Project;

use 5.022;
use warnings;

use Cwd 'abs_path';
use File::Spec;


sub new {
	my $class = shift;
	my %args = @_;
	
	my $self = {%args};
	return bless $self, $class;
}

# Load ./hacker.pl Project from a file and preparing, executing
sub load_project {
	my $self = shift;
	my $file = shift;
	
	my $project;
	
	die "Project $file not found" unless -f $file;

	# Load file
	my $fi;
	open $fi, $file;
	$project = join '', <$fi>;
	close $fi;

	my (undef, $dir) = File::Spec->splitpath(abs_path $file);
	chdir $dir;
	
	# Adding header
	$project = q[use Hacker;] . $project;

	# Execute
	my @signal = eval $project; die $@ if $@;
	
	# Return Project result
	return @signal;
}

1;
