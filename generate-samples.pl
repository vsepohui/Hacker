#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';
use Hacker;


Hacker->render('samples/sine.pcm' => map {sin($_ * 440 * 3.14159265359 / 44100.0)} 0 .. 44100 * 5);

1;
