#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;
use Hacker::Synth::Triangle;

my @seq = qw[0 4 5 0 4 5 0 4 5 7 7 7 16 12 9 16 12 9 16 12 9 7 7 7] x2;

my @channel_1;
my @channel_2;
for (@seq) {
	push @channel_1, Hacker::Synth::Triangle->signal($_ - 1, 0.5);
	push @channel_2, Hacker::Synth::Triangle->signal($_ - 1 + 12, 0.5);
}


my @master;

my $max = 0;
for (my $i = 0 ; $i < @channel_1 ; $i ++) {
	my $s = $channel_1[$i] + $channel_2[$i];
	$max = abs($s) if abs($s) > $max;
	push @master, $s;
}

@master = map {$_ / $max} @master;

Hacker->play(@master);

1;
