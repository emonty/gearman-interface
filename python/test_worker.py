#!/usr/bin/env python
# -*- mode: python; c-basic-offset: 2; indent-tabs-mode: nil; -*-
#  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
#  gearman-interface: Interface Wrappers for Gearman
#
#   Copyright (C) 2009 David Lenwell
#   Copyright (C) 2009 Monty Taylor
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

from gearman import libgearman

def worker_func(job):
  """ nothing """ 
  print "%s{%s} called" % (job.function_name(), job.unique())
  workload= job.get_workload()
  print workload
  return workload

worker = libgearman.Worker()
worker.set_timeout(5000)
worker.add_server('localhost')
worker.add_function("worker_func", worker_func)
ret= libgearman.GEARMAN_SUCCESS
while ret == libgearman.GEARMAN_SUCCESS or ret == libgearman.GEARMAN_TIMEOUT:
  ret= worker.work() 
  if ret == libgearman.GEARMAN_TIMEOUT:
    print "Hit timeout - restarting"
