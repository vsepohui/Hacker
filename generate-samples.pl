#!/usr/bin/perl

use 5.022;
use warnings;

BEGIN {use FindBin qw($Bin); require "$Bin/_init.pl";};

use Hacker;

my $hacker = new Hacker;

$hacker->render('Samples/sine.pcm' => sine());
$hacker->render('Samples/sun.pcm' => sun());
$hacker->render('Samples/saw.pcm' => saw());

$hacker->render('Samples/sun-8bit.pcm' => map {int ($_*3) / 3.0} sun());
$hacker->render('Samples/triangle.pcm' => triangle());


1;
