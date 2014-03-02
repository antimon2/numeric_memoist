# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'numeric_memoist/version'

Gem::Specification.new do |spec|
  spec.name          = "numeric_memoist"
  spec.version       = NumericMemoist::VERSION
  spec.authors       = ["antimon2"]
  spec.email         = ["antimon2.me@gmail.com"]
  spec.description   = %q{The memoize library allows you to cache methods for Numerics (Integer/Float) in Ruby >= 2.0.0.}
  spec.summary       = %q{Memoize methods in Integer/Float}
  spec.homepage      = %q{https://github.com/antimon2/numeric_memoist}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.required_ruby_version = Gem::Requirement.new(">= 1.9.0")
end