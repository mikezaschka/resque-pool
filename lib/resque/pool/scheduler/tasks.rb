# -*- encoding: utf-8 -*-
require 'resque/pool/scheduler/cli'

namespace :resque do
  namespace :pool do
    namespace :scheduler do

     task :setup do
        @opts = {:daemon => true}
        @opts[:stdout]  ||= "log/resque-pool-scheduler.stdout.log"
        @opts[:stderr]  ||= "log/resque-pool-scheduler.stderr.log"
        @opts[:pidfile] ||= "tmp/pids/resque-pool-scheduler.pid"

        Rake::Task[:environment].invoke
      end

       desc "Launch the scheduler task as a daemon"
       task :start => %w[resque:setup resque:pool:setup resque:pool:scheduler:setup] do
         @opts.merge!(:environment => Rails.env)
         Resque::Pool::Scheduler.run(@opts)
       end

       desc "Stop the scheduler deamon task"
       task :stop => %w[resque:setup resque:pool:setup resque:pool:scheduler:setup] do
         if File.exists?(@opts[:pidfile])
           pid = File.open(@opts[:pidfile]).read
           Process.kill :QUIT, pid.to_i
           puts "Stopped scheduler (pid #{pid})."
         else
           puts "scheduler is not running"
         end
       end

     end
  end
end