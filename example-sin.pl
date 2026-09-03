#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker;

Hacker->new->play(map {sin($_ * 880 * 3.1415 / 44100.0)} 0 .. 44100 * 5);


1;
