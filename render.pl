#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Getopt::Long qw(GetOptions);

use Hacker;

my ($out, $help);

GetOptions('out=s' => \$out, 'h|help' => \$help);
usage() if $help || !$out;
sub usage { say "Usage:\n\t$0 [--out=...] [--help] perl-code-generator" and exit(); }

my $code = pop @ARGV or usage();

my @signal = eval $code;
die "Error in eval code \"$code\"\n" if $@;

Hacker->render($out => @signal);

1;
