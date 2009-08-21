/* -*- mode: c++; c-basic-offset: 2; indent-tabs-mode: nil; -*-
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

typedef struct gearman_job_st {} Job;

%extend Job {

  gearman_return_t status(uint32_t numerator, uint32_t denominator) {
    return gearman_job_status($self, numerator, denominator);
  }

  gearman_return_t fail() {
    return gearman_job_fail($self);
  }

  /**
   * Get job handle.
   */
  char *getHandle() {
    return gearman_job_handle($self);
  }

  /**
   * Get the function name associated with a job.
   */
  char *functionName() {
    return gearman_job_function_name($self);
  }

  /**
   * Get the unique ID associated with a job.
   */
  const char *getUniqueID() {
    return gearman_job_unique($self);
  }

  gearman_workload getWorkload() {
    gearman_workload workload;
    workload.workload= gearman_job_workload($self);
    workload.workload_size= gearman_job_workload_size($self);
    return workload;
  }
};
