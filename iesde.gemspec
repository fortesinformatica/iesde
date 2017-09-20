# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iesde/version'

Gem::Specification.new do |spec|
  spec.name          = "iesde"
  spec.version       = Iesde::VERSION
  spec.authors       = ["Pedro Benevides", "Heron Medeiros"]
  spec.email         = ["pedroaugusto@gmail.com", "heron.medeiros@gmail.com"]

  spec.summary       = "Client do WebService REST do IESDE"
  spec.description   = "Esta não é uma versão oficial"
  spec.homepage      = "https://github.com/fortesinformatica/iesde"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "savon", "~> 2.10"
  spec.add_dependency "json", "~> 1.7"
  spec.add_dependency "activesupport", ">= 5.0.1.rc1"
  spec.add_dependency "actionview"
  spec.add_dependency "net-http-digest_auth"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency 'simplecov'
end
