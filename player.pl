#!/usr/bin/perl

use 5.022;
use warnings;

use lib 'lib';

use Getopt::Long qw(GetOptions);

use Hacker::Player;

my $driver = 'ProAudio';
my $help   = 0;

GetOptions('driver=s' => \$driver, 'h|help' => \$help);
usage() if $help;

sub usage { say "Usage:\n\t$0 [--driver=...] [--help] perl-code-generator" and exit(); }

my $player = Hacker::Player->init($driver);
my $code = pop @ARGV or usage();

$player->play(eval $code);

1;
