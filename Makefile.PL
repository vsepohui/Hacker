#!/usr/bin/perl

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Hacker',
    AUTHOR       => q{Ivan Trunaev},
    PL_FILES 	 => { './hacker' },
);

1;
