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


struct Client {};

%extend Client {

  Client() {
    return gearman_client_create(NULL);
  }

  ~Client() {
    gearman_client_free($self);
  }

  Client *copy() {
    return gearman_client_clone(NULL, $self);
  }

  const char *error() {
    return gearman_client_error($self);
  }

  int errno() {
    return gearman_client_errno($self);
  }

  void setOptions(gearman_client_options_t options, uint32_t data) {
    return gearman_client_set_options($self, options, data);
  }
  
  gearman_return addServer(const char *host, in_port_t port) {
    return gearman_client_add_server($self, host, port);
  }   

  gearman_return_t addServer(const char *host) {
    return gearman_client_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t addServer() {
    return gearman_client_add_server($self,
                                     GEARMAN_DEFAULT_TCP_HOST,
                                     GEARMAN_DEFAULT_TCP_PORT);
  }   

  gearman_return_t addServers(const char *servers) {
    return gearman_client_add_servers($self, servers);
  }


  /**
   * @TODO Handle errors
   */
  void *doJob(const char *function_name, const char *unique,
              const void *workload, size_t workload_size, size_t *result_size)
  {
    gearman_return_t ret;
    void *results= gearman_client_do($self, function_name, unique, workload,
                                     workload_size, result_size, &ret);

    return results;
  }

  /**
   * @TODO Handle errors
   */
  void *doHigh(const char *function_name, const char *unique,
               const void *workload, size_t workload_size, size_t *result_size)
  {
    gearman_return_t ret;
    void *results= gearman_client_do_high($self, function_name, unique, workload,
                                          workload_size, result_size, &ret);

    return results;
  }

  /**
   * @TODO Handle errors
   */
  void *doLow(const char *function_name, const char *unique,
              const void *workload, size_t workload_size, size_t *result_size)
  {
    gearman_return_t ret;
    void *results= gearman_client_do_low($self, function_name, unique, workload,
                                         workload_size, result_size, &ret);

    return results;
  }

};
