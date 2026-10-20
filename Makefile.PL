#!/usr/bin/perl

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Hacker',
    AUTHOR       => 'Ivan Trunaev',
    EXE_FILES    => [ './bin/hacker' ],
    VERSION_FROM => 'lib/Hacker.pm',
    PREREQ_PM    => {'Strong::Random' => 0.9},
    
);

1;
