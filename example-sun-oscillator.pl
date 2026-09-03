#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;

Hacker->play(map {Hacker->sun($_ * 300 / 44100.0)} 0 .. 44100 * 5);




1;
