# -*- Mode: Makefile -*-

EXTRA_LTLIBRARIES= libswig.la
libswig_la_SOURCES= libdrizzle.i

rubyarchdir=$(prefix)/$(RUBY_ARCH_DIR)
nobase_rubyarch_LTLIBRARIES=drizzle/libdrizzle.la
drizzle_libdrizzle_la_SOURCES= libdrizzle.cc
drizzle_libdrizzle_la_CXXFLAGS= ${DRIZZLE_CFLAGS} ${RUBY_INCLUDES}
drizzle_libdrizzle_la_LIBADD= ${DRIZZLE_LIBS}
drizzle_libdrizzle_la_LDFLAGS= -module -avoid-version
drizzle_libdrizzle_la_DEPENDENCIES= drizzle/libdrizzle.so

BUILT_SOURCES= libdrizzle.cc

CLEANFILES=*.db test-out.rdf core* libdrizzle.cc drizzle/libdrizzle.so

SWIG_OPTS=-ruby -autorename


SUFFIXES = .cc .i

.i.cc:
	$(MKDIR_P) drizzle
	$(SWIG) $(SWIG_OPTS) -MD -MF ${DEPDIR}/$*.Tpo -o $@ $<
	@mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo

libdrizzle.cc: libdrizzle.i

drizzle/libdrizzle.so:
	@ln -sf .libs/libdrizzle.so drizzle/libdrizzle.so
	
distclean-local:
	rm -rf drizzle

