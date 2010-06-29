# -*- Mode: Makefile -*-
#  gearman-interface: Interface Wrappers for Gearman
#  Copyright (c) 2009 Monty Taylor
#  All rights reserved.
# 
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
# 
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. The name of the author may not be used to endorse or promote products
#     derived from this software without specific prior written permission.
# 
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
#  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

ACLOCAL_AMFLAGS = -I m4
BUILT_SOURCES= libgearman.xml
EXTRA_DIST= interface/globals.i \
    interface/libgearman/*.i \
    interface/lua/*.i \
    interface/python/*.i \
    interface/ruby/*.i \
    interface/xml/*.i
CLEANFILES= libgearman.xml
DISTCLEANFILES=
# Trick automake into making depdirs in the right places.
EXTRA_LTLIBRARIES= libswig.la
libswig_la_SOURCES= interface/xml/libgearman.i

libgearman.xml: interface/xml/libgearman.i
	$(MKDIR_P) $(DEPDIR)
	$(SWIG) $(SWIG_OPTS) -xml -MD -MF ${DEPDIR}/$*.Tpo -o $@ $<
	@mv -f $(DEPDIR)/$*.Tpo $(DEPDIR)/$*.Plo

luaarchdir=${LUA_ARCHDIR}
luaarch_LTLIBRARIES=
if BUILD_LUA
  libswig_la_SOURCES+= interface/lua/libgearman.i
  BUILT_SOURCES+= lua/libgearman.c
  luaarch_LTLIBRARIES+= lua/gearman/libgearman.la
  CLEANFILES+=lua/*.db lua/test-out.rdf lua/core* lua/libgearman.c lua/gearman/libgearman.so

  lua_gearman_libgearman_la_SOURCES= lua/libgearman.c
  lua_gearman_libgearman_la_CFLAGS= ${LUA_CFLAGS}
  lua_gearman_libgearman_la_LIBADD= ${LTMEMCACHED} ${LUA_LDFLAGS}
  lua_gearman_libgearman_la_LDFLAGS= -module -avoid-version
endif
lua/libgearman.c: interface/lua/libgearman.i
	$(MKDIR_P) lua/$(DEPDIR)
	$(SWIG) -lua -MD -MF lua/$(DEPDIR)/$(@F).Tpo -o $@ $<
	@mv -f lua/$(DEPDIR)/$(@F).Tpo lua/$(DEPDIR)/$(@F).Plo

if BUILD_PYTHON
  libswig_la_SOURCES+= interface/python/libgearman.i python/libgearman.c
  BUILT_SOURCES += python/libgearman.c python/gearman/_libgearman.so
  CLEANFILES += python/libgearman.c python/gearman/libgearman.py python/gearman/_libgearman.so python/gearman/*pyc
  DISTCLEANFILES += python/gearman/release.py
endif

python/gearman/_libgearman.so: python/libgearman.c
	@cd python ;${PYTHON} setup.py build_ext --inplace

python/libgearman.c: interface/python/libgearman.i
	$(MKDIR_P) python/$(DEPDIR)
	@test ! -d $(builddir)/python/gearman && cp -a $(srcdir)/python/gearman $(builddir)/python || true

	${SWIG} -python -O -outdir ${builddir}/python/gearman -MD -MF python/$(DEPDIR)/libgearman.Tpo -o $@ $<
	@mv -f python/$(DEPDIR)/libgearman.Tpo python/$(DEPDIR)/libgearman.Plo

if BUILD_PYTHON3
  libswig_la_SOURCES+= interface/python/libgearman.i python3/libgearman.c
  BUILT_SOURCES += python3/libgearman.c python3/gearman/_libgearman.so
  CLEANFILES += python3/libgearman.c python3/gearman/libgearman.py python3/gearman/_libgearman.so python3/gearman/*pyc
  DISTCLEANFILES += python3/gearman/release.py
endif

python3/gearman/_libgearman.so: python3/libgearman.c
	@cd python3 ;${PYTHON3} setup.py build_ext --inplace

python3/libgearman.c: interface/python/libgearman.i
	$(MKDIR_P) python3/$(DEPDIR)
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
	$(MKDIR_P) ruby/$(DEPDIR)
	$(SWIG) -ruby -autorename -o $@ $<


distclean-local:
	$(RM) -fr autom4te.cache

test: check


