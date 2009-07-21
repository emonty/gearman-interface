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

#if !defined(SWIGLUA) && !defined(SWIGXML)
%include "typemaps.i"
#endif

%include "exception.i"
%include "stdint.i"

%{
#include <libgearman/gearman.h>

typedef struct gearman_st Gearman;
typedef struct gearman_client_st Client;
typedef struct gearman_worker_st Worker;
typedef struct gearman_job_st Job;
typedef gearman_return_t gearman_return;

typedef enum enum_gearman_exception {
  GearmanException
} gearman_exception;

%}

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
%ignore gearman_task_fn_arg_free_fn;
%ignore gearman_log_fn;
%ignore gearman_server_log_fn;
%ignore gearman_server_thread_log_fn;
%ignore gearmand_log_fn;
%ignore gearman_server_thread_run_fn;
%ignore gearman_con_add_fn;
%ignore gearman_con_recv_fn;
%ignore gearman_con_protocol_data_free_fn;
%ignore gearman_con_recv_data_fn;
%ignore gearman_con_send_fn;
%ignore gearman_con_send_data_fn;
%ignore gearman_packet_pack_fn;
%ignore gearman_packet_unpack_fn;
%ignore gearman_queue_add_fn;
%ignore gearman_queue_flush_fn;
%ignore gearman_queue_done_fn;
%ignore gearman_queue_replay_fn;

%include <libgearman/constants.h>

%typedef uint32_t in_port_t;


%typemap(in, numinputs=0) (field_buffered *field, size_t *size)
%{
  field_buffered field$1;
  size_t size$2;

  $1= &field$1;
  $2= &size$2;
%}

%typemap(in, numinputs=0) (row_buffered *buffer)
%{
  row_buffered the_row$1;
  $1= &the_row$1;
%}

