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

AC_PREREQ(2.59)
AC_INIT([gearman-interface],[0.0.2],[https://launchpad.net/gearman-interface])
AC_CONFIG_SRCDIR(interface/globals.i)
AC_CONFIG_AUX_DIR(config)
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])


PANDORA_CANONICAL_TARGET

PANDORA_REQUIRE_LIBGEARMAN

PANDORA_SWIG

PANDORA_WITH_PYTHON
PANDORA_WITH_RUBY


AC_CONFIG_FILES([Makefile python/gearman/release.py ])
AC_OUTPUT

