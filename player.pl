#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;

use Getopt::Long qw(GetOptions);

my ($driver, $help);
GetOptions('driver=s' => \$driver, 'h|help' => \$help);
usage() if $help;
sub usage { say "Usage:\n\t$0 [--driver=...] [--help] perl-code-generator" and exit(); }

my $code = pop @ARGV or usage();
my @signal = eval $code;
die "Error in eval code \"$code\"\n" if $@;

Hacker->new(driver => $driver)->play(@signal);

1;
