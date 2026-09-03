#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Hacker::Player::ProAudio;
use Hacker::Player::Aplay;

my $player = new Hacker::Player::ProAudio;

my @signal = generate_sin(5);

$player->play(@signal);

sub generate_sin {
	my $len = shift;
	
	my @out;
	
	for (0 .. 44100 * $len) {
		my $t = $_ / 44100.0;
		my $s = sin($t * 880 * 3.1415);
		push @out, $s;
	}
	return @out;
}


1;
