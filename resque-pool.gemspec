# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque/pool/version"

Gem::Specification.new do |s|
  s.name        = "mikezaschka-resque-pool"
  s.version     = Resque::Pool::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["nicholas a. evans", "Vito Botta", "Mike Zaschka"]
  s.email       = ["nick@ekenosen.net", "vito@botta.name", "mike.zaschka@dkd.de"]
  s.homepage    = "https://github.com/mikezaschka/resque-pool"
  s.summary     = "quickly and easily fork a pool of resque workers"
  s.description = <<-EOF
    quickly and easily fork a pool of resque workers,
    saving memory (w/REE) and monitoring their uptime
  EOF

  s.add_dependency "resque",  "~> 1.13"
  s.add_dependency "resque-scheduler"
  s.add_dependency "trollop", "~> 1.16"
  s.add_dependency "rake"
  s.add_development_dependency "rspec",    "~> 2.3.0"
  s.add_development_dependency "cucumber", "~> 0.10.0"
  s.add_development_dependency "aruba",    "~> 0.3.2"
  s.add_development_dependency "SystemTimer" unless RUBY_VERSION =~ /1\.9/ # to silence redis gem's warning
  s.add_development_dependency "bundler", "~> 1.0"

  # hidden files are automatically ignored by Dir.glob
  ignore_patterns = %w[**/*.gem **/*.pid **/*.log pkg Gemfile.lock]
  ignore_files    = ignore_patterns.inject([]) {|a,p| a + Dir[p] }
  s.files         = Dir["**/*"] - ignore_files
  s.test_files    = Dir.glob("{spec,features}/**/*.{rb,yml,feature}")
  s.executables   = 'resque-pool'
  s.require_paths = ["lib"]
end
