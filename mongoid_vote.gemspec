# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid_vote/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_vote"
  s.version     = MongoidVote::VERSION
  s.authors     = ["incorvia"]
  s.email       = ["incorvia@gmail.com"]
  s.homepage    = "http://www.kevinincorvia.com"
  s.summary     = %q{Mongoid Vote}
  s.description = %q{A basic Mongoid voting gem which allows voting on embedded documents.}

  s.rubyforge_project = "mongoid_vote"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
