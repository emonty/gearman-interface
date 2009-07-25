/* -*- mode: c++; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 *  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 *  gearman-interface: Interface Wrappers for Gearman
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

%module libgearman

%include "interface/globals.i"

%typemap(in) (const char *query, size_t size) {

  $1 = STR2CSTR($input);
  $2 = (size_t)RSTRING($input)->len;
 }

%include "interface/ruby/worker_callback.i"

%include "interface/libgearman/gearman.i"
%include "interface/libgearman/client.i"
%include "interface/libgearman/worker.i"


%{

#define D_exception(code,msg) do { gearman_raise_exception(code, msg); SWIG_fail; } while(0);
#define D_exception_err(code,err) do { gearman_raise_exception(code, err.message); SWIG_fail; } while(0);

#define getExceptionMethod(excptype,eparent) \
  SWIGINTERN VALUE \
get ## excptype () { \
  static int init ## excptype = 0 ; \
  static VALUE rb_e ## excptype ; \
  VALUE rb_eparent = gearman_get_exception (eparent); \
  if (! init ## excptype ) { \
    init ## excptype = 1; \
    rb_e ## excptype = rb_define_class(#excptype , rb_eparent); \
  } \
  return rb_e ## excptype ; \
}

SWIGINTERN VALUE getGearmanException() {
  static int initGearmanException = 0 ;
  static VALUE rb_eGearmanException;
  if (! initGearmanException ) {
    initGearmanException = 1;
    rb_eGearmanException = rb_define_class("GearmanException", rb_eRuntimeError);
  }
  return rb_eGearmanException ;
}

VALUE gearman_get_exception(gearman_exception excpcode);

getExceptionMethod(SubGearmanException,GearmanException);

void gearman_raise_exception(gearman_exception excpcode, const char * msg) {
  rb_raise(gearman_get_exception(excpcode),msg);
}

VALUE gearman_get_exception(gearman_exception excpcode) {

 VALUE exception;

 switch (excpcode) {
 case GearmanException:
   exception = getGearmanException();
   break;
 default:
   exception = rb_eRuntimeError;
   break;
 }
 return exception;
}

 %}

