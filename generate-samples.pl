#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';
use Hacker;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Triangle;


Hacker->render('samples/sine.pcm' => map {sin($_ * 440 * 3.14159265359 / 44100.0)} 0 .. 44100 * 5);
Hacker->render('samples/sun.pcm' => Hacker::Synth::Sun->signal);
Hacker->render('samples/saw.pcm' => Hacker::Synth::Saw->signal);

Hacker->render('samples/sun-8bit.pcm' => map {int(Hacker->sun($_ * 220 / 44100.0)*3)/3} 0 .. 44100 * 5);
Hacker->render('samples/triangle.pcm' => Hacker::Synth::Triangle->signal);


1;
