#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';
use Hacker;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Triangle;


Hacker->render('Samples/sine.pcm' => map {sin($_ * 440 * 3.14159265359 / 44100.0)} 0 .. 44100 * 5);
Hacker->render('Samples/sun.pcm' => Hacker::Synth::Sun->signal);
Hacker->render('Samples/saw.pcm' => Hacker::Synth::Saw->signal);

Hacker->render('Samples/sun-8bit.pcm' => map {int(Hacker->sun($_ * 220 / 44100.0)*3)/3} 0 .. 44100 * 5);
Hacker->render('Samples/triangle.pcm' => Hacker::Synth::Triangle->signal);


1;
