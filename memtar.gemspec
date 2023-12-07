# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memtar/version'

Gem::Specification.new do |spec|
  spec.name          = "memtar"
  spec.version       = MemTar::VERSION
  spec.authors       = ["CyberArk", "Rafał Rzepecki", "Micah Lee"]
  spec.email         = ["conj_maintainers@cyberark.com"]
  spec.summary       = %q{In-memory tar archive creation}
  spec.homepage      = "https://github.com/conjurinc/memtar"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "minitar", "~> 0.9"

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake", "~> 13.1"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "spec", "~> 5.3"
  
end
