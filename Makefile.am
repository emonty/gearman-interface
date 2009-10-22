# -*- Mode: Makefile -*-
#  gearman-interface: Interface Wrappers for Gearman
#  Copyright (C) 2009 Sun Microsystems, Inc.
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

ACLOCAL_AMFLAGS = -I m4
BUILT_SOURCES=
EXTRA_DIST= $(srcdir)/interface/globals.i \
    ${srcdir}/interface/libgearman/*.i \
    ${srcdir}/interface/python/*.i \
    ${srcdir}/autogen.sh
CLEANFILES=
DISTCLEANFILES=
# Trick automake into making depdirs in the right places.
EXTRA_LTLIBRARIES= libswig.la
libswig_la_SOURCES=

if BUILD_PYTHON
  libswig_la_SOURCES+= python/libgearman.i python/libgearman.c
  BUILT_SOURCES += python/libgearman.c python/gearman/_libgearman.so
  CLEANFILES += python/libgearman.c python/gearman/libgearman.py python/gearman/_libgearman.so python/gearman/*pyc
  DISTCLEANFILES += python/gearman/release.py
endif

python/gearman/_libgearman.so: python/libgearman.c
	@cd python ;${PYTHON} setup.py build_ext --inplace

python/libgearman.c: interface/python/libgearman.i
	@test ! -d $(builddir)/python/gearman && cp -a $(srcdir)/python/gearman $(builddir)/python || true

	${SWIG} -python -O -outdir ${builddir}/python/gearman -MD -MF python/$(DEPDIR)/libgearman.Tpo -o $@ $<
	@mv -f python/$(DEPDIR)/libgearman.Tpo python/$(DEPDIR)/libgearman.Plo

if BUILD_PYTHON3
  libswig_la_SOURCES+= python3/libgearman.i python3/libgearman.c
  BUILT_SOURCES += python3/libgearman.c python3/gearman/_libgearman.so
  CLEANFILES += python3/libgearman.c python3/gearman/libgearman.py python3/gearman/_libgearman.so python3/gearman/*pyc
  DISTCLEANFILES += python3/gearman/release.py
endif

python3/gearman/_libgearman.so: python3/libgearman.c
	@cd python3 ;${PYTHON3} setup.py build_ext --inplace

python3/libgearman.c: interface/python3/libgearman.i
	@test ! -d $(builddir)/python3/gearman && cp -a $(srcdir)/python3/gearman $(builddir)/python3 || true

	${SWIG} -python -py3 -O -outdir ${builddir}/python3/gearman -MD -MF python3/$(DEPDIR)/libgearman.Tpo -o $@ $<
	@mv -f python3/$(DEPDIR)/libgearman.Tpo python3/$(DEPDIR)/libgearman.Plo

if BUILD_RUBY
  libswig_la_SOURCES+= interface/ruby/libgearman.i
  BUILT_SOURCES += ruby/ext/gearman.c ruby/ext/gearman.so
  CLEANFILES += ruby/*.db ruby/core* ruby/ext/gearman.c ruby/ext/gearman.so
endif

ruby/ext/gearman.so:
	cp ${top_srcdir}/ChangeLog ${top_builddir}/ruby/CHANGELOG
	@cd ruby && rake manifest && rake compile

ruby/ext/gearman.c: interface/ruby/libgearman.i
	$(SWIG) -ruby -autorename -o $@ $<


distclean-local:
	$(RM) -fr autom4te.cache

test: check


