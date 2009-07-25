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

  if (!PyCallable_Check($input)) {
    PyErr_SetString(PyExc_TypeError, "Need a callable object!");
    return NULL;
  }
  $1= (gearman_callback *)PyMem_Malloc(sizeof(gearman_callback));
  $1->callback_obj= $input;
  Py_INCREF($input);

}


%{

/* TODO: I know this looks silly - it's cause we're going to add the job to it */

  typedef struct py_gearman_callback_st {
    PyObject *callback_obj;
  } gearman_callback;


  void* workerCallback(gearman_job_st *job, void *fn_arg,
                       size_t *result_size,
                       gearman_return_t *ret_ptr)
  {
    gearman_callback *cb= (gearman_callback *)fn_arg;
    PyObject *func = cb->callback_obj;   // Get Python callable
    PyObject *job_obj = PyBuffer_FromMemory((void *)gearman_job_workload(job),
                                            gearman_job_workload_size(job));

    PyObject *arglist = Py_BuildValue("(O)", job_obj);

    PyObject *result= PyObject_CallObject(func, arglist);

    PyObject *py_error= PyErr_Occurred();
    if (py_error != NULL)
    {
      *ret_ptr= GEARMAN_WORK_EXCEPTION;
      *result_size= 0;
      PyErr_Clear();
      return NULL;
    }

    *ret_ptr= GEARMAN_SUCCESS;
    char *py_result_str= NULL;
    if (PyString_Check(result)) {
      py_result_str= PyString_AsString(result);
      *result_size= (size_t)PyString_Size(result);
    } else if (PyByteArray_Check(result)) {
      py_result_str= PyByteArray_AsString(result);
      *result_size= (size_t)PyByteArray_Size(result);
    } else if (PyBuffer_Check(result)) {
      if (result == job_obj)
      {
        py_result_str= (char *)gearman_job_workload(job);
        *result_size= gearman_job_workload_size(job);
      } else {
        printf("error!\n");
        return NULL;
      }
    } else {
      printf("error\n");
      return NULL;
    }
      
  
    /* TODO: Make this use PyMem_Malloc - talk to eric about
     * how the malloc args work
     */
    void *result_bytes= malloc(*result_size+1); 
    memcpy(result_bytes, py_result_str, *result_size);

    PyMem_Free(cb);
    Py_DECREF(result);
    Py_DECREF(func);
    Py_DECREF(arglist);

    return result_bytes;
    
  }

%}

