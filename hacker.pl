#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;

my $usage = "Usage:\n\t$0 [--driver=...] [--help] [--play] [--render=...] project-file.hacker";
my %args = Hacker->process_command_line(qw/driver=s play render=s h|help/, $usage);

my $project = pop @ARGV or die $usage;
die "No project file $project" unless -f $project;

my $hacker = new Hacker(driver => $args{driver});
my @signal = $hacker->load_project($project);

if (my $file = $args{render}) {
	$hacker->render($file => @signal);
	exit;
}

$hacker->play(@signal);

1;
