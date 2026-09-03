#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';
use Hacker;


Hacker->render('samples/sine.pcm' => map {sin($_ * 440 * 3.14159265359 / 44100.0)} 0 .. 44100 * 5);
Hacker->render('samples/sun.pcm' => map {Hacker->sun($_ * 330 / 44100.0)} 0 .. 44100 * 5);
Hacker->render('samples/saw.pcm' => map {int (Hacker->sun($_ * 110 / 44100.0)+0.5)} 0 .. 44100 * 5);

Hacker->render('samples/sun-8bit.pcm' => map {int(Hacker->sun($_ * 220 / 44100.0)*3)/3} 0 .. 44100 * 5);
1;
