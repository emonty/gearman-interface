#!/usr/bin/env perl

use ExtUtils::MakeMaker;

$CFLAGS=$ENV{CFLAGS} || "";
$LDFLAGS=$ENV{LDFLAGS} || ""; 


WriteMakefile(
    'NAME'	=> "libdrizzle",
    'AUTHOR'    => 'Monty Taylor <mordred@inaugust.com>',
    'ABSTRACT'  => "DBD::Drizzle",

    'DEFINE'    => "-DHAVE_CONFIG_H $CFLAGS",
    'OBJECT'    => "libdrizzle_wrap.o",
    'dynamic_lib' => {'OTHERLDFLAGS' => "$CFLAGS $LDFLAGS -lstdc++"},

    'MAKEFILE'  => 'Makefile.perl',
    'clean' => { FILES => "libdrizzle_wrap.cc libdrizzle_wrap.o libdrizzle.bs" },
);
