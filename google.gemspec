# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David William"]
  gem.email         = ["david@webhall.com.br"]
  gem.description   = %q{Perform google searches from your terminal}
  gem.summary       = %q{Perform google searches from your terminal}
  gem.homepage      = "https://github.com/davidwilliam/google"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "google"
  gem.require_paths = ["lib"]
  gem.version       = Google::VERSION
  gem.add_dependency "mechanize", ">= 2.6.0"
  gem.add_dependency "paint", ">= 0.8.5"
end