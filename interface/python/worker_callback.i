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

%fragment("workerCallback","header",fragment="SWIG_AsCharPtrAndSize")
%{

  typedef PyObject* gearman_callback;


  void* workerCallback(gearman_job_st *job, void *fn_arg,
                       size_t *result_size,
                       gearman_return_t *ret_ptr)
  {
    PyObject *func= (PyObject *)fn_arg;
    PyObject *job_obj = SWIG_NewPointerObj(SWIG_as_voidptr(job),
                                           SWIGTYPE_p_gearman_job_st, 0 |  0 );

    PyObject *arglist = Py_BuildValue("(O)", job_obj);

    PyObject *result= PyObject_CallObject(func, arglist);
    Py_DECREF(job_obj);
    Py_DECREF(arglist);

    PyObject *py_error= PyErr_Occurred();
    if (py_error != NULL)
    {
      *ret_ptr= GEARMAN_WORK_EXCEPTION;
      *result_size= 0;
      PyErr_Clear();
      Py_DECREF(result);
      return NULL;
    }

    *ret_ptr= GEARMAN_SUCCESS;

    char *py_result_str= NULL;

    int alloc= SWIG_NEWOBJ;
    int res= SWIG_AsCharPtrAndSize(result, &py_result_str, result_size, &alloc);
    Py_DECREF(result);
    /* SWIG_AsCharPtrAndSize adds one to the size - I'm not sure why */
    *result_size-= 1;
    if (res<0)
    { 
      return NULL;
    }

    return py_result_str;
    
  }

%}

%typemap(in, fragment="workerCallback") gearman_callback *worker_fn {

  if (!PyCallable_Check($input)) {
    PyErr_SetString(PyExc_TypeError, "Need a callable object!");
    return NULL;
  }
  $1= (void *)$input;
  Py_INCREF($input);

}


