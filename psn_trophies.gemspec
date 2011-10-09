# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "psn_trophies/version"

Gem::Specification.new do |s|
  s.name        = "psn_trophies"
  s.version     = PsnTrophies::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Roger Leite"]
  s.email       = ["roger.barreto@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Parser for PSN Trophies site}
  s.description = %q{Parser for PSN Trophies site}

  s.rubyforge_project = "psn_trophies"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('nokogiri', '~> 1.5.0')
end
