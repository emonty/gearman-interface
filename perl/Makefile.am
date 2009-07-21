# -*- Mode: Makefile -*-
#
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

EXTRA_LTLIBRARIES = libswig.la
libswig_la_SOURCES = libdrizzle.i

PERL_MAKEFILE=Makefile.perl

SWIG_OUTPUTS=lib/libdrizzle.pm libdrizzle_wrap.cc
PERL_CRUFT=pm_to_blib libdrizzle.bs libdrizzle_wrap.o
fakedir=$(prefix)
fake_DATA=blib/arch/auto/libdrizzle/libdrizzle.so

EXTRA_DIST=libdrizzle.i Makefile.PL libdrizzle/Makefile.PL

CLEANFILES=$(PERL_CRUFT) ${SWIG_OUTPUTS}

SWIG_OPTS=-perl5 -outdir lib

libdrizzle_wrap.cc: libdrizzle.i
	@${MKDIR_P} lib
	$(SWIG) $(SWIG_OPTS) -MD -MF ${DEPDIR}/$*.Tpo -o $@ $<
	@mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo

$(PERL_MAKEFILE): Makefile.PL libdrizzle_wrap.cc $(am__configure_deps)
	CC="${CC}" CFLAGS="-I${top_builddir} -I${top_srcdir} $(CPPFLAGS) $(CFLAGS) $(DRIZZLE_CFLAGS)" LDFLAGS="$(AM_LDFLAGS) $(DRIZZLE_LIBS) $(LDFLAGS) $(LIBS)" CC="${CC}" CXX="${CXX}" CPP="${CPP}" $(PERL) $(srcdir)/Makefile.PL $(MAKE_PL_OPTS) PREFIX="${prefix}"
	
blib/arch/auto/libdrizzle/libdrizzle.so: $(PERL_MAKEFILE) libdrizzle_wrap.cc
	DESTDIR=$(DESTDIR) $(MAKE) $(AM_MAKEFLAGS) -f $(PERL_MAKEFILE) PREFIX="${prefix}"

test-perl: $(PERL_MAKEFILE)
	$(RUN)$(MAKE) -f $(PERL_MAKEFILE) test

clean-perl realclean-perl:
	@target=`echo $@ | sed -e 's/-perl//'`; \
	if test -r $(PERL_MAKEFILE); then \
          $(MAKE) $(AM_MAKEFLAGS) -f $(PERL_MAKEFILE) $$target; \
        fi

# Perl make clean leaves the old makefile around
clean-local: realclean-perl
	rm -rf lib blib $(PERL_MAKEFILE) $(PERL_MAKEFILE).old build-perl-stamp

# See this is the fake bit
install-fakeDATA: install-perl

uninstall-local:
	cat `find $(DESTDIR)$(prefix) | grep drizzle..packlist` | xargs -n1 rm -rf
