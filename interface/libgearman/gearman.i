/* -*- mode: c++; c-basic-offset: 2; indent-tabs-mode: nil; -*-
 *  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
 *
 *  gearman-interface: Interface Wrappers for Drizzle
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


%rename(version) gearman_version;
%rename(bugreport) gearman_bugreport;

const char *gearman_version(void);
const char *gearman_bugreport(void);


typedef struct gearman_st {} Gearman;


%extend Gearman {

  /* Initialize a library instance structure. */
  Gearman() {
    return gearman_create(NULL);
  }

  /* Free a library instance structure. */
  ~Gearman() {
    gearman_free($self);
  }

  /* Clone a library instance structure. */
  Gearman *copy() {
    return gearman_clone(NULL, $self);
  }

  /* Return an error string for last library error encountered. */
  const char *error()
  {
    return gearman_error($self);
  }

  /* Value of errno in the case of a GEARMAN_ERRNO return value. */
  int errno()
  {
    return gearman_errno($self);
  }

  void setOptions(gearman_options_t options, uint32_t data)
  {
    gearman_set_options($self, options, data);
  }

  /**
   * Set logging callback for gearman instance.
   * @param gearman Gearman instance structure previously initialized with
   *        gearman_create.
   * @param log_fn Function to call when there is a logging message.
   * @param log_fn_arg Argument to pass into the log callback function.
   * @param verbose Verbosity level.
   */
/*TODO:
  void gearman_set_log(gearman_st *gearman, gearman_log_fn log_fn,
                       void *log_fn_arg, gearman_verbose_t verbose);
*/

  /**
   * Set custom I/O event callbacks for a gearman structure.
   */
/*TODO:
  void gearman_set_event_watch(gearman_st *gearman,
                               gearman_event_watch_fn *event_watch,
                               void *event_watch_arg);
*/


};
