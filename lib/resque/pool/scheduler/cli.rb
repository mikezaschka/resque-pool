require 'resque'
require 'resque/pool/version'
require 'resque/pool/logging'
require 'resque/pool/cli'

module Resque
  class Pool

    # Quick and dirty way to use the pool daemon/logging/rake stuff
    # to work with the scheduler gem.
    module Scheduler
      module CLI
        include Resque::Pool::CLI
        extend Resque::Pool::CLI
        extend Resque::Pool::Logging
        extend self

        def run(options={})
          opts = parse_options
          opts.merge!(options)
          daemonize if opts[:daemon]
          manage_pidfile opts[:pidfile]
          redirect opts
          setup_environment opts
          Resque::Scheduler.run
        end

    end
  end
end