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

