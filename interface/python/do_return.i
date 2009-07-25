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

%typemap(in) (const void *workload, size_t workload_size) {
    char *py_result_str= PyString_AsString($input);
    $2= (size_t)PyString_Size($input);
    /* TODO: Make this use PyMem_Malloc - talk to eric about
     * how the malloc args work
     */
    $1= malloc($2);
    memcpy($1, py_result_str, $2);
  
}

%typemap(in, numinputs=0) size_t *result_size (size_t rsize) {
  $1= &rsize;
}

%typemap(out) void * {

  $result=PyBuffer_FromMemory($1, arg4);
}


