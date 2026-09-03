#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Getopt::Long qw(GetOptions);

use Hacker;

my ($driver, $help, $play, $render);

GetOptions('driver=s' => \$driver, 'play' => \$play, 'render=s' => \$render, 'h|help' => \$help);
usage() if $help;
sub usage { say "Usage:\n\t$0 [--driver=...] [--help] [--play] [--render=...] project-file.hacker" and exit(); }

my $project = pop @ARGV or die "Project file is not specified";
die "No project file $project" unless -f $project;

my $proj;
my $fi;
open $fi, $project;
$proj = join '', <$fi>;
close $fi;

my @signal = eval $proj;

die $@ if $@;

my $hacker = new Hacker(driver => $driver);

unless ($render) {
	$hacker->play(@signal);
} else {
	$hacker->render($render => @signal);
}


1;
