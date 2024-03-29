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

%typemap(in) gearman_callback *worker_fn {

  $1= (gearman_callback *)malloc(sizeof(gearman_callback));
  $1->callback_obj= $input;
}


%{

/* TODO: I know this looks silly - it's cause we're going to add the job to it */

  typedef struct ruby_gearman_callback_st {
    VALUE callback_obj;
  } gearman_callback;


  void* workerCallback(gearman_job_st *job, void *fn_arg,
                       size_t *result_size,
                       gearman_return_t *ret_ptr)
  {
    gearman_callback *callback_data= (gearman_callback *)fn_arg;
    VALUE cb_obj = callback_data->callback_obj;
    VALUE job_obj = SWIG_NewPointerObj(SWIG_as_voidptr(job),
                                       SWIGTYPE_p_gearman_job_st, 0 | 0);

    VALUE ret= rb_funcall(cb_obj,rb_intern("call"), 1, job_obj);
    *result_size= (size_t)RSTRING(ret)->len;
    return (void *)STR2CSTR(ret);
  }


%}

