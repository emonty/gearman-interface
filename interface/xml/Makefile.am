EXTRA_LTLIBRARIES= libswig.la
libswig_la_SOURCES= libdrizzle.i

CLEANFILES= libdrizzle.xml

all: libdrizzle.xml

SWIG_OPTS=-xml


SUFFIXES = .xml .i
.i.xml:
	$(SWIG) $(SWIG_OPTS) -MD -MF ${DEPDIR}/$*.Tpo -o $@ $<
	@mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo

libdrizzle.xml: libdrizzle.i

distclean-local:
	rm -rf drizzle


