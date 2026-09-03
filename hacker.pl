#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;

my $usage = "Usage:\n\t$0 [--driver=...] [--help] [--play] [--render=...] project-file.hacker";
my %args = process_command_line(qw/driver=s play render=s h|help/, $usage);

my $file = pop @ARGV or die $usage;
die "No project file $file" unless -f $file;

my $hacker = new Hacker(driver => $args{driver});

my @signal = $hacker->load_project($file);
if (my $file = $args{render}) {
	$hacker->render($file => @signal);
	exit;
}

$hacker->play(@signal);

1;
