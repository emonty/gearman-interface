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
      *ret_ptr= GEARMAN_WORK_FAIL;
      *result_size= 0;
      PyErr_Clear();
      if (result)
      {
        Py_DECREF(result);
      }
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


