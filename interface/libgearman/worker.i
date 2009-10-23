/* -*- mode: c++; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 *  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 *  gearman-interface: Interface Wrappers for Gearman
 *  Copyright (C) 2008 Sun Microsystems, Inc.
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


typedef struct gearman_worker_st {} Worker;

%extend Worker {

  Worker() {
    return gearman_worker_create(NULL);
  }

  ~Worker() {
    gearman_worker_free($self);
  }

  Worker *copy() {
    return gearman_worker_clone(NULL, $self);
  }

  const char *error() {
    return gearman_worker_error($self);
  }

  int errno() {
    return gearman_worker_errno($self);
  }

  gearman_worker_options_t options() {
    return gearman_worker_options($self);
  }
  
  void setOptions(gearman_worker_options_t options) {
    gearman_worker_set_options($self, options);
  }
  
  void addOptions(gearman_worker_options_t options) {
    gearman_worker_add_options($self, options);
  }
  
  void removeOptions(gearman_worker_options_t options) {
    gearman_worker_remove_options($self, options);
  }

  int timeout() {
    return gearman_worker_timeout($self);
  }

  void setTimeout(int timeout) {
    gearman_worker_set_timeout($self, timeout);
  }
  
  gearman_return_t addServer(const char *host, in_port_t port) {
    return gearman_worker_add_server($self, host, port);
  }   

  gearman_return_t addServer(const char *host) {
    return gearman_worker_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t addServer() {
    return gearman_worker_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t addServers(const char *servers) {
    return gearman_worker_add_servers($self, servers);
  }

  /**
   * @TODO Uncomment this in 0.11
   *
  void removeServers() {
    gearman_worker_remove_servers($self);
  }
*/

  
  gearman_return_t registerFunction(const char *function_name,
                                    uint32_t timeout= 0) {
    return gearman_worker_register($self, function_name, timeout);
  }

  gearman_return_t unregister(const char *function_name) {
    return gearman_worker_unregister($self, function_name);
  }

  gearman_return_t unregisterAll() {
    return gearman_worker_unregister_all($self);
  }

  /**
   * @TODO: Handle Error
   */
  Job *grabJob() {
    gearman_return_t ret;
    return gearman_worker_grab_job($self, NULL, &ret);
  }

  gearman_return_t addFunction(const char *function_name,
                               gearman_callback *worker_fn, uint32_t timeout= 0)
  {
    return gearman_worker_add_function($self, function_name, timeout,
                                       workerCallback, (void *)worker_fn);
  }

  gearman_return_t work() {
    return gearman_worker_work($self);
  }

  /**
   * @TODO: do echo - some mapping of bytes to void * perhaps?
   */
  /*  gearman_return_t echo(const void *workload); */
};
