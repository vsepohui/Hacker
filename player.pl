#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker::Player::ProAudio;
use Hacker::Player::Aplay;

my $player = new Hacker::Player::ProAudio;
my $code = $ARGV[0] or die "Usage:\n\t$0 perl-code-generator";

$player->play(eval $code);


1;
