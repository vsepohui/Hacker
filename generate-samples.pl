#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker qw($h);
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Sin;
use Hacker::Synth::Triangle;


$h->render('Samples/sine.pcm' => Hacker::Synth::Sin->signal);
$h->render('Samples/sun.pcm' => Hacker::Synth::Sun->signal);
$h->render('Samples/saw.pcm' => Hacker::Synth::Saw->signal);

$h->render('Samples/sun-8bit.pcm' => map {int($h->sun($_ * 220 / $h->sample_rate)*3)/3} 0 .. $h->sample_rate * 5);
$h->render('Samples/triangle.pcm' => Hacker::Synth::Triangle->signal);


1;
