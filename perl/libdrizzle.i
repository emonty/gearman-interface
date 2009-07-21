/* -*- mode: c; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 *  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 *  drizzle-interface: Interface Wrappers for Drizzle
 *  Copyright (C) 2008 Sun Microsystems, Inc.
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


%module libdrizzle

%include "interface/globals.i"

%include "interface/libdrizzle/drizzle.i"
%include "interface/libdrizzle/con.i"
%include "interface/libdrizzle/client.i"
%include "interface/libdrizzle/server.i"
%include "interface/libdrizzle/query.i"
%include "interface/libdrizzle/result.i"
%include "interface/libdrizzle/result_client.i"
%include "interface/libdrizzle/result_client_buffered.i"
%include "interface/libdrizzle/result_client_unbuffered.i"
%include "interface/libdrizzle/result_server.i"
%include "interface/libdrizzle/column.i"
%include "interface/libdrizzle/column_server.i"

%{

#define D_exception(excp, msg) do { sv_setpvf(GvSV(PL_errgv),#excp " %s\n", msg); SWIG_fail; } while (0)
#define D_exception_err(excp, err) do { sv_setpvf(GvSV(PL_errgv),#excp " %s\n", err.message); SWIG_fail; } while (0)

%}
