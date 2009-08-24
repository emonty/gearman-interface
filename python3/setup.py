#!/usr/bin/env python
# -*- mode: python; c-basic-offset: 2; indent-tabs-mode: nil; -*-
#  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
##  drizzle-interface: Interface Wrappers for Drizzle
##  Copyright (C) 2008 Sun Microsystems, Inc.
##    
##    This program is free software; you can redistribute it and/or modify
##    it under the terms of the GNU General Public License as published by
##    the Free Software Foundation; either version 2 of the License, or 
##    (at your option) any later version.
##    
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program; if not, write to the Free Software
##    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

from distutils.core import setup
from distutils.core import Extension
from gearman.release import version

import os.path, os
import sys

description = """Python3 wrapper of libgearman"""

classifiers=[
"Development Status :: 3 - Alpha", 
"Intended Audience :: Developers", 
"License :: OSI Approved :: BSD License", 
"Operating System :: POSIX :: Linux", 
"Operating System :: POSIX :: SunOS/Solaris", 
"Operating System :: MacOS :: MacOS X", 
"Programming Language :: C", 
"Programming Language :: Python", 
"Topic :: Software Development :: Libraries :: Python Modules", 
]

setup(name="python3-libgearman",
      version=version,
      description=description,
      long_description=description,
      author="Monty Taylor",
      author_email="mordred@inaugust.com",
      url="http://launchpad.net/gearman-interface",
      platforms="linux",
      license="BSD",
      classifiers=classifiers,

      ext_modules=[
        Extension("gearman._libgearman",
                  sources=["libgearman.c"],
                  libraries=["gearman"],
                  ),
        ],
      #test_suite = "tests.AllTests.test_all",
      packages=["gearman"],
      )

