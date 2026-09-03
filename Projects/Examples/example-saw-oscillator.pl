#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;
use Hacker::Synth::Saw;

Hacker->play(Hacker::Synth::Saw->signal);

1;
