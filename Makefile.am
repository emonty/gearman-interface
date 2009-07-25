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
SUBDIRS=

if BUILD_PYTHON
  BUILT_SOURCES += python/libgearman.c python/gearman/_libgearman.so
  CLEANFILES += python/libgearman.c python/gearman/libgearman.py python/gearman/_libgearman.so python/gearman/*pyc
  DISTCLEANFILES += python/gearman/librelease.py
endif

python/gearman/_libgearman.so: python/libgearman.c
	@cd python ;python setup.py build_ext --inplace

python/libgearman.c: interface/python/libgearman.i
	@test ! -d $(builddir)/python/gearman && cp -a $(srcdir)/python/gearman $(builddir)/python || true

	${SWIG} -python -O -outdir ${builddir}/python/gearman -o $@ $<

rubydir= ${RUBY_DIR}
ruby_LTLIBRARIES=
if BUILD_RUBY
  BUILT_SOURCES += ruby/libgearman.c
  EXTRA_DIST += ruby/libgearman.c
  CLEANFILES += ruby/libgearman.c
  ruby_LTLIBRARIES += ruby/libgearman.la

  ruby_libgearman_la_CPPFLAGS=  ${AM_CPPFLAGS} ${RUBY_INCLUDES}
  ruby_libgearman_la_CFLAGS=
  ruby_libgearman_la_SOURCES= ruby/libgearman.c
  ruby_libgearman_la_LDFLAGS= -avoid-version -module ${RUBY_LDFLAGS}

endif

ruby/libgearman.c: interface/ruby/libgearman.i
	${SWIG} -ruby -o $@ $<


distclean-local:
	$(RM) -fr autom4te.cache

test: check


