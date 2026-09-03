#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;
use Hacker::Synth::Triangle;

my @seq = qw[0 4 5 0 4 5 0 4 5 7 7 7 16 12 9 16 12 9 16 12 9 7 7 7] x2;

my @signal;
for (@seq) {
	push @signal, Hacker::Synth::Triangle->signal($_ - 1, 0.5);
}

Hacker->play(@signal);

1;
