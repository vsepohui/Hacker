#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;
use Hacker::Synth::Sun;
use Hacker::Synth::Saw;
use Hacker::Synth::Sin;
use Hacker::Synth::Triangle;


$h->render('Samples/sine.pcm' => $h->sin);
$h->render('Samples/sun.pcm' => $h->sun);
$h->render('Samples/saw.pcm' => $h->saw);

$h->render('Samples/sun-8bit.pcm' => map {int ($_*3) / 3.0} $h->sun);
$h->render('Samples/triangle.pcm' => $h->triangle);


1;
