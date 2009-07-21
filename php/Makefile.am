# -*- Mode: Makefile -*-
#  drizzle-interface: Interface Wrappers for Drizzle
#  Copyright (C) 2008 Sun Microsystems, Inc.
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or 
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

EXTRA_LTLIBRARIES= libswig.la
libswig_la_SOURCES= libdrizzle.i

phparchdir=${PHP_EXTDIR}
nobase_phparch_LTLIBRARIES= drizzle/libdrizzle.la

drizzle_libdrizzle_la_SOURCES= libdrizzle.cc
drizzle_libdrizzle_la_CXXFLAGS= ${DRIZZLE_CFLAGS} ${PHP_CPPFLAGS}
drizzle_libdrizzle_la_LIBADD= ${DRIZZLE_LIBS}
drizzle_libdrizzle_la_LDFLAGS= -module -avoid-version
drizzle_libdrizzle_la_DEPENDENCIES= libdrizzle.so

BUILT_SOURCES= libdrizzle.cc

CLEANFILES=core* libdrizzle.cc libdrizzle.so php_libdrizzle.h libdrizzle.php

SWIG_OPTS=-php

SUFFIXES = .cc .i

.i.cc:
	$(SWIG) $(SWIG_OPTS) -MD -MF ${DEPDIR}/$*.Tpo -o $@ $<
	@mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo

drizzle/libdrizzle.cc: libdrizzle.i

libdrizzle.so:
	@ln -sf drizzle/.libs/libdrizzle.so libdrizzle.so
	
distclean-local:
	rm -rf drizzle

