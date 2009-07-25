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

if BUILD_PYTHON_SUBDIR
  BUILT_SOURCES += python/libgearman.c python/gearman/_libgearman.so
  CLEANFILES += python/libgearman.c python/gearman/libgearman.py python/gearman/_libgearman.so python/gearman/*pyc
  DISTCLEANFILES += python/gearman/librelease.py
endif


# perllocal.pod gets appended to, so we never want to delete it for real.
distuninstallcheck_listfiles=find . -type f \! -name  perllocal.pod -print 

distclean-local:
	$(RM) -fr autom4te.cache

test: check

python/gearman/_libgearman.so: python/libgearman.c
	@cd python ;python setup.py build_ext --inplace

python/libgearman.c: interface/python/libgearman.i
	@test ! -d $(builddir)/python/gearman && cp -a $(srcdir)/python/gearman $(builddir)/python || true

	${SWIG} -python -O -outdir ${builddir}/python/gearman -o $@ $<

