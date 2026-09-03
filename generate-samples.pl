#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';
use Hacker;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Sin;
use Hacker::Synth::Triangle;


Hacker->render('Samples/sine.pcm' => Hacker::Synth::Sin->signal);
Hacker->render('Samples/sun.pcm' => Hacker::Synth::Sun->signal);
Hacker->render('Samples/saw.pcm' => Hacker::Synth::Saw->signal);

Hacker->render('Samples/sun-8bit.pcm' => map {int(Hacker->sun($_ * 220 / Hacker->sample_rate)*3)/3} 0 .. Hacker->sample_rate * 5);
Hacker->render('Samples/triangle.pcm' => Hacker::Synth::Triangle->signal);


1;
