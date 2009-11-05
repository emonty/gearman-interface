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

typedef struct gearman_client_st {} Client;

%extend Client {

  Client()
  {
    return gearman_client_create(NULL);
  }

  ~Client()
  {
    gearman_client_free($self);
  }

  Client *copy()
  {
    return gearman_client_clone(NULL, $self);
  }

  const char *error()
  {
    return gearman_client_error($self);
  }

  int errno()
  {
    return gearman_client_errno($self);
  }

  gearman_client_options_t options()
  {
    return gearman_client_options($self);
  }
  
  void set_options(gearman_client_options_t options)
  {
    gearman_client_set_options($self, options);
  }
  
  void add_options(gearman_client_options_t options)
  {
    gearman_client_add_options($self, options);
  }
  
  void remove_options(gearman_client_options_t options)
  {
    gearman_client_remove_options($self, options);
  }
  
  gearman_return_t add_server(const char *host, in_port_t port)
  {
    return gearman_client_add_server($self, host, port);
  }   

  gearman_return_t add_server(const char *host)
  {
    return gearman_client_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t add_server()
  {
    return gearman_client_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t add_servers(const char *servers)
  {
    return gearman_client_add_servers($self, servers);
  }

  void remove_servers()
  {
    gearman_client_remove_servers($self);
  }

  gearman_return_t do(const char *function_name,
                      const void *workload, size_t workload_size,
                      char **ret_val, size_t *ret_size,
                      const char *unique= NULL)
  {
    gearman_return_t ret;
    *ret_val= (void *)gearman_client_do($self, function_name, unique, workload,
                                        workload_size, ret_size, &ret);

    return ret;
  }

  gearman_return_t do_high(const char *function_name,
                          const void *workload, size_t workload_size,
                          char **ret_val, size_t *ret_size,
                          const char *unique= NULL)
  {
    gearman_return_t ret;
    *ret_val= (void *)gearman_client_do_high($self, function_name, unique,
                                             workload, workload_size,
                                             ret_size, &ret);

    return ret;
  }

  gearman_return_t do_low(const char *function_name,
                         const void *workload, size_t workload_size,
                         char **ret_val, size_t *ret_size,
                         const char *unique= NULL)
  {
    gearman_return_t ret;
    *ret_val= (void *)gearman_client_do_low($self, function_name, unique,
                                            workload, workload_size,
                                            ret_size, &ret);

    return ret;
  }

  const char *do_job_handle()
  {
    return gearman_client_do_job_handle($self);
  }

  void do_status(uint32_t *numerator, uint32_t *denominator)
  {
    gearman_client_do_status($self, numerator, denominator);
  }

   
  gearman_return_t do_background(const char *function_name,
                                 const void *workload,
                                 size_t workload_size,
                                 char *job_handle_out,
                                 const char *unique= NULL)
  {
    return gearman_client_do_background($self, function_name, unique,
                                        workload, workload_size,
                                        job_handle_out);
  }

  gearman_return_t do_high_background(const char *function_name,
                                      const void *workload,
                                      size_t workload_size,
                                      char *job_handle_out,
                                      const char *unique= NULL)
  {
    return gearman_client_do_high_background($self, function_name, unique,
                                             workload, workload_size,
                                             job_handle_out);
  }

  gearman_return_t do_low_background(const char *function_name,
                                     const void *workload,
                                     size_t workload_size,
                                     char *job_handle_out,
                                     const char *unique= NULL)
  {
    return gearman_client_do_low_background($self, function_name, unique,
                                            workload, workload_size,
                                            job_handle_out);
  }

  %apply bool *OUTPUT { bool *is_known, bool *is_running };
  %apply uint32_t *OUTPUT { uint32_t *numerator, uint32_t *denominator };
  gearman_return_t job_status(const char *job_handle,
                              bool *is_known, bool *is_running,
                              uint32_t *numerator,
                              uint32_t *denominator)
  {
    return gearman_client_job_status($self, job_handle, is_known, is_running,
                                     numerator, denominator);
  }


};
