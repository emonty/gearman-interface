#!/usr/bin/env ruby
# -*- mode: ruby; c-basic-offset: 2; indent-tabs-mode: nil; -*-
#  vim:expandtab:shiftwidth=2:tabstop=2:smarttab:
#  gearman-interface: Interface Wrappers for Gearman
#  Copyright (c) 2009 Monty Taylor
#  All rights reserved.
# 
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
# 
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. The name of the author may not be used to endorse or promote products
#     derived from this software without specific prior written permission.
# 
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
#  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
#  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
#  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

require 'ext/gearman'

class WorkerCallback
  def call(job)
    workload= job.get_workload
    func_name= job.function_name
    unique_id= job.unique
    puts "#{func_name}{#{unique_id}} called" 
    puts workload
    return workload
  end
end


worker = Gearman::Worker.new
worker.add_server('localhost')
worker.set_timeout(5000)
worker.add_function("worker_func", WorkerCallback.new)
ret= Gearman::GEARMAN_SUCCESS
while true
  if ret == Gearman::GEARMAN_SUCCESS or ret == Gearman::GEARMAN_TIMEOUT
    ret= worker.work()
    if ret == Gearman::GEARMAN_TIMEOUT
      puts "Hit timeout - restarting"
    end
  else
    break
  end
end

