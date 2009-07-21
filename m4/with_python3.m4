dnl -*- mode: m4; c-basic-offset: 2; indent-tabs-mode: nil; -*-
dnl vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
dnl   
dnl drizzle-interface: Interface Wrappers for Drizzle
dnl Copyright (C) 2008 Sun Microsystems, Inc.
dnl 
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2 of the License, or
dnl (at your option) any later version.
dnl 
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl 
dnl You should have received a copy of the GNU General Public License
dnl along with this program; if not, write to the Free Software
dnl Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


AC_DEFUN([WITH_PYTHON3], [

  AC_ARG_WITH([python3], 
    [AS_HELP_STRING([--with-python3],
      [Build Python3 Bindings @<:@default=yes@:>@])],
    [with_python3=$withval], 
    [with_python3=yes])

  AS_IF([test "x$with_python3" != "xno"],[
    AS_IF([test "x$with_python3" != "xyes"],
      [PYTHON3=$with_python3],
      [AC_PATH_PROG([PYTHON3],[python3],[no])
       if test "x$PYTHON3" = "xno"
       then
         with_python3=no
       fi
      ]) 
  ])
])
