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

%rename(version) gearman_version;
%rename(bugreport) gearman_bugreport;

const char *gearman_version(void);
const char *gearman_bugreport(void);


typedef struct gearman_st {} Gearman;


%extend Gearman
{

  /* Initialize a library instance structure. */
  Gearman()
  {
    return gearman_create(NULL);
  }

  /* Free a library instance structure. */
  ~Gearman()
  {
    gearman_free($self);
  }

  /* Clone a library instance structure. */
  Gearman *copy()
  {
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

  gearman_options_t options()
  {
    return gearman_options($self);
  }

  void set_options(gearman_options_t options)
  {
    gearman_set_options($self, options);
  }

  void add_options(gearman_options_t options)
  {
    gearman_add_options($self, options);
  }

  void remove_options(gearman_options_t options)
  {
    gearman_remove_options($self, options);
  }

  int timeout()
  {
    return gearman_timeout($self);
  }

  void set_timeout(int timeout)
  {
    gearman_set_timeout($self, timeout);
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
