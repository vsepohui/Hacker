#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;

use Getopt::Long qw(GetOptions);

my ($driver, $help, $play, $render);
GetOptions('driver=s' => \$driver, 'play' => \$play, 'render=s' => \$render, 'h|help' => \$help);
usage() if $help;
sub usage { say "Usage:\n\t$0 [--driver=...] [--help] [--play] [--render=...] project-file.hacker" and exit(); }
my $project = pop @ARGV or die "Project file is not specified";
die "No project file $project" unless -f $project;

my $hacker = new Hacker(driver => $driver);
my @signal = $hacker->load_project($project);

if ($render) {
	$hacker->render($render => @signal);
	exit;
}

$hacker->play(@signal);

1;
