#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;
use Hacker::Synth::Sun;

Hacker->play(Hacker::Synth::Sun->signal);


1;
