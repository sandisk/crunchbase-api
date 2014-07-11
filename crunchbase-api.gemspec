# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crunchbase-api/version'

Gem::Specification.new do |spec|
  spec.name          = "crunchbase-api"
  spec.version       = Crunchbase::VERSION
  spec.authors       = ["Sandis Klakovskis"]
  spec.email         = ["m@sandis.lv"]
  spec.summary       = %q{Wrapper for Crunchbase API v2}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
end
