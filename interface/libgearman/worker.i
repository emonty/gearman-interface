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

typedef struct gearman_worker_st {} Worker;

%extend Worker
{

  Worker()
  {
    return gearman_worker_create(NULL);
  }

  ~Worker()
  {
    gearman_worker_free($self);
  }

  Worker *copy()
  {
    return gearman_worker_clone(NULL, $self);
  }

  const char *error()
  {
    return gearman_worker_error($self);
  }

  int errno()
  {
    return gearman_worker_errno($self);
  }

  gearman_worker_options_t options()
  {
    return gearman_worker_options($self);
  }
  
  void set_options(gearman_worker_options_t options)
  {
    gearman_worker_set_options($self, options);
  }
  
  void add_options(gearman_worker_options_t options)
  {
    gearman_worker_add_options($self, options);
  }
  
  void remove_options(gearman_worker_options_t options)
  {
    gearman_worker_remove_options($self, options);
  }

  int timeout()
  {
    return gearman_worker_timeout($self);
  }

  void set_timeout(int timeout)
  {
    gearman_worker_set_timeout($self, timeout);
  }
  
  gearman_return_t add_server(const char *host, in_port_t port)
  {
    return gearman_worker_add_server($self, host, port);
  }   

  gearman_return_t add_server(const char *host)
  {
    return gearman_worker_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t add_server()
  {
    return gearman_worker_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t add_servers(const char *servers)
  {
    return gearman_worker_add_servers($self, servers);
  }

  /**
   * @TODO Uncomment this in 0.11
   *
  void removeServers()
  {
    gearman_worker_remove_servers($self);
  }
*/

  
  gearman_return_t register_function(const char *function_name,
                                    uint32_t timeout= 0)
  {
    return gearman_worker_register($self, function_name, timeout);
  }

  gearman_return_t unregister_function(const char *function_name)
  {
    return gearman_worker_unregister($self, function_name);
  }

  gearman_return_t unregister_all()
  {
    return gearman_worker_unregister_all($self);
  }

  /**
   * @TODO: Handle Error
   */
  Job *grabJob()
  {
    gearman_return_t ret;
    return gearman_worker_grab_job($self, NULL, &ret);
  }

  gearman_return_t add_function(const char *function_name,
                                gearman_callback *worker_fn,
                                uint32_t timeout= 0)
  {
    return gearman_worker_add_function($self, function_name, timeout,
                                       workerCallback, (void *)worker_fn);
  }

  gearman_return_t work()
  {
    return gearman_worker_work($self);
  }

  gearman_return_t echo(const void *workload, size_t workload_size)
  {
    return gearman_worker_echo($self, workload, workload_size);
  }
};
