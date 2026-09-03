#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;
use Hacker::Synth::Triangle;

Hacker->play(Hacker::Synth::Triangle->signal);

1;
