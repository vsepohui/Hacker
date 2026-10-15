#!/usr/bin/perl

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Hacker',
    AUTHOR       => q{Ivan Trunaev},
    EXE_FILES 	 => [ './bin/hacker' ],
);

1;
