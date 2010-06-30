/* -*- mode: c; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 * vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 * gearman-interface: Interface Wrappers for Gearman
 * Copyright (c) 2009 Monty Taylor
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products
 *     derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

%module gearman

%include "interface/globals.i"

%typemap(in) (const void *workload, size_t workload_size)
{
  $1 = STR2CSTR($input);
  $2 = (size_t)RSTRING($input)->len;
}


%rename(Client) gearman_client_st;
%rename(Worker) gearman_worker_st;

%include "interface/ruby/worker_callback.i"
%include "interface/ruby/value_return.i"
%include "interface/ruby/gearman_workload.i"
%include "interface/ruby/job_handle_out.i"

%include "interface/libgearman/client.i"
%include "interface/libgearman/worker.i"
%include "interface/libgearman/job.i"


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

