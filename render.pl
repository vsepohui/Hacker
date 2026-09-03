#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;

my $usage = "Usage:\n\t$0 [--out=...] [--help] perl-code-generator";
my %args = process_command_line(qw/out=s h|help/, $usage);

my $code = pop @ARGV or die $usage;

my @signal = eval $code; die "Error in eval code \"$code\"\n" if $@;

my $hacker = new Hacker;
$hacker->render($args{out} => @signal);

1;
