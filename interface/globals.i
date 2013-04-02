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

#if !defined(SWIGLUA) && !defined(SWIGXML)
%include "typemaps.i"
#endif

%include "exception.i"
%include "stdint.i"

%feature("autodoc", "1");

%{
#include <libgearman-1.0/gearman.h>

typedef struct gearman_st Gearman;
typedef struct gearman_client_st Client;
typedef struct gearman_worker_st Worker;
typedef struct gearman_job_st Job;

typedef enum enum_gearman_exception {
  GearmanException
} gearman_exception;

typedef struct gearman_workload_st {
  const void *workload;
  size_t workload_size;
} gearman_workload;

%}

%typedef struct gearman_client_st Client;
%typedef struct gearman_worker_st Worker;


%ignore gearman_workload_fn;
%ignore gearman_created_fn;
%ignore gearman_data_fn;
%ignore gearman_warning_fn;
%ignore gearman_status_fn;
%ignore gearman_complete_fn;
%ignore gearman_exception_fn;
%ignore gearman_fail_fn;
%ignore gearman_parse_server_fn;
%ignore gearman_worker_fn;
%ignore gearman_event_watch_fn;
%ignore gearman_malloc_fn;
%ignore gearman_free_fn;
%ignore gearman_task_context_free_fn;
%ignore gearman_log_fn;
%ignore gearman_con_protocol_context_free_fn;
%ignore gearman_packet_pack_fn;
%ignore gearman_packet_unpack_fn;

%include <libgearman-1.0/constants.h>

%typedef uint32_t in_port_t;

/* There should only ever be one of these per-function. Any more will have
 *    namespace collisions. But we specifically want to name it something
 *       known so we can reference it in exception handlers. */
%typemap(in, numinputs=0) (gearman_return_t *gearman_return_value)
%{
  gearman_return_t gearman_return_value;
  $1= &gearman_return_value;
%}

