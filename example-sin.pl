#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker::Player::ProAudio;
use Hacker::Player::Aplay;

my $player = new Hacker::Player::ProAudio;

$player->play(map {sin($_ * 880 * 3.1415 / 44100.0)} 0 .. 44100 * 5);


1;
