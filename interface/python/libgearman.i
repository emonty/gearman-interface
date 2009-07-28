/* -*- mode: c; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 *  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 *  gearman-interface: Interface Wrappers for Gearman
 *  Copyright (C) 2009 Sun Microsystems, Inc.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

%module libgearman
%include "typemaps.i"

%include "interface/globals.i"

%include "interface/python/worker_callback.i"
%include "interface/python/do_return.i"

%include "interface/libgearman/gearman.i"
%include "interface/libgearman/client.i"
%include "interface/libgearman/worker.i"

%pythoncode %{

Client.do = new_instancemethod(_libgearman.Client_doJob,None,Client)
Worker.register = new_instancemethod(_libgearman.Worker_registerFunction,None,Worker)
Worker.unregister = new_instancemethod(_libgearman.Worker_unregisterFunction,None,Worker)

%}

