#!/usr/bin/perl

use 5.022;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Hacker;

my $usage = "Usage:\n\t$0 [--driver=...] [--help] perl-code-generator";
my %args = process_command_line(qw/driver=s h|help/, $usage);

my $code = pop @ARGV or die $usage;
my @signal = eval $code;
die "Error in eval code \"$code\"\n" if $@;

my $hacker = new Hacker(driver => $args{driver});
$hacker->play(@signal);

1;
